-module(nonInGameMsgHandle).

-include("pt_11.hrl").
-include("pt_25.hrl").
-include("pt_20.hrl").
-include("common_include/logger.hrl").
-include("globalDefine.hrl").
-include("version.hrl").
-include("playerDefine.hrl").
-include("chatDefine.hrl").
-include("errorCode.hrl").
-include("mapDefine.hrl").
-include("itemDefine.hrl").
-include("record.hrl").
-include("skillDefine.hrl").
-include("queueUser.hrl").
-include("crossDefine.hrl").
-include("platformDefine.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([on_C2GS_Login/2, get_serverid/0,
  on_C2GS_CreatePlayer/2,
  on_C2GS_EnterGame/2, on_C2GS_EnterMap/2,
  get_LS2GS_GetPlayerInfo/1, on_C2GS_DeletePlayer/2,
  on_C2GS_UserQueueLogin/2, on_C2GS_CannelQueue/1,
  on_C2GS_CrossGame_Req/2]).


sendDeletePlayerInfoToLS(Socket, AccountID) ->
  Msg = get_LS2GS_GetPlayerInfo(AccountID),
  pt_11:send(Socket, Msg),
  gen_server:cast(loginserver_PID, {sendMsg, Msg}).



on_C2GS_DeletePlayer(Socket, #pk_C2GS_DeletePlayer{playerID = PlayerID}) ->
  AccountID = get("RoleHandle_AccountID"),
  case league:getLeagueRecordByPlayerID(PlayerID) of
    {} ->
      case gameDbProcess:deletePlayer(AccountID, PlayerID) of
        true ->
          ServerID = get_serverid(),
          PlayerList = gameDbProcess:getPlayerList(AccountID, ServerID),
          put("RoleHandle_PlayerList", PlayerList),
          RetMsg = #pk_GS2C_DeletePlayer_Ret{retCode = ?rCode_Login_Succ, player_list = PlayerList},
          pt_25:send(Socket, RetMsg),
          sendDeletePlayerInfoToLS(Socket, AccountID),
          ?INFO(on_C2GS_DeletePlayer, "DeletePlayerID:~p", [PlayerID]);
        false ->
          ?INFO(on_C2GS_DeletePlayer, "AccountID:~p", [AccountID]),
          false
      end;
    _ ->
      RetMsg = #pk_GS2C_DeletePlayer_Ret{retCode = -1, player_list = []},
      pt_25:send(Socket, RetMsg)
  end.

%% 获取玩家在这个服务器的角色基础信息
get_LS2GS_GetPlayerInfo(AccountID) ->
  try
    ServerID = get_serverid(),
    PlayerList = gameDbProcess:getPlayerList(AccountID, ServerID),
    SortPlayerList = lists:keysort(#pk_UserPlayerData.level, PlayerList),
    %?DEBUG(get_LS2GS_GetPlayerInfo, "SortPlayerList:~p", [SortPlayerList]),
    case SortPlayerList of
      [] ->
        #pk_GS2LS_GetPlayerInfo_Ret{accountID = AccountID, userID = 0, isExist = 0, career = 0, sex = 0, level = 0, name = ""};
      _ ->
        Player = lists:last(SortPlayerList),
        #pk_GS2LS_GetPlayerInfo_Ret{
          accountID = AccountID,
          userID = Player#pk_UserPlayerData.playerID,
          isExist = 2,
          career = Player#pk_UserPlayerData.career,
          sex = Player#pk_UserPlayerData.sex,
          level = Player#pk_UserPlayerData.level,
          name = Player#pk_UserPlayerData.name
        }
    end
  catch
    Type:Error ->
      ?ERR(get_LS2GS_GetPlayerInfo, "Type:~p, Error:~p", [Type, Error]),
      #pk_GS2LS_GetPlayerInfo_Ret{userID = AccountID, isExist = 0, career = 0, sex = 0, level = 0, name = ""}
  end.


%% these function is revoked by tcp_reader process
on_C2GS_Login(Socket, #pk_C2GS_Login{serverId = ServerID, accountID = AccountID, sign = Sign, version = Version} = _Msg) ->
  try
    case get("RoleHandle_State") of
      undefined -> ok;
      _ -> throw({invalidState})
    end,


    %% check protocol version
    case Version >= myshare:get_env(server_accept_client_version_min) of
      true -> ok;
      false -> throw({invalidVersion})
    end,

%% 		%% check max count
%% 		case ets:info(?PlayerStateTableAtom, size) < myshare:get_env(server_accept_client_max_count) of
%% 			true -> ok;
%% 			false->	throw( {exceedmaxcount} )
%% 		end,

    %% check globle flag:is_forbid_login
    case myshare:get_env(is_forbid_login) of
      true -> throw({forbidLogin});
      _ -> ok
    end,


    ReadyLoginUser = loginServer:getReadyLoginUserRecord(AccountID),
    case ReadyLoginUser of
      {} -> throw({invalidAccount});
      _ -> ok
    end,

    case ReadyLoginUser#readyLoginUser.expireTime =< mytime:timestamp() of
      true -> throw({expired});
      _ -> ok
    end,

    case ReadyLoginUser#readyLoginUser.sign =:= Sign of
      false -> throw({invalidSign});
      true -> ok
    end,

    Plt = ReadyLoginUser#readyLoginUser.platId,
    ChannelId = ReadyLoginUser#readyLoginUser.channelId,
    AccID = ReadyLoginUser#readyLoginUser.accountID,
    Acc = ReadyLoginUser#readyLoginUser.account,
    Sign = ReadyLoginUser#readyLoginUser.sign,

    put("RoleHandle_AccountID", AccID),
    put("USerPlatFormID", Plt),
    erlang:put(readyLoginUserChannelId, ChannelId),
    put(serverid_tmp, ServerID),
    case ets:info(?PlayerStateTableAtom, size) >= myshare:get_env(server_accept_client_max_count) of
      true -> %%开始排队
        case queueUser:insertUserLoginQueue_rpc(AccountID, Sign) of %%进入排队中
          ?Queue_Full -> {queue, ?Queue_Full};
          {?Queue_In_Queue, Rank, TotalRank, RemainTime} ->
            put("RoleHandle_State", ?RoleHandle_State_InQueue),
            ?DEBUG(on_C2GS_Login, "user is in queue, accountId:~p", [AccountID]),
            {queue, {?Queue_In_Queue, Rank, TotalRank, RemainTime}};
          [Rank, TotalRank, DelayTime, Sign] ->
            put("RoleHandle_State", ?RoleHandle_State_InQueue),
            {queue, [Rank, TotalRank, DelayTime, Sign, Acc, Plt]}
        end;
      false ->
        case queueUser:checkUserLoginQueue_rpc(AccountID, Sign) of %%当服务器人数未满时，检查排队列表中是否还有玩家
          {true, QueueRet} ->
            case QueueRet of
              ?Queue_Full -> {queue, ?Queue_Full};
              {?Queue_In_Queue, Rank, TotalRank, RemainTime} ->
                put("RoleHandle_State", ?RoleHandle_State_InQueue),
                ?DEBUG(on_C2GS_Login, "user is in queue, accountId:~p", [AccountID]),
                {queue, {?Queue_In_Queue, Rank, TotalRank, RemainTime}};
              [Rank, TotalRank, DelayTime, Sign] ->
                put("RoleHandle_State", ?RoleHandle_State_InQueue),
                {queue, [Rank, TotalRank, DelayTime, Sign, Acc, Plt]}
            end;
          _ ->
            PlayerList = gameDbProcess:getPlayerList(AccountID, ServerID),
            RetMsg = #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Succ, player_list = PlayerList},
            pt_25:send(Socket, RetMsg),

            %% cast login server ,user login
            loginServer:sendLoginUserToLS(Plt, AccID, Acc, Sign, Socket),
            put("RoleHandle_State", ?RoleHandle_State_Login),
            put("RoleHandle_PlayerList", PlayerList),

            ?DEBUG(on_C2GS_Login, "accountID[~p] account[~p] PlayerList[~p] login succ.", [AccountID, Acc, PlayerList]),
            {checkLoginSuccess, AccountID}
        end
    end
  catch
    {invalidSign} ->
      ?INFO(on_C2GS_Login, "AccountID:~p invalidSign", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_InvalidSign, player_list = []}),
      {error, invalidSign};
    {expired} ->
      ?INFO(on_C2GS_Login, "AccountID:~p expired", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Expired, player_list = []}), {error, expired};
    {invalidAccount} ->
      ?INFO(on_C2GS_Login, "AccountID:~p invalidAccount", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_InvalidAccount, player_list = []}),
      {error, invalidAccount};
    {invalidVersion} ->
      ?INFO(on_C2GS_Login, "AccountID:~p invalidVersion", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_InvalidVersion, player_list = []}),
      {error, invalidVersion};
    {exceedmaxcount} ->
      ?INFO(on_C2GS_Login, "AccountID:~p exceedmaxcount", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Exceedmaxcount, player_list = []}),
      {error, exceedmaxcount};
    {forbidLogin} ->
      ?INFO(on_C2GS_Login, "AccountID:~p forbidLogin", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Forbid, player_list = []}), {error, forbidLogin};
    _ ->
      ?INFO(on_C2GS_Login, "AccountID:~p Exception", [AccountID]),
      pt_25:send(Socket, #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Exception, player_list = []}), {error, exception}
  end.

on_C2GS_CannelQueue(#pk_C2GS_CannelQueue{accountId = AccountId}) ->
  queueUser:cannelUserLoginQueue_cast(AccountId),
  {cannelQueue, AccountId}.

on_C2GS_UserQueueLogin(Socket, #pk_C2GS_UserQueueLogin{accountId = AccountId, plt = Plt, sign = Sign, acc = Acc} = _Msg) ->
  try
    put("RoleHandle_AccountID", AccountId),
    case ets:info(?PlayerStateTableAtom, size) < myshare:get_env(server_accept_client_max_count) of
      false ->
        case queueUser:insertUserLoginQueue_rpc(AccountId, Sign) of %%进入排队中
          ?Queue_Full -> {queue, ?Queue_Full};
          {?Queue_In_Queue, Rank, TotalRank, RemainTime} ->
            put("RoleHandle_State", ?RoleHandle_State_InQueue),
            ?DEBUG(on_C2GS_Login, "user is in queue, accountId:~p", [AccountId]),
            {queue, {?Queue_In_Queue, Rank, TotalRank, RemainTime}};
          [Rank, TotalRank, DelayTime, Sign] ->
            put("RoleHandle_State", ?RoleHandle_State_InQueue),
            {queue, [Rank, TotalRank, DelayTime, Sign, Acc, Plt]}
        end;
      true ->
        case queueUser:userLoginQueue_rpc(AccountId, Sign) of
          {false, QueueRet} ->
            case QueueRet of
              ?Queue_Full -> {queue, ?Queue_Full};
              {?Queue_In_Queue, Rank, TotalRank, RemainTime} ->
                put("RoleHandle_State", ?RoleHandle_State_InQueue),
                ?DEBUG(on_C2GS_Login, "user is in queue, accountId:~p", [AccountId]),
                {queue, {?Queue_In_Queue, Rank, TotalRank, RemainTime}};
              [Rank, TotalRank, DelayTime, Sign] ->
                put("RoleHandle_State", ?RoleHandle_State_InQueue),
                {queue, [Rank, TotalRank, DelayTime, Sign, Acc, Plt]}
            end;
          _ ->
            ServerID = get_serverid(),
            PlayerList = gameDbProcess:getPlayerList(AccountId, ServerID),
            RetMsg = #pk_GS2C_Login_Ret{retCode = ?rCode_Login_Succ, player_list = PlayerList},
            pt_25:send(Socket, RetMsg),

            %% cast login server ,user login
            loginServer:sendLoginUserToLS(Plt, AccountId, Acc, Sign, Socket),

            put("RoleHandle_State", ?RoleHandle_State_Login),
            put("RoleHandle_PlayerList", PlayerList),
            {checkLoginSuccess, AccountId}
        end
    end
  catch
    Type1:Error1 -> ?ERR(on_C2GS_UserQueueLogin, "Error! Type:~p,Reason:~p,AccountId:~p", [Type1, Error1, AccountId])
  end.

on_C2GS_CreatePlayer(Socket, #pk_C2GS_CreatePlayer{name = Name, career = Career, sex = Sex} = _Msg) ->
  try
    ?DEBUG(on_C2GS_CreatePlayer, "Msg ~p", [_Msg]),
%%  		case cross:isCrossGame() of
%%  			true -> throw( {crossCreateFail} );	%跨服战服务器，不可创建角色
%%  			false -> ok
%%  		end,
    %% check
    case get("RoleHandle_State") of
      ?RoleHandle_State_Login -> ok;
      _ -> erlang:throw({invalidState})
    end,

    %% should check name, career,sex,
    case Career of
      ?Career_ZhanShi -> ok;
      ?Career_DaoShi -> ok;
      ?Career_FaShi -> ok;
      _ -> erlang:throw({invalidCareer})
    end,

    case Sex of
      ?Sex_Female -> ok;
      ?Sex_Male -> ok;
      _ -> erlang:throw({invalidSex})
    end,
    NameLen = string:len(Name),
    case (NameLen < ?Min_CreatePlayerName_Len) or (NameLen > ?Max_CreatePlayerName_Len * 3) or check_name_character(Name) of
      true ->
        erlang:throw({invalidName});
      false ->
        case sensitive:isSensitiveWords(Name) of
          true ->
            erlang:throw({invalidName});
          _ ->
            ok
        end,
        ok
    end,

    AccountID = get("RoleHandle_AccountID"),
    PlayerCount = length(get("RoleHandle_PlayerList")),

    case PlayerCount >= ?MaxUserPlayerCount of
      true -> throw({invalidFull});
      false -> ok
    end,

    %% -> 0 or id  (0: mean not exist this player)
    case gameDbProcess:isPlayerExistByNameIncludeWithDeleteFlagPlayer(Name) of
      0 -> ok;
      _ -> throw({existName})
    end,

    %% insert to db
    PlayerID =
      case erlang:get(serverid_tmp) of
        IntegerServerId when erlang:is_integer(IntegerServerId) ->
          uniqueId:generateID(IntegerServerId, ?Object_Type_Player);
        _ ->
          uniqueId:generateID(?Object_Type_Player)
      end,
    case data_map:get_item(?PlayerBornMapDataId) of
      false -> MapCfg = {}, erlang:throw({noThisMap});
      MapCfg -> ok
    end,

    case gameDbProcess:get_internal(AccountID) of
      0 ->
        ignore;
      InternalPay when erlang:is_integer(InternalPay) andalso InternalPay > 0 ->
        erlang:put(internalPay, InternalPay);
      _ ->
        ignore
    end,

    {Player, FightPlayer} = playerAssist:makeNewPlayer(PlayerID, AccountID, Name, Career, Sex),
    Now = mytime:timestamp(),
    PlatSendItemBits = playerAssist:initialize_gm_cmd(PlayerID, <<>>),

    PlatFormID =
    case get("USerPlatFormID") of
      undefined ->
        0;
      PlatFormID1 when erlang:is_integer(PlatFormID1) ->
        PlatFormID1;
      _ ->
        0
    end,
    ChannelId =
      case erlang:get(readyLoginUserChannelId) of
        Integer when Integer > 0 ->
          Integer;
        _ ->
          0
      end,

    {TotalTreasure, BindTreasure, Coin}  =
    case PlatFormID of
      Platform996 when Platform996 =:= ?PLATFORM_SIFU_996_FangYou orelse Platform996 =:= ?PLATFORM_SIFU_996
        orelse Platform996 =:= ?PLATFORM_SIFU_195 orelse Platform996 =:= ?PLATFORM_SIFU_195_1 orelse Platform996 =:= ?PLATFORM_SIFU_DAMAI ->
        VipCfg = data_vip_996:get_item( #vip_996Cfg.viplevel, 5),
        {VipCfg#vip_996Cfg.money + Player#player.totaltreasure,
          5000 + Player#player.bindTreasure,
          500000 + Player#player.coin} ;
      _ ->
        {Player#player.totaltreasure,
          Player#player.bindTreasure,
          Player#player.coin}
    end,


    PlayerNew = Player#player{
      mapDataId = ?PlayerBornMapDataId,
      x = MapCfg#mapCfg.bornx,
      y = MapCfg#mapCfg.borny,
      totaltreasure = TotalTreasure,
      bindTreasure = BindTreasure,
      coin = Coin,
      registerTime = Now,
      createTime = Now,
      lastOnlineTime = Now,
      lastOfflineTime = Now,
      loginIp = "",%% will add
      isOnline = 0,
      leagueId = 0,
      platSendItemBits = PlatSendItemBits,
      lastUpgradeTime = Now,
      lastUpgradeCostTime = 0,
      limitbuytime = 0,
      limitbuydata = []
    },

    ?INFO(on_C2GS_CreatePlayer, "born data id:~p,bornx:~p,borny:~p", [?PlayerBornMapDataId, MapCfg#mapCfg.bornx, MapCfg#mapCfg.borny]),
    BagGridNum = ?Bag_FreeGridNum,
    BagDataArray = array:new([{fixed, false}]),


    ShortcutList = [#pk_ShortcutInfo{index = 12, type = ?Shortcut_Type_Skill, id = ?NORMAL_ATTACK_ID}],
    AcceptTaskList = [], RepeatCompletedTaskList = [], SingleCompletedTaskList = <<>>,
    FriendIdList = [],
    CopyCDInfoList = [], ActivedHighCopyList = [], NextResetTimePerday = 0,

    case gameDbProcess:insertPlayerGamedata(PlayerNew, FightPlayer, BagGridNum, BagDataArray,
      ShortcutList, AcceptTaskList, RepeatCompletedTaskList, SingleCompletedTaskList, FriendIdList,
      CopyCDInfoList, ActivedHighCopyList, NextResetTimePerday, PlatFormID, ChannelId) of
      {error, _Result} -> throw({insertDBerror});
      _ -> ok
    end,

    PlayerData = #pk_UserPlayerData{playerID = PlayerID, name = Name, level = 1, career = Career, sex = Sex},
    pt_25:send(Socket, #pk_GS2C_CreatePlayer_Ret{retCode = ?rCode_CreatePlayer_Succ, player_list = [PlayerData]}),

    PlayerList = [PlayerData | get("RoleHandle_PlayerList")],
    put("RoleHandle_PlayerList", PlayerList),
    ?DEBUG("on_C2GS_CreatePlayer", "RoleHandle_PlayerList is: ~p", [get("RoleHandle_PlayerList")]),
    gameDbProcess:update_internal(AccountID),
    sendDeletePlayerInfoToLS(Socket, AccountID),
    ok
  catch
    {invalidFull} ->
      pt_25:send(Socket, #pk_GS2C_CreatePlayer_Ret{retCode = ?rCode_CreatePlayer_Full, player_list = []}), ok;
    {invalidName} ->
      pt_25:send(Socket, #pk_GS2C_CreatePlayer_Ret{retCode = ?rCode_CreatePlayer_Name_Invalid, player_list = []}), ok;
    {existName} ->
      pt_25:send(Socket, #pk_GS2C_CreatePlayer_Ret{retCode = ?rCode_CreatePlayer_Name_Exist, player_list = []}), ok;
    Other ->
      ?ERR(on_C2GS_CreatePlayer, "fail, other:~p", [Other]),
      pt_25:send(Socket, #pk_GS2C_CreatePlayer_Ret{retCode = ?rCode_CreatePlayer_Exception, player_list = []}), ok
  end.

on_C2GS_EnterGame(_Socket, #pk_C2GS_EnterGame{playerID = PlayerID} = _Msg) ->
  %?DEBUG(on_C2GS_EnterGame,"recv msg C2GS_EnterGame,PlayerID:~p,Socket:~p",[PlayerID,Socket]),
  case get("RoleHandle_State") of
    ?RoleHandle_State_Login ->
      case gameDbProcess:isPlayerExistByIdAndUserId(PlayerID, get("RoleHandle_AccountID")) of
        0 ->
          ?ERR(on_C2GS_EnterGame, "playerNotExist,PlayerID:~p", [PlayerID]),
          {error, playerNotExist};
        _ ->
          put("RoleHandle_State", ?RoleHandle_State_InGame),
          {enterGame, PlayerID}
      end;
    RoleHandleState ->
      ?ERR(on_C2GS_EnterGame, "invalidState:~p,PlayerID:~p", [RoleHandleState, PlayerID]),
      {error, invalidState}
  end.


on_C2GS_EnterMap(Socket, #pk_C2GS_EnterMap{}) ->
  %?DEBUG(on_C2GS_EnterMap,"recv msg C2GS_EnterMap,socket:~p",[Socket]),
  case get("RoleHandle_State") of
    ?RoleHandle_State_InGame ->
      put("RoleHandle_State", ?RoleHandle_State_InMap),
      {enterMap};
    RoleHandleState ->
      ?ERR(on_C2GS_EnterMap, "invalidState:~p,Socket:~p", [RoleHandleState, Socket]),
      {error, invalidState}
  end.

on_C2GS_CrossGame_Req(_Socket, _) ->
  ok.
%% ====================================================================
%% Internal functions
%% ====================================================================


%% 检测名字中有没有不合法的特殊字符(单个字符utf8编码超过3个字节)
check_name_character(Name) ->
  NameBin = list_to_binary(Name),
  %%NameBin =list_to_binary([240,159,152,132]) ,
  ?DEBUG(name, " name binary = ~p", [NameBin]),
  BLen = byte_size(NameBin),
  do_check(0, NameBin, BLen).

do_check(I, NameBin, Blen) when I < Blen ->
  Bin = binary:at(NameBin, I),
  if
    Bin > 239 ->
      true;
    true ->
      do_check((I + 1), NameBin, Blen)
  end;
do_check(_, _, _) ->
  false.

get_serverid() ->
  case get(serverid_tmp) of
    undefined ->
      0;
    Value ->
      Value
  end.

-module(playerAssist).

-include("common_include/logger.hrl").
-include("playerDefine.hrl").
-include("pt.hrl").
-include("globalDefine.hrl").
-include("mapDefine.hrl").
-include("itemDefine.hrl").
-include("skillDefine.hrl").
-include("playerProcDictKey.hrl").
-include("gamedatadb.hrl").
-include("achievement.hrl").
-include("npc.hrl").
-include("record.hrl").
-include("team.hrl").
-include("leagueDefine.hrl").
-include("activity.hrl").
-include("variant.hrl").
-include("pet.hrl").
-include("arena.hrl").
-include("common_include/mysql.hrl").
-include("expLog.hrl").
-include("platformDefine.hrl").
-include("serverStr.hrl").

-define(RoleHandle_PlayerBornMapDataId, 10).

-export([sendMsgToMap/1,
  playerEnterGame/1,
  updatePlayerKillScore/1,
  sendTradeMsgToPlayerByPlayerID/2,
  setCurPlayerProperty/2,
  setCurPlayerRecord/1,
  sendToPlayerByPlayerID/2,
  sendToPlayerByPlayerID/3,
  getCurPlayerProperty/1,
  sendToPlayerNeedSpecialHandle/3,
  savePlayerAll/3,
  makeNewPlayer/5,
  sendMsgToTeamMembers/4,
  sendMsgToGuildMembers/4]).

-export([getCurPlayerID/0,
  getCurPlayerAccountId/0,
  getPlayerPID/1,
  getPlayerSendPID/1,
  getCurPlayerSendPid/0,
  getCurPlayerName/0,
  getCurPlayerRecord/0,
  getCurPlayerOnlineSeconds/0,
  getCurPlayerPos/0,
  getCurPlayerMapPos/0,
  getPlayerPos/1,
  getObjectPos/1,
  getMapNpc/1,
  getVirtualPlayerInfo/0,
  getCurPlayerMapPID/0,
  getCurPlayerMapFightPID/0,
  getCurPlayerMapAIPID/0,
  verifyDistanceWithNpc/1,
  verifyTradeDistanceWithOtherPlayer/1,
  check_gm_cmd/0,
  initialize_gm_cmd/2,
  logPlayerMap/1,
  sendMsgToPlayerProcByPlayerID/2]).


-export([getPlayerRecord/1,
  getPlayerRecord/2,
  getAsynPlayerRecord/3,
  getPlayerStateOrRecord/1,
  getPlayerState/1,
  getPlayerVipLevel/1,
  getPlayerName/2,
  getPlayerBagDataByPlayerID/1,
  getPlayerBagGridNum/1,
  getPlayerHpAndMaxHp/0,
  getItems/1,
  resetSomeInfo/1,
  getMapObject/1,
  getMapFightObject/1,
  verifyDistanceWithItemForPickup/1,
  verifyDistanceWithGatherObject/1,
  getPlayerById/1,
  getPlayerByName/1,
  getPlayerAccountId/1,
  getPrePosition/0,
  backPrePosition/0,
  getPlayerLevel/2,
  send_pay_info/0]).

-export([playerInfo2LoginServer/0,
  makeDeleteplayerInfo2LoginServer/2,
  playerIsOnline/1,
  get_online_player/1,
  outGame/0]).

-export([getKillPeople/0,
  setKillPeople/1,
  increKillPeople/0,
  getExpScrollRate/0,
  getPayInfoList/0,
  getPayInfoList/1,
  getPayNth/0,
  getMoneyNth/0,
  sendServerTime/0]).

-export([% otherFight/1,
  addFightPartEquip/2,
  addFightPartEquip/3,
  decFightPartEquip/2,
  updatePlayerCurseLucky/1,
  sendDownMailByLevel/1,
  getCurAttachInfoProperty/1,
  setCurAttachInfoProperty/2]).

-export([getSameMapPlayerIdList/0,
  msgReqHurtUiInfo/0,
  resetHurtTime/0]).

-export([modifySkillPoints/1]).

-export([execute_in_player/2]).

-export([getEquipOpenHoleNum/1, addEquipOpenHoleNum/1]).

%% 获取杀人数量
getKillPeople() ->
  case get(?Kill_People_Num) of
    undefined -> 0;
    Num -> Num
  end.

%% 设置杀人数量
setKillPeople(Num) ->
  put(?Kill_People_Num, Num).

%% 增加杀人数量
increKillPeople() ->
  Num = getKillPeople() + 1,
  setKillPeople(Num).

getCurPlayerSendPid() ->
  case get('PlayerState') of
    undefined -> 0;
    PlayerState ->
      PlayerState#player_state.sendPid
  end.


%% 离开游戏
%% call by player process
%% 还有问题，socket 没有正常的关闭掉
outGame() ->
  PlayerId = getCurPlayerID(),
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      ?DEBUG(outGame, "no this player");
    PlayerState ->
      player:onKick(PlayerState, ?PlayerKick_Type_Other, "player get out game"),
      self() ! {quit}
  end.

%% @return false or {true,#player_gamedata}
%% getVirtualPlayerInfo()->
%% 	%% hard code 9170637366951936
%% 	%% VirtualPlayerId = 9170637366951936,
%% 	case get(?Player_Arena_MirrorPlayerId) of
%% 		undefined ->
%% 			VirtualPlayerId = 0;
%% 		VirtualPlayerId ->
%% 			VirtualPlayerId
%% 	end,
%% 	
%% 	?DEBUG(getVirtualPlayerInfo, "============VirtualPlayerId=~p", [VirtualPlayerId]),
%% 	
%% 	case gameDbProcess:get_playerGamedata_list_by_id(VirtualPlayerId) of
%% 		[]->
%% 			?ERR(getVirtualPlayerInfo,"no the player id:~p",[VirtualPlayerId]),
%% 			false;
%% 		[PlayerGamedata|_]->
%% 			case playerAssist:getCurPlayerID() == VirtualPlayerId of
%% 				true ->
%% 					{true, setelement(#player_gamedata.name,PlayerGamedata,?Configure_Arena_Player_Name)};
%% 				false ->
%% 					{true,PlayerGamedata}
%% 			end
%% 	end.
getVirtualPlayerInfo() ->
  case get(?Player_Arena_MirrorPlayerId) of
    undefined ->
      false;
    {?ArenaTypePlayer, PlayerID} ->
      case gameDbProcess:get_playerGamedata_list_by_id(PlayerID) of
        [PlayerGamedata | _] ->
          case playerAssist:getCurPlayerID() of
            PlayerID ->
              {true, PlayerGamedata#player_gamedata{name = ?Configure_Arena_Player_Name}, PlayerID};
            _ ->
              {true, PlayerGamedata, PlayerID}
          end;
        [] ->
          false
      end;
    {?ArenaTypeMonster, RankID} ->
      case ets:lookup(?Arena_Info_Ets, RankID) of
        [] -> false;
        [#arena_info{type = ?ArenaTypeMonster, robot_data = RobotData} | _] ->
          {true, RobotData, RankID};
        [#arena_info{type = ?ArenaTypePlayer, playerid = PlayerID}] ->
          case gameDbProcess:get_playerGamedata_list_by_id(PlayerID) of
            [PlayerGamedata | _] ->
              case playerAssist:getCurPlayerID() of
                PlayerID ->
                  {true, PlayerGamedata#player_gamedata{name = ?Configure_Arena_Player_Name}, RankID};
                _ ->
                  {true, PlayerGamedata, RankID}
              end;
            [] ->
              false
          end
      end
  end.


%% 获取玩家是否在线
%% @para PlayerId
%% @return 0 | 1
playerIsOnline(PlayerId) ->
  case get_online_player(PlayerId) of
    undefined ->
      0;
    _ ->
      1
  end.

%% 获取在线玩家数据
get_online_player(PlayerId) ->
  PlayerState = etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId),
  case PlayerState of
    {} ->
      undefined;
    _ ->
      PlayerState
  end.

%% 返回文件的信息给登陆服务器 当玩家下线时
%% call by player process
%% 
playerInfo2LoginServer() ->
  case playerAssist:getCurPlayerRecord() of
    undefined ->
      #pk_GS2LS_GetPlayerInfo_Ret{accountID = 0, userID = 0, isExist = 0, career = 0, sex = 0, level = 0, name = ""};
    Player ->
      #pk_GS2LS_GetPlayerInfo_Ret{
        accountID = Player#player.userId,
        userID = Player#player.id,
        isExist = 1,
        career = Player#player.career,
        sex = Player#player.sex,
        level = Player#player.level,
        name = Player#player.name
      }
  end.

%% 删除角色的时候
makeDeleteplayerInfo2LoginServer(AccountID, UserID) ->
  #pk_GS2LS_GetPlayerInfo_Ret{accountID = AccountID, userID = UserID, isExist = 0, career = 0, sex = 0, level = 0, name = ""}.


%% 玩家返回上一次进入的地图点
%% @return true or false
backPrePosition() ->
  Player = playerAssist:getCurPlayerRecord(),
  case getPrePosition() of
    undefined ->
      playerChangeMap:comeBackHome();
    {MapDataID, X, Y} ->
      ?DEBUG(backPrePosition, "MapDataID:~p, X:~p, Y:~p", [MapDataID, X, Y]),
      playerChangeMap:switchMap(Player, MapDataID, X, Y, ?Enter_Type_Normal)
  end.

%%获取玩家最近的位置点
%% @return undefined or {MapDataId, PosX, PosY}
getPrePosition() ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_LastMapPos).
%% 	get(?Player_Pre_Position).

makeNewPlayer(PlayerID, AccountID, Name, Career, Sex) ->
  fansList:update_names(PlayerID, Name, Career, Sex),
  Level = 1,
  PropertyId = charPropertyMod:getPlayerPropId(Level, Career),
  PlayerProperty = data_playerProperty:get_item(#playerPropertyCfg.id, PropertyId),
  case PlayerProperty of
    false ->
      ?ERR(makePlayer, "can't find player property config data,Level:~p,Career:~p", [Level, Career]),
      _HP = 1,
      _MP = 1;
    _ ->
      _HP = PlayerProperty#playerPropertyCfg.hp,
      _MP = PlayerProperty#playerPropertyCfg.mp
  end,

  SkillList = [#playerSkill{id = ?NORMAL_ATTACK_ID, cdtime = 0}],

  {Treasure, TotalTreasure, Money1} =
  case erlang:get(internalPay) of
    undefined ->
      {0, 0, 0 };
    Money when erlang:is_integer(Money) ->
      {Money*20, Money*10, Money};
    _ ->
      {0, 0, 0 }
  end,

  EquipDataArrayInit = array:new([{size, ?Equip_Part_Count}, {fixed, false}]),
  EquipDataArray = initializeItemArray(39383, 1, ?Equip_Part_Medal, EquipDataArrayInit), %%初始化勋章, 初始化不穿衣服.
  Player = #player{id = PlayerID,
    userId = AccountID,
    name = Name,
    career = Career,
    sex = Sex,
    level = 1,
    treasure = Treasure,
    totaltreasure = TotalTreasure,

%%     totaltreasure = 680,  %% 私服yf
%%     bindTreasure = 38888,
%%     bindCoin = 5000000,

%%     totaltreasure = 1980,  %% 私服996
%%     bindTreasure = 5000,
%%     bindCoin = 500000,

    equipDataArray = EquipDataArray,
    warehouseArray = array:new([{size, ?WareHouse_GridNum}, {fixed, false}]),
    minehouseArray = array:new([{fixed, false}]),
    enchaseDataArray = array:new([{size, ?Equip_Part_Count}, {fixed, false},
      {default, array:new([{size, ?Equip_Part_Stone_Num}, {fixed, false}])}]),
    varArray = variant:makeNewVar(Money1),
    skillList = SkillList
  },

  %BuffList = [],
  PropertiesBase = fightMod:calPlayerBaseProperties(Career, Player#player.level, 0),
  {PropertiesEquip, PropertiesEquipPercent} = fightMod:calEquipArrayProperties(Player#player.equipDataArray),
  {PropertiesSkill, PropertiesSkillPercent} = {#mapFightProperties{}, #mapFightProperties{}},
  {PropertiesBuff, PropertiesBuffPercent} = {#mapFightProperties{}, #mapFightProperties{}},

  FightPlayer = #mapFightPlayer{
    id = Player#player.id,
    objType = ?Object_Type_Player,
    stateFlag = 0,
    level = Player#player.level,
    hp = PropertiesBase#mapFightProperties.hpMax + PropertiesEquip#mapFightProperties.hpMax,
    mp = PropertiesBase#mapFightProperties.mpMax + PropertiesEquip#mapFightProperties.mpMax,
    pk = 0,
    buffList = [],
    fightPropertiesBase = PropertiesBase,
    fightPropertiesEquipment = PropertiesEquip,
    fightPropertiesEquipmentPercent = PropertiesEquipPercent,
    fightPropertiesSkill = PropertiesSkill,
    fightPropertiesSkillPercent = PropertiesSkillPercent,
    fightPropertiesBuff = PropertiesBuff,
    fightPropertiesBuffPercent = PropertiesBuffPercent
  },
  {Player, FightPlayer}.

%% player process revoke it 
sendMsgToMap(Msg) ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?INFO(sendMsgToMap, "mapPID error,is 0", []),
      ok;
    PlayerMapDynamicInfo ->
      PlayerMapDynamicInfo#playerMapDynamicInfo.mapPID ! Msg
  end.

%%返回玩家所在进程PID
getPlayerSendPID(PlayerID) ->
  etsBaseFunc:getRecordField(?PlayerStateTableAtom, PlayerID, #player_state.sendPid).

%%返回玩家所在进程PID
getPlayerPID(PlayerID) ->
  etsBaseFunc:getRecordField(?PlayerStateTableAtom, PlayerID, #player_state.pid).

%% 通过玩家Id查找玩家记录
getPlayerById(PlayerID) ->
  etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerID).

%% 通过玩家Name查找玩家记录
getPlayerByName(Name) ->
  case ets:match_object(?PlayerStateTableAtom, #player_state{name = Name, _ = '_'}) of
    [] ->
      {};
    [R | _] ->
      R
  end.

getPlayerAccountId(PlayerId) ->
  etsBaseFunc:getRecordField(?PlayerStateTableAtom, PlayerId, #player_state.accountId).

%% non-player process revoke it
%% sendToPlayerByPid(PlayerPID,Cmd,Msg) ->
%% 	case PlayerPID of
%% 		0->?WARNING(sendToPlayerByPid,"pid is zero,Cmd:~p",[Cmd]);
%% 		_->PlayerPID ! { msgSendToPlayer,Cmd, Msg }
%% 	end.
%%

%% non-player process revoke it

sendToPlayerByPlayerID(PlayerID, Data) ->
  Cmd = pt:get(erlang:element(1, Data)),
  sendToPlayerByPlayerID(PlayerID, Cmd, Data).
sendToPlayerByPlayerID(PlayerID, Cmd, Data) ->
  PID = getPlayerSendPID(PlayerID),
  case PID of
    0 ->
      ok;
    _ ->
      playerSend:sendToPlayerSendByPid(PID, Cmd, Data)
  end.

sendToPlayerNeedSpecialHandle(PlayerID, Cmd, Data) ->
  case getPlayerPID(PlayerID) of
    0 -> ?INFO(sendToPlayerNeedSpecialHandle, "pid is zero");
    PlayerPID -> PlayerPID ! {msgSendNeedSpecialHandle, Cmd, Data}
  end.



sendTradeMsgToPlayerByPlayerID(PlayerID, Msg) ->
  PlayerPID = getPlayerPID(PlayerID),
  PlayerPID ! {trade, Msg}.

sendMsgToPlayerProcByPlayerID(PlayerID, Msg) ->
  PlayerPID = getPlayerPID(PlayerID),
  case PlayerPID of
    0 ->
      false;
    _ ->
      PlayerPID ! Msg,
      true
  end.


%% -> true or false
playerEnterGame(#player_state{id = PlayerID, socket = _Socket}) ->

  [PlayerGamedata | _] = gameDbProcess:get_playerGamedata_list_by_id(PlayerID),

  PlayerTemp = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
  PlayerTemp1 = case PlayerTemp#player.attrMax of
                  {} ->
                    PlayerTemp#player{attrMax = #playerAttrMax{}};
                  _ ->
                    PlayerTemp
                end,
  Now = mytime:timestamp(),
  Player = PlayerTemp1#player{skillList = playerSkill:makeSkillListForUse(PlayerTemp1#player.skillList),
    lastOnlineTime = Now, pet = petMod:adjustPetWhenOnline(PlayerTemp1#player.pet)},
%% 	PlayerTemp3 = setelement( #player.lastOnlineTime, PlayerTemp2, Now ),

  %%initFightPart(Player),
  BuffList = playerBuffer:makeBufferListForUse(PlayerGamedata#player_gamedata.buffer_list),
  FightPlayer = playerMapFight:makeMapFightPlayerWhenOnline(PlayerGamedata, BuffList, playerAssist:getCurPlayerSendPid()),
  BagGridNum = PlayerGamedata#player_gamedata.bagGridNum,
  BagDataArray0 = PlayerGamedata#player_gamedata.bagDataArray,
  EquipDataArray0 = PlayerGamedata#player_gamedata.equipDataArray,
  {BagDataArray, EquipDataArray} = bagMod:onlineCleanExpire(BagDataArray0, EquipDataArray0),
  ShortCutList = PlayerGamedata#player_gamedata.shortcutList,
  AcceptTaskList = PlayerGamedata#player_gamedata.acceptTaskList,
  RepeatCompletedTaskList = PlayerGamedata#player_gamedata.repeatCompletedTaskList,
  SingleCompletedTaskList = PlayerGamedata#player_gamedata.singleCompletedTaskList,
  FriendIdList = PlayerGamedata#player_gamedata.friendIdList,

  CopyCDInfoList = PlayerGamedata#player_gamedata.copyCDInfoList,
  ActivedHighCopyList = PlayerGamedata#player_gamedata.activedHighCopyList,
  NextResetTimePerday = PlayerGamedata#player_gamedata.nextResetTimePerday,

  ?DEBUG(playerEnterGame, "get data from db success [~p]", [PlayerID]),
  Player2 = Player#player{equipDataArray = EquipDataArray},
  Player_AttachInfo = gameDbProcess:onlineInitAttachInfo(PlayerID),

  onPlayerOnline(Player2, FightPlayer, BagGridNum, BagDataArray, ShortCutList, AcceptTaskList, RepeatCompletedTaskList, SingleCompletedTaskList, FriendIdList,
    CopyCDInfoList, ActivedHighCopyList, NextResetTimePerday, Now, BagDataArray0, Player_AttachInfo).

%% local function
%%玩家上线初始化 -> true or false

onPlayerOnline(Player, FightPlayer, BagGridNum, BagDataArray, ShortcutList, AcceptTaskList, RepeatCompletedTaskList, SingleCompletedTaskList, _FriendIdList,
    CopyCDInfoList, ActivedHighCopyList, NextResetTimePerday, Now, _OldBagDataArray, Player_AttachInfo) ->
  erlang:put(?Player_PlayerID, Player#player.id),
  erlang:put(?Player_PlayerName, Player#player.name),
  erlang:put(?Player_CurPlayerRecord, Player),
  erlang:put(?Player_PlayerFight_Tmp, FightPlayer),

  erlang:put(?Player_PlayerMapDynamicInfo, #playerMapDynamicInfo{}),
  erlang:put(?Player_BagGridNum, BagGridNum),
  erlang:put(?Player_BagDataArray, BagDataArray),
  erlang:put(?Player_ShortcutList, ShortcutList),
  erlang:put(?Player_AcceptTaskList, AcceptTaskList),
  erlang:put(?Player_RepeatCompletedTaskList, RepeatCompletedTaskList),
  erlang:put(?Player_SingleCompletedTaskList, SingleCompletedTaskList),

  erlang:put(?Player_CopyCDInfoList, CopyCDInfoList),
  erlang:put(?Player_ActivedHighCopyList, ActivedHighCopyList),
  erlang:put(?Next_Reset_Time_Perday, NextResetTimePerday),

  erlang:put(?Player_SaleTrade_FindTime, 0),
  erlang:put(?Player_AttachInfo, Player_AttachInfo),
  saleTradeMod:resetPlayerSaleTradeInfo(),
  %% 初始化玩家的组队信息
  teamMod:setTeamFlagOnline(),

  ?DEBUG(onPlayerOnline, "Player_CopyCDInfoList111=~p, NextResetTimePerday=~p", [CopyCDInfoList, NextResetTimePerday]),

%% 	erlang:put("data", 0),
%% 	case logdbProcess:get_log_player_pay_record_by_playerid(Player#player.id) of
%% 		[] -> ok;
%% 		PayTreasureList ->
%% 			variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip7DayTotalPay_Award, []),
%% 			Fun = fun(R) ->
%% 						  [PayTreasure] = R,
%% 						  erlang:put("data", PayTreasure+get("data"))
%% 				  end,
%% 			lists:foreach(Fun, PayTreasureList)
%%   	end,
%% 	PaySevenTreasure = get("data"),
%% 	case PaySevenTreasure > 0 of
%% 		true -> vipModSevenDay:addSevenDayPayList(PaySevenTreasure);
%% 		false -> ok
%% 	end,

  resetSomeInfoWhenOnline(),

  %% 每次玩家登陆检查任务完成数量是否有更新（跟data_task比较）
  taskMod:checkAndupdateTaskTarget(),

  %% 确保玩家帮会与league进程中帮会一致
  league:checkPlayerLeague(Player#player.id, Player#player.leagueId),
  %% 开启帮会Pk的消耗
  leagueAssist:sendLeaguePkCost(),
  %% leagueAssist:sendOpenLeaguePkList(Player#player.id),
  leagueAssist:sendLeaguePkStateList(Player#player.id),

  case league:getLeagueRecordByLeagueID(Player#player.leagueId) of
    {} ->
      LeagueName = "";
    LeagueData ->
      LeagueName = LeagueData#league_state.name
  end,

  %% will get league name info
  %% LeagueName = "",
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      NewInfo = #playerMapDynamicInfo{leagueName = LeagueName};
    OldInfo ->
      NewInfo = OldInfo#playerMapDynamicInfo{leagueName = LeagueName}
  end,
  erlang:put(?Player_PlayerMapDynamicInfo, NewInfo),

  %% maybe can change to one rpc to improve performance
%% 	main:changePlayerState_cast(Player#player.id, #player_state.name, Player#player.name),
%% 	main:changePlayerState_cast(Player#player.id, #player_state.level, Player#player.level),
%% 	main:changePlayerState_cast(Player#player.id, #player_state.career, Player#player.career),
%% 	main:changePlayerState_cast(Player#player.id, #player_state.sex, Player#player.sex),
%% 	main:changePlayerState_cast(Player#player.id, #player_state.createTime, Player#player.createTime),
  %%
  Hp = erlang:max(FightPlayer#mapFightPlayer.hp, 0),
  case Hp =:= 0 of
    true->
      KillerName1 = case etsBaseFunc:readRecord(?GlobalKillerName, Player#player.id) of
                     {_,KillerName}->
                        KillerName;
                     _->
                        ?FightKillName
                   end,
      player:send(?CMD_GS2C_killerName, #pk_GS2C_killerName{killname = KillerName1});
    false->
      ok
  end,
  FightProperties = FightPlayer#mapFightPlayer.fightProperties,
  HpMax = FightProperties#mapFightProperties.hpMax,
  #player{id = Id, name = Name, level = Level, career = Career,
    sex = Sex, createTime = CreateTime, fightingCapacity = FightingCapacity,leagueId =  LeagueId} = Player,
  VipLevel = vipMod:vipLevel(),
  main:changePlayerState_cast(Id, [
    {#player_state.name, Name},
    {#player_state.level, Level},
    {#player_state.career, Career},
    {#player_state.sex, Sex},
    {#player_state.createTime, CreateTime},
    {#player_state.hp, Hp},
    {#player_state.hpMax, HpMax},
    {#player_state.fightingCapacity, FightingCapacity},
    {#player_state.vipLevel, VipLevel},
    {#player_state.leagueId, LeagueId}
  ]),
  mainPID ! {playerOnline, Player#player.id},

  %% first 发送人物属性给客户端
  charPropertyMod:sendPropertiesToClient(Player, FightPlayer),

  %% 玩家加入的帮会ID
  %% erlang:put(?Player_League, LeagueId),

  %% friendlist
%% 	erlang:put(?Player_FriendIdList, FriendIdList),
%% 	friendMod:getfriendinfolist(),
  %% send friend info to client
  friendMod:friendList(),


  %% task
  taskMod:autoAcceptfirstTask(),

  %% player leagueId
  league:sendPlayerLeague(Player#player.id),

  %% 发送物品信息至客户端
  bagMod:getItems(),
  %% 发送仓库信息至客户端
  wareHouseMod:getItems(),
  %% 发送左手空间戒指信息至客户端
  itemArrayForSpaceRingMod:getItems(?Equip_Part_LeftFinger),
  %% 发送右手空间戒指信息至客户端
  itemArrayForSpaceRingMod:getItems(?Equip_Part_RightFinger),

  %% 发送所有部位的开孔情况
  equipModOpenHole:getAllPartHoleNum(),

  %% 返回单笔充值奖励的数据
  vipModEachPay:sendEachMsgs(),
  %% 返回累计充值的奖励
  vipModTotalPay:sendTotalMsgs(),
  %% 返回七天返利的
  vipModSevenDay:sendSevenMsg(),

  %% send player preference info
  player:send(?CMD_GS2C_Preference_Set_Info, #pk_GS2C_Preference_Set_Info{teamSet = Player#player.teamSet}),
  %% send shortcut to client

  %% 发送任务信息到客户端
  taskMod:sendTaskInfo(),

  send_pay_info(),

  %% 初始化玩家每日充值奖励变量
  case vipMod:isGetEveryDayPay() of
    undefined ->
      case Player#player.platformID =:= 201 of  %%只能是Ios正版用户才可以
        true ->
          vipMod:setEveryDayPay(0);
        false ->
          ok
      end;
    _ ->
      ok
  end,

  %%	如果设置了新建角色玩家可以领取首充礼包，就将首充礼包设置为可以领取状态
  case vipMod:getFirstPayState() of
    true ->
      vipMod:setFirstPay();
    false ->
      ok
  end,
  %%
  petMod:sendPetInfo(),
  petMod:init_petModel(),

  copyCdMod:sendAllCopyCDInfoAndActivedHighCopy(),

  variant:sendVarArray(),
  variant:sendWorldVarArray(),
  player:send(?CMD_GSWithC_Shortcuts, #pk_GSWithC_Shortcuts{shortcutInfos = ShortcutList}),
  %%签到
  signInMod:online(),
  liveness:onlineSendLiveInfo(),
  limitBuy:onlineLimitBuyState(),
  %%邮件
  mailMgrMod:online(Player#player.id),

  %%离线经验
  offLineExpMod:offlineExp(),
  payRelated:onlineSendRelatedActive(),
  %% 开服奖励
%% 	case openServerAwardMod:check_start_openserver_award(Player#player.createTime) of
%% 		true ->
  openServerAwardMod:set_award_day(Player#player.createTime),
%% 		false ->
%% 			variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_OpenServer_NowDay, 99)
%% 	end,
  ?DEBUG(copyModisCopyMap, "the map id = ~p~n", [Player#player.mapDataId]),
  case copyMod:isCopyMap(Player#player.mapDataId) of
    true ->
      %% player is in copy map, maybe change map, so set mapDataId=0, then client will not pre load map
      MapCfg = data_map:get_item(Player#player.mapDataId),
      if
        MapCfg#mapCfg.type =:= ?Map_Type_EquipEnvy_Copy ->
          ?DEBUG(copyModisCopyMap, "the map type = ~p~n", [MapCfg#mapCfg.type]),
          player:send(?CMD_GS2C_SendPlayerDataComplete, #pk_GS2C_SendPlayerDataComplete{mapDataId = MapCfg#mapCfg.homemapid, x = MapCfg#mapCfg.bornx, y = MapCfg#mapCfg.bornx});
        true ->
          player:send(?CMD_GS2C_SendPlayerDataComplete, #pk_GS2C_SendPlayerDataComplete{mapDataId = 0, x = 0, y = 0})
      end;
    false ->
      player:send(?CMD_GS2C_SendPlayerDataComplete, #pk_GS2C_SendPlayerDataComplete{mapDataId = Player#player.mapDataId, x = Player#player.x, y = Player#player.y})

  end,
  case ?Activity_Campfire_MapDataId =:= Player#player.mapDataId andalso campfireMod:getCampfireState() of
    true ->
      erlang:send( erlang:self(), {playerCampfireCalcExp} );
    false ->
      ignore
  end,


  MsgServerID = #pk_GS2C_ServerID{serverID = myshare:get_env(server_id)},
  player:send(?CMD_GS2C_ServerID, MsgServerID),

  secureProct:initWhenOnline(),
  exchange:onLineSendCfg(),
  exchange:onLineResetExchange(Player#player.lastOfflineTime),


  %%秦岭地宫如果不在进入时间段内， 清除标志位
  undergroundPalaceMod:clearLastMapId(),

  achievement:online(),
  achievement:hook(?AchievementGold, Player#player.treasure),
  titleMod:online(),
  zhaocai:online(),
  erlang:send_after(timer:seconds(5), offlineMessage, {playerOnline, Player#player.id}),

  %%聚宝盆
  openServerAwardMod:push_server_charge_award_info(),

  %%提交UC或者其他平台数据
  erlang:spawn(statistics,statistics, [Player] ),
  vipMod:recalculate_vip_award( vipMod:vipLevel() ),

  %%上线卡boss处理
  erlang:send_after(timer:seconds(5), erlang:self(), onlineForceLeaveCopy),

  %% update player to online
  mysqlCommon:sqldb_query(?GAMEDB_CONNECT_POOL, "UPDATE player_gamedata SET isOnline=1,lastOnlineTime=" ++ integer_to_list(Now) ++ " where id=" ++ integer_to_list(Player#player.id), true),
  ?INFO(onPlayerOnline, "player id [~p]", [Player#player.id]),
  ?DEBUG(onPlayerOnline, "player id ~p,bag item ~n ~p", [Player#player.id, bagMod:get_bag_array()]),
  ?DEBUG(onPlayerOnline, "player id ~p,equip item ~n ~p", [Player#player.id, Player#player.equipDataArray]),
  ?DEBUG(onPlayerOnline, "player id ~p,warehouse item ~n ~p", [Player#player.id, Player#player.warehouseArray]),
  true.

%%玩家进程调用
sendServerTime() ->
    ServerTime = mytime:timestamp(),
    MsgServerTime = #pk_GS2C_ServerTime{
        serverTime = ServerTime,
        curDay = (ServerTime - myshare:get_env(server_open_timestamp)) div (24*60*60) + 1},
%%   ?DEBUG(sendServerTime, "send server time msg ~p", [MsgServerTime]),
  player:send(?CMD_GS2C_ServerTime, MsgServerTime),
  ok.

%% ->{} or {X,Y}
getCurPlayerPos() ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined -> {};
    PlayerMapDynamicInfo ->
      case PlayerMapDynamicInfo#playerMapDynamicInfo.mapPlayerEts of
        undefined -> {};
        MapPlayerEts ->
          case etsBaseFunc:getRecordField(MapPlayerEts, getCurPlayerID(), #mapPlayer.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end
      end
  end.

%% 获取玩家的当前的地图pos
getCurPlayerMapPos() ->
  case playerAssist:getCurPlayerRecord() of
    undefined ->
      ?ERR(getCurPlayerMapPos, "getCurPlayerRecord undefined", []),
      undefined;
    Player ->
      MapDataId = Player#player.mapDataId,
      case getCurPlayerPos() of
        {} -> undefined;
        {PosX, PosY} -> {MapDataId, PosX, PosY}
      end
  end.

getPlayerPos(PlayerID) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerID) of
    {} ->
      undefined;
    PlayerState ->
      player:get_player_pos(PlayerState#player_state.pid)
  end.

verifyDistanceWithNpc(NpcId) ->
  verifyDistanceWithObject(NpcId, ?TalkToNpc_Radius_ForXY).

verifyTradeDistanceWithOtherPlayer(PlayerId) ->
  verifyDistanceWithObject(PlayerId, ?TradeBetweenPlayers_Radius_ForXY).

verifyDistanceWithItemForPickup(ItemId) ->
  verifyDistanceWithObject(ItemId, ?PickupItem_Radius_ForXY).

verifyDistanceWithGatherObject(GatherId) ->
  verifyDistanceWithObject(GatherId, ?GatherBetweenPlayer_Radius_ForXY).


%%玩家存盘
savePlayerAll(Now, IsMustSave, IsLoginout) ->
  case IsMustSave orelse Now >= get(?Next_Save_Player_Time) of
    true ->
      case playerAssist:getCurPlayerRecord() of
        undefined -> ?ERR(savePlayerAll, "getCurPlayerRecord undefined", []);
        Player ->
          %% 挖矿信息
%% 					exploreMod:save_db(),
          %% get some player info in map
          case playerAssist:getCurPlayerPos() of
            {} -> ?WARNING(savePlayerAll, "getCurPlayerPos fail;playerId=~p", [Player#player.id]), NewPlayer = Player;
            {PosX, PosY} ->
              NewPlayer = Player#player{x = erlang:trunc(PosX), y = erlang:trunc(PosY)}
          end,
          NewPlayer1 = NewPlayer#player{skillList = playerSkill:makeSkillListForSave(NewPlayer#player.skillList)},

          FightPlayer0 = playerMapFight:getCurPlayerMapFightRecord(),
          case FightPlayer0 of
            {} ->
              {_, HPMPList} = mysqlCommon:sqldb_query(?GAMEDB_CONNECT_POOL, "SELECT hp,mp,bufferList FROM  player_gamedata WHERE id=" ++ integer_to_list(Player#player.id), true),
              case HPMPList of
                [] ->
                  Hp = 1,
                  Mp = 1,
                  BuffList = [];
                _ ->
                  [[Hp, Mp, BuffList0 | _] | _] = HPMPList,
                  BuffList = gameDbProcess:my_binary_to_term(BuffList0, list)
              end,
              FightPlayer = #mapFightPlayer{hp = Hp,
                mp = Mp,
                fightingCapacity = Player#player.fightingCapacity,
                buffList = BuffList
              },
              BuffFromDB = true,
              ?DEBUG(savePlayerAll, "FightPlayer undefined,player id:~p, i will save fake data,~n the fake fightplayer is ~p", [Player#player.id, FightPlayer]);
            _ ->
              BuffFromDB = false,
              FightPlayer = FightPlayer0
          end,
          %?DEBUG(savePlayerAll,"FightPlayer:~p, CdInfoList:~p",[FightPlayer,get(?Player_CopyCDInfoList)]),
          case FightPlayer of
            {} ->
              ?ERR(savePlayerAll, "FightPlayer undefined,player id:~p", [Player#player.id]),
              case IsLoginout of
                true ->
                  mysqlCommon:sqldb_query(?GAMEDB_CONNECT_POOL, "UPDATE player_gamedata SET isOnline=0,lastOfflineTime=" ++ integer_to_list(mytime:timestamp()) ++ " where id=" ++ integer_to_list(Player#player.id), true);
                false -> ignore
              end;
            %% maybe should continue save
            _ ->
              %% will get pet 's hp from map fight process
              FightPlayer1 = FightPlayer#mapFightPlayer{buffList = playerBuffer:makeBufferListForSave(FightPlayer#mapFightPlayer.buffList, BuffFromDB)},
              case IsLoginout of
                true ->
                  NewPlayer2 = NewPlayer1#player{fightingCapacity = FightPlayer#mapFightPlayer.fightingCapacity,
                    lastOfflineTime = mytime:timestamp(), isOnline = 0};
                false ->
                  NewPlayer2 = NewPlayer1#player{fightingCapacity = FightPlayer#mapFightPlayer.fightingCapacity,
                    isOnline = 1}
              end,
              %%如果在夺宝奇兵地图，那么把玩家
              case NewPlayer2#player.mapDataId of
                ?Activity_Indiana_MapDataId ->
                  MyVarant = NewPlayer2#player.varArray,
                  case variant:getPlayerVarValue(MyVarant, ?PlayerVariant_Index_LastMapPos) of
                    undefined ->
                      NewPlayer3 = NewPlayer2;
                    {OldMapDataID, OldPosx, OldPosy} ->
                      ?INFO(savePlayerAll, "Player Offline at duobao, return to old place ~p ~p ~p", [OldMapDataID, OldPosx, OldPosy]),
                      NewPlayer3 = NewPlayer2#player{mapDataId = OldMapDataID,
                        mapId = 0,
                        x = OldPosx,
                        y = OldPosy
                      };
                    _ ->
                      NewPlayer3 = NewPlayer2
                  end,
                  ok;
                _ ->
                  NewPlayer3 = NewPlayer2
              end,
              gameDbProcess:updatePlayerGamedata(NewPlayer3, FightPlayer1,
                get(?Player_BagGridNum), get(?Player_BagDataArray),
                get(?Player_ShortcutList),
                get(?Player_AcceptTaskList),
                get(?Player_RepeatCompletedTaskList),
                get(?Player_SingleCompletedTaskList),
                get(?Player_FriendIdList),
                get(?Player_CopyCDInfoList), get(?Player_ActivedHighCopyList), get(?Next_Reset_Time_Perday), get(?Player_AttachInfo))

          end
      end,

      case IsMustSave of
        true ->
          NewSaveTime = mytime:getNowSeconds() + ?Save_Player_Data_Interval_Secs;
        false ->
          NewSaveTime = get(?Next_Save_Player_Time) + ?Save_Player_Data_Interval_Secs
      end,
      erlang:put(?Next_Save_Player_Time, NewSaveTime),

      %% write MultipleMonsterExp log
      CurMultipleMonsterExp = get(?PlayerProc_killMultipleMonsterExp),
      CurMultipleMonsterCount = get(?PlayerProc_killMultipleMonsterCount),
      case CurMultipleMonsterExp > 0 of
        true ->
          UpgradeCostTime = playerAssist:getCurPlayerProperty(#player.lastUpgradeCostTime),
          gameLog:log_player_exp_change(CurMultipleMonsterExp, ?Exp_Change_killMultipleMonster, CurMultipleMonsterCount, "", UpgradeCostTime),
          erlang:put(?PlayerProc_killMultipleMonsterCount, 0),
          erlang:put(?PlayerProc_killMultipleMonsterExp, 0);
        false -> ignore
      end;
    false ->
      ok
  end.

%% 每5分钟保存玩家地图信息
logPlayerMap(Now) ->
  case Now >= get(?Next_Save_Player_Map_Time) of
    true ->
      gameLog:log_player_map(),
      erlang:put(?Next_Save_Player_Map_Time, mytime:getNowSeconds() + ?Save_Player_Data_Interval_Secs);
    false ->
      ignore
  end.


check_gm_cmd() ->
  Gm_List = gameDbProcess:get_gm_cmd(playerAssist:getCurPlayerID()),

  Fun = fun(Gm_msg) ->
    [Type, BitId, PlayerId, GMstr, Level_min, Level_max] = Gm_msg,
    PlatSendItemBits = playerAssist:getCurPlayerProperty(#player.platSendItemBits),
    ?DEBUG(check_gm_cmd, "PlatSendItemBits=~p,BitId=~p", [PlatSendItemBits, BitId]),
    case myBits:isBitOn(PlatSendItemBits, BitId) of
      true ->
        %% 已领取过了
        ignore;
      false ->
        Level = playerAssist:getCurPlayerProperty(#player.level),
        case Level >= Level_min andalso Level =< Level_max of
          true ->
            case gmMod:onMsgGM(binary_to_list(GMstr)) of
              true ->
                case Type == 1 of
                  true ->
                    %% 全服GM命令，待过期时间到被系统清除
                    NewPlatSendItemBits = myBits:setBit(PlatSendItemBits, BitId),
                    playerAssist:setCurPlayerProperty(#player.platSendItemBits, NewPlatSendItemBits);
                  false ->
                    gameDbProcess:del_gm_cmd(PlayerId, BitId)
                end;
              false ->
                ?WARNING(check_gm_cmd, "gm_err:playerId=~p,GMstr=~p", [playerAssist:getCurPlayerID(), binary_to_list(GMstr)])
            end;
          false ->
            ignore
        end
    end
        end,
  lists:foreach(Fun, Gm_List).


%% 对于新建角色，先把后台全服奖励标志置true(表示已领取)
initialize_gm_cmd(PlayerID, PlatSendItemBits) ->
  Gm_List = gameDbProcess:get_gm_cmd(PlayerID),

  Fun = fun(Gm_msg, ItemBits) ->
    [_Type, BitId, _PlayerId, _GMstr, _Level_min, _Level_max] = Gm_msg,
    _NewItemBits = myBits:setBit(ItemBits, BitId)
        end,
  lists:foldl(Fun, PlatSendItemBits, Gm_List).

%% 充值配置表
send_pay_info() ->
  Pay_info_List = getPayInfoList(),
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  PlayerDoubleFirstPayVariant = variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_DoubleFirstPay),
  PlayerDoubleFirstPayVariant1 =
  case PlayerDoubleFirstPayVariant of
    undefined ->
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_DoubleFirstPay, []),
      [];
    _ ->
      PlayerDoubleFirstPayVariant
  end,
  Fun =
    fun(Pay_info, Acc) when is_record(Pay_info, payCfg) ->
      IsDouble =
        case lists:member(Pay_info#payCfg.id, PlayerDoubleFirstPayVariant1) of
          true ->
            0;
          false ->
            1
        end,
      lists:append(Acc, [#pk_Pay_Info{id = Pay_info#payCfg.id,
        gameMoney = Pay_info#payCfg.gamemoney,
        ucMoney = Pay_info#payCfg.ucmoney,
        state = Pay_info#payCfg.state,
        isDouble = IsDouble}]);
      (Pay_info, Acc) when is_record(Pay_info, payiosCfg) ->
        IsDouble =
          case lists:member(Pay_info#payiosCfg.id, PlayerDoubleFirstPayVariant1) of
            true ->
              0;
            false ->
              1
          end,
        lists:append(Acc, [#pk_Pay_Info{id = Pay_info#payiosCfg.id,
          gameMoney = Pay_info#payiosCfg.gamemoney,
          ucMoney = Pay_info#payiosCfg.ucmoney,
          state = Pay_info#payiosCfg.state,
          isDouble = IsDouble}]);
      ({_, Pay_Id, Pay_gamemoney, Pay_ucmoney, Pay_state}, Acc)  -> %% 其他
        IsDouble =
          case lists:member(Pay_Id, PlayerDoubleFirstPayVariant1) of
            true ->
              0;
            false ->
              1
          end,
        lists:append(Acc, [#pk_Pay_Info{id = Pay_Id,
          gameMoney = Pay_gamemoney,
          ucMoney = Pay_ucmoney,
          state = Pay_state,
          isDouble = IsDouble}])
    end,
  Pk_Pay_info_List = lists:foldl(Fun, [], Pay_info_List),
  player:send(?CMD_GS2C_Pay_Info, #pk_GS2C_Pay_Info{pay_Info_lists = Pk_Pay_info_List}).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%返回当前进程的玩家ID
getCurPlayerID() ->
  case erlang:get(?Player_PlayerID) of
    undefined ->
      0;
    PlayerID ->
      PlayerID
  end.

getCurPlayerAccountId() ->
  case erlang:get(?Player_AccountId) of
    undefined ->
      0;
    PlayerAccountId ->
      PlayerAccountId
  end.

getCurPlayerMapPID() ->
  case erlang:get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?ERR(getCurPlayerMapPID, "mapPID error,is 0", []), 0;
    PlayerMapDynamicInfo ->
      PlayerMapDynamicInfo#playerMapDynamicInfo.mapPID
  end.

getCurPlayerMapFightPID() ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?ERR(getCurPlayerMapFightPID, "mapFightPID error,is 0", []), 0;
    PlayerMapDynamicInfo ->
      PlayerMapDynamicInfo#playerMapDynamicInfo.mapFightPid
  end.

getCurPlayerMapAIPID() ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?ERR(getCurPlayerMapAIPID, "map Ai PID error,is 0", []), 0;
    PlayerMapDynamicInfo ->
      PlayerMapDynamicInfo#playerMapDynamicInfo.mapAIPid
  end.

getCurPlayerName() ->
  case get(?Player_PlayerName) of
    undefined -> "";
    Name -> Name
  end.

%%返回当前进程的玩家记录
getCurPlayerRecord() ->
  get(?Player_CurPlayerRecord).

setCurPlayerRecord(Player) ->
  erlang:put(?Player_CurPlayerRecord, Player).

getCurPlayerOnlineSeconds() ->
  mytime:timestamp() - playerAssist:getCurPlayerProperty(#player.lastOnlineTime).

%%返回当前进程玩家某属性值
getCurPlayerProperty(PropertyIndex) ->
  case get(?Player_CurPlayerRecord) of
    undefined ->
      ?ERR(getCurPlayerProperty, "PropertyIndex error,is: ~p", [PropertyIndex]), 0;
    Player ->
      element(PropertyIndex, Player)
  end.

%%设置当前进程玩家某属性值
setCurPlayerProperty(PropertyIndex, Value) ->
  case get(?Player_CurPlayerRecord) of
    undefined -> 0;
    Player ->
      Player1 = setelement(PropertyIndex, Player, Value),
      erlang:put(?Player_CurPlayerRecord, Player1)
  end.


%% 获取指定玩家记录
getPlayerRecord(PlayerId) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      undefined;
    PlayerState ->
      player:get_player(PlayerState#player_state.pid)
  end.

getPlayerBagDataByPlayerID(PlayerID) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerID) of
    {} ->
      undefined;
    PlayerState ->
      player:get_player_bag_data(PlayerState#player_state.pid)
  end.

getPlayerBagGridNum(PlayerID) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerID) of
    {} ->
      undefined;
    PlayerState ->
      player:get_player_bag_grid_num(PlayerState#player_state.pid)
  end.

getPlayerHpAndMaxHp() ->
  FightPlayer = playerMapFight:getCurPlayerMapFightRecord(),
  case FightPlayer of
    {} ->
      {0, 0};
    _ ->
      Hp = FightPlayer#mapFightPlayer.hp,
      FightProperties = FightPlayer#mapFightPlayer.fightProperties,
      HpMax = FightProperties#mapFightProperties.hpMax,
      {Hp, HpMax}
  end.

getItems(PlayerID) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerID) of
    {} ->
      undefined;
    PlayerState ->
      player:getItems(PlayerState#player_state.pid)
  end.

%% 获取指定玩家记录,不在线从db查
getPlayerRecord(PlayerId, isDelete) ->
  PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId, isDelete),
  case PlayerGameDataRet of
    [] -> undefined;
    [PlayerGamedata | _] ->
      Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
      Player
  end;
getPlayerRecord(PlayerId, FromDB) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      case (FromDB == true) of
        true ->
          PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId),
          case PlayerGameDataRet of
            [] -> undefined;
            [PlayerGamedata | _] ->
              Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
              Player
          end;
        false ->
          undefined
      end;
    PlayerState ->
      player:get_player(PlayerState#player_state.pid)
  end.

%% 异步获取指定玩家记录,不在线从db查
getAsynPlayerRecord(PlayerId, _Rank, db) ->
  PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId, isDelete),
  case PlayerGameDataRet of
    [] -> undefined;
    [PlayerGamedata | _] ->
      Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
      Player
  end;
getAsynPlayerRecord(PlayerId, Rank, FromDB) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      case (FromDB == true) of
        true ->
          PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId),
          case PlayerGameDataRet of
            [] -> undefined;
            [PlayerGamedata | _] ->
              Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
              Player
          end;
        false ->
          undefined
      end;
    PlayerState ->
      case erlang:is_pid(PlayerState#player_state.pid) andalso erlang:is_process_alive(PlayerState#player_state.pid) of
        true ->
          PlayerState#player_state.pid ! {msg_get_player_record, Rank, self()},
          ok;
        false ->
          undefined
      end
  end.


%%获取玩家在线的PlayerState, 或者离线时的PlayerRecord, 用于组装其他数据
getPlayerStateOrRecord(PlayerId) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    PlayerState when erlang:is_record(PlayerState, player_state) ->
      PlayerState;
    _ ->
      PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId),
      case PlayerGameDataRet of
        [] -> undefined;
        [PlayerGamedata | _] ->
          PlayerRecord = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
          PlayerRecord
      end
  end.

getPlayerState(PlayerId) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    PlayerState when erlang:is_record(PlayerState, player_state) ->
      PlayerState;
    {} -> %%玩家不在线， 从数据库取出基本数据组装成player_state, 不要全部取组装成player, 因为一个player很大， 2M 多
      gameDbProcess:get_player_state(PlayerId)
  end.

getPlayerVipLevel(PlayerId) ->
  case getPlayerStateOrRecord(PlayerId) of
    PlayerState when erlang:is_record(PlayerState, player_state) ->
      PlayerState#player_state.vipLevel;
    PlayerRecord when erlang:is_record(PlayerRecord, player) ->
      TotalTreasure = PlayerRecord#player.totaltreasure,
      PlatformId = PlayerRecord#player.platformID,
      VipLevel = vipMod:getVipLevelByMoney(PlatformId, TotalTreasure),
      VipLevel;
    _ ->
      0
  end.

getPlayerName(PlayerId, FromDB) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      case FromDB of
        true ->
          PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId),
          case PlayerGameDataRet of
            [] ->
              _Name = "";
            [PlayerGamedata | _] ->
              Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
              _Name = Player#player.name
          end;
        false ->
          _Name = ""
      end;
    PlayerState ->
      _Name = PlayerState#player_state.name
  end.

getPlayerLevel(PlayerId, FromDB) ->
  case etsBaseFunc:readRecord(?PlayerStateTableAtom, PlayerId) of
    {} ->
      case (FromDB == true) of
        true ->
          PlayerGameDataRet = gameDbProcess:get_playerGamedata_list_by_id(PlayerId),
          case PlayerGameDataRet of
            [] -> -1;
            [PlayerGamedata | _] ->
              Player = dataConv:fillPlayerByplayerGamedata(PlayerGamedata),
              Player#player.level
          end;
        false -> -1
      end;
    PlayerState -> PlayerState#player_state.level
  end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% send message to player's guild all member
%% if exclude sender, please set IsExceptObjectSelf = true, otherwise set IsExceptObjectSelf = false
sendMsgToGuildMembers(PlayerID, IsExceptObjectSelf, Cmd, Msg) ->
  case etsBaseFunc:readRecord(?LeaguePlayerStateTableAtom, PlayerID) of
    {} ->
      ok;
    LeaguePlayerState ->
      case etsBaseFunc:readRecord(?LeagueStateTableAtom, LeaguePlayerState#leaguePlayer_state.leagueId) of
        {} ->
          ok;
        LeagueState ->
          Func = fun(LeagueMember) ->
            case etsBaseFunc:readRecord(?PlayerStateTableAtom, LeagueMember#pk_LeagueMember.playerId) of
              {} ->
                ok;
              MemberPlayer ->
                case IsExceptObjectSelf andalso MemberPlayer#player_state.id =:= PlayerID of
                  true ->
                    ok;
                  false ->
%% 												 SendId = MemberPlayer#player_state.id,
%% 												 case blackListMod:checkBlackList(SendId, PlayerID) of
%% 													 true ->
%% 														 ok;
%% 													 false ->
                    playerSend:sendToPlayerSendByPid(MemberPlayer#player_state.sendPid, Cmd, Msg)
                  %%end
                end
            end
                 end,
          lists:foreach(Func, LeagueState#league_state.memberList)
      end
  end.


%% if the player is in team, send Msg to team members
%% if you don't send the Msg to the player self, please set IsExcludeSelf true, otherwise set false
sendMsgToTeamMembers(_PlayerId, Cmd, Msg, IsExcludeSelf) ->
  team:sendMsgToTeamMembers(Cmd, Msg, IsExcludeSelf).

%% ->{} or Object
getMapObject(Id) ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?ERR(getMapObject, "Cannot Get Id, :~p", [Id]),
      {};
    PlayerMapDynamicInfo ->
      case map:getObjectID_TypeID(Id) of
        ?Object_Type_Player ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapPlayerEts of
            undefined -> ?ERR(getMapObject, "mapPlayerEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_Npc ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapNpcEts of
            undefined -> ?ERR(getMapObject, "mapNpcEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_Monster ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapMonsterEts of
            undefined -> ?ERR(getMapObject, "mapMonsterEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_Item ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapItemEts of
            undefined -> ?ERR(getMapObject, "mapItemEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_DefenseMonster ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapMonsterEts of
            undefined -> ?ERR(getMapObject, "mapMonsterEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        %% add pet if needed
        _ -> {}
      end
  end.

getMapNpc(Id) ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined ->
      ?ERR(getMapObject, "Cannot Get Id, :~p", [Id]),
      {};
    PlayerMapDynamicInfo ->
      case PlayerMapDynamicInfo#playerMapDynamicInfo.mapNpcEts of
        undefined ->
          ?ERR(getMapObject, "mapNpcEts is undefined"), {};
        ObjectEts ->
          etsBaseFunc:readRecord(ObjectEts, Id)
      end
  end.

%% ->{} or {X,Y}
getObjectPos(Id) ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined -> {};
    PlayerMapDynamicInfo ->
      case map:getObjectID_TypeID(Id) of
        ?Object_Type_Player ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapPlayerEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapPlayer.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        ?Object_Type_Npc ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapNpcEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapNpc.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        ?Object_Type_Monster ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapMonsterEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapMonster.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        ?Object_Type_Item ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapItemEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapItem.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        ?Object_Type_Pet ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapPetEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapPet.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        ?Object_Type_DefenseMonster ->
          ObjectEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapMonsterEts,
          case etsBaseFunc:getRecordField(ObjectEts, Id, #mapMonster.pos) of
            0 -> {};
            Pos -> {Pos#posInfo.x, Pos#posInfo.y}
          end;
        _ -> {}
      end
  end.


%% ->{} or #mapFightPlayer
getMapFightObject(Id) ->
  case get(?Player_PlayerMapDynamicInfo) of
    undefined -> {};
    PlayerMapDynamicInfo ->
      case map:getObjectID_TypeID(Id) of
        ?Object_Type_Monster ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapFightMonsterEts of
            undefined -> ?ERR(getMapObject, "mapFightMonsterEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_Player ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapFightPlayerEts of
            undefined -> ?ERR(getMapObject, "mapFightPlayerEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_Pet ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapFightPetEts of
            undefined -> ?ERR(getMapObject, "mapFightPetEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        ?Object_Type_DefenseMonster ->
          case PlayerMapDynamicInfo#playerMapDynamicInfo.mapFightMonsterEts of
            undefined -> ?ERR(getMapObject, "mapFightMonsterEts is undefined"), {};
            ObjectEts ->
              etsBaseFunc:readRecord(ObjectEts, Id)
          end;
        _ -> {}
      end
  end.

%% 获取玩家使用的经验卷轴倍率，没使用为0
getExpScrollRate() ->
  case playerAssist:getMapFightObject(playerAssist:getCurPlayerID()) of
    {} ->
      0;
    MapFightPlayer ->
      ?DEBUG(getExpScrollRate, "buffList=~p", [MapFightPlayer#mapFightPlayer.buffList]),
      MyFun = fun(#playerBuffer{} = Buffer, Acc) ->
        BuffDataId = buffMod:getBuffDataIdByBuffId(Buffer#playerBuffer.id),
        BuffCfg = data_buff:get_item(BuffDataId),
        case BuffCfg of
          false ->
            ?DEBUG(getExpScrollRate, "can't find buffer[~p] config data.", [Buffer]),
            Acc;
          _ ->
            case BuffCfg#buffCfg.type of
              ?BUFFTYPE_ExpScroll ->
                Acc + BuffCfg#buffCfg.powerpercent;
              _ ->
                Acc
            end
        end
              end,
      lists:foldl(MyFun, 0, MapFightPlayer#mapFightPlayer.buffList)
  end.


%% ====================================================================
%% Internal functions
%% ====================================================================

%% -> true or false
verifyDistanceWithObject(Id, Distance) ->
  %%check distance
  case getCurPlayerPos() of
    {} -> ?ERR(verifyDistanceWithObject, "getCurPlayerPos fail"), false;
    {PlayerPosX, PlayerPosY} ->
      case getObjectPos(Id) of
        {} -> ?ERR(verifyDistanceWithNpc, "getCurPlayerPos fail"), false;
        {ObjectPosX, ObjectPosY} ->
          trunc(abs(PlayerPosX - ObjectPosX)) =< Distance andalso trunc(abs(PlayerPosY - ObjectPosY)) =< Distance
      end
  end.


resetSomeInfoWhenOnline() ->
  %% try to reset copy cd
  Now = mytime:timestamp(),
  case Now >= get(?Next_Reset_Time_Perday) of
    true ->
      %%%%%%%%%%%%%%%%%%%reset start%%%%%%%
      copyCdMod:resetCopyCdWhenOnline(),
      richer:resetRicherTimes(),
      wheelMod:resetRicherTimesOnLine(),
      vipMod:resetVipEveryDayOnline(),
      platfromVipMod:resetplatfromVipDayOnline(),
      campfireMod:resetCampfireDrinkRateOnLine(),
      rushMissionPlayer:resetMissionResetTimes(),
      %%escortMod:resetEscortOnLine(),
      league:resetPlayerReqJoinLeagueTimes(),
      vipModTotalPay:resetTodayTotalPay(),
      playerAssist:setCurPlayerProperty(#player.huangChengGetAwardFlag, 0),
      equipMod:time2reset(),
      timeBoxMod:reset_time_box(),
      signInMod:refreshSignIn(),
      resetOnlinePlayerAttachInfo(),
      resetHurtTime(),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_LeagueSignin, 0),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Wa_Kuang, 0),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_DailyTaskNum, 0),
      luxurySigninMod:resetFirstRechange(),
      taskMod:resetDailyTask(),
      %%%%%%%%%%%%%%%%%%%reset end %%%%%%%%
      NewResetTime = mytime:getNextDayBeginSeconds(),
      erlang:put(?Next_Reset_Time_Perday, NewResetTime);
    false ->
      ok
  end,
  ok.

resetSomeInfo(Now) ->
  %% try to reset copy cd
  case Now >= get(?Next_Reset_Time_Perday) of
    true ->
      %%%%%%%%%%%%%%%%%%%reset start%%%%%%%
      copyCdMod:resetCopyCdIfNeed(),
      richer:resetRicherTimes(),
      wheelMod:resetRicherTimesOnTime(),
      vipMod:resetVipEveryDayOnTime(),
      platfromVipMod:resetplatfromVipDayOnTime(),
      campfireMod:resetCampfireDrinkRateOnTime(),
      rushMissionPlayer:resetMissionResetTimes(),
      league:resetPlayerReqJoinLeagueTimes(),
      vipModTotalPay:resetTodayTotalPay(),
      playerAssist:setCurPlayerProperty(#player.huangChengGetAwardFlag, 0),
      equipMod:time2reset(),
      timeBoxMod:reset_time_box(),
      signInMod:refreshSignIn(),
      resetOnlinePlayerAttachInfo(),
      rankListMod:resetKillScore(),
      resetEveryDayTask(),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_LeagueSignin, 0),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Wa_Kuang, 0),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_DailyTaskNum, 0),
      luxurySigninMod:resetFirstRechange(),
      taskMod:resetDailyTask(),
      resetHurtTime,
      %%%%%%%%%%%%%%%%%%%reset end %%%%%%%%

      NewResetTime = get(?Next_Reset_Time_Perday) + 86400,
      ?DEBUG(resetSomeInfoWhenOnline, "NewResetTime222=~p", [NewResetTime]),
      erlang:put(?Next_Reset_Time_Perday, NewResetTime);
    false ->
      ok
  end,

  ok.

%% 获取充值配置
getPayInfoList(PlayerId) ->
    PlayerPlatformId = gameDbProcess:get_platformID_by_playerId(PlayerId),
    case PlayerPlatformId of
        ?PLATFORM_201 ->
            data_payios:get_items();
        ?PLATFORM_GUANGYU ->
            data_payios:get_items();
        ?PLATFORM_FAST_LOGIN ->
            data_payios:get_items();
        ?PLATFORM_Gionee ->
            CfgList = data_pay:get_items(),
            Funfilter = fun(Cfg) ->
                Cfg#payCfg.ucmoney < 6000
                        end,
            lists:filter(Funfilter, CfgList);
        ?PLATFORM_SIFU_996 ->
            data_pay_sifu_996:get_items();
        ?PLATFORM_SIFU_996_FangYou ->
            data_pay_sifu_996:get_items();
        ?PLATFORM_SIFU_195 ->
          data_pay_sifu_996:get_items();
        ?PLATFORM_SIFU_195_1 ->
          data_pay_sifu_996:get_items();
        ?PLATFORM_SIFU_DAMAI ->
          data_pay_sifu_996:get_items();
        ?PLATFORM_SIFU_YUFENG ->
            data_pay_sifu_yf:get_items();
        _ ->
            data_pay:get_items()
    end.

%% 获取充值配置
getPayInfoList() ->
  PlayerPlatformId = playerAssist:getCurPlayerProperty(#player.platformID),
  case PlayerPlatformId of
    ?PLATFORM_201 ->
      data_payios:get_items();
    ?PLATFORM_GUANGYU ->
      data_payios:get_items();
    ?PLATFORM_FAST_LOGIN ->
      data_payios:get_items();
    ?PLATFORM_Gionee ->
      CfgList = data_pay:get_items(),
      Funfilter = fun(Cfg) ->
        Cfg#payCfg.ucmoney < 6000
                  end,
      lists:filter(Funfilter, CfgList);
    ?PLATFORM_SIFU_996 ->
      data_pay_sifu_996:get_items();
    ?PLATFORM_SIFU_996_FangYou ->
      data_pay_sifu_996:get_items();
    ?PLATFORM_SIFU_195 ->
      data_pay_sifu_996:get_items();
    ?PLATFORM_SIFU_195_1 ->
      data_pay_sifu_996:get_items();
    ?PLATFORM_SIFU_DAMAI ->
      data_pay_sifu_996:get_items();
    ?PLATFORM_SIFU_YUFENG ->
      data_pay_sifu_yf:get_items();
    _ ->
      data_pay:get_items()
  end.

%% 获取充值配置的nth
getPayNth() ->
  case getCurPlayerRecord() of
    #player{platformID = ?PLATFORM_201} ->
      #payiosCfg.ucmoney;
    #player{platformID = ?PLATFORM_FAST_LOGIN} ->
      #payiosCfg.ucmoney;
    _ ->
      #payCfg.ucmoney
  end.

getMoneyNth() ->
  case getCurPlayerRecord() of
    #player{platformID = ?PLATFORM_201} ->
      #payiosCfg.gamemoney;
    #player{platformID = ?PLATFORM_FAST_LOGIN} ->
      #payiosCfg.gamemoney;
    _ ->
      #payCfg.gamemoney
  end.

%% 初始化玩家装备、宝石数据
%% initFightPart(Player) ->
%% 	EquipList   = array:to_list(Player#player.equipDataArray),
%% 	EnchaseList = array:to_list(Player#player.enchaseDataArray),
%% 	EquipIds 	= [{DataId,Star}||#item{itemDataId=DataId,stars=Star}<-EquipList],
%% 	EnchanseIds = lists:flatten([array:to_list(E)||E<-EnchaseList]),
%% 	EnchanseIds2= [{DataId2,Star2}||#item{itemDataId=DataId2,stars=Star2}<-EnchanseIds],
%% 	etsBaseFunc:insertRecord(?GlobalFightPart, {Player#player.id, EquipIds ++ EnchanseIds2}).

%% 穿装备、镶嵌宝石、强化
addFightPartEquip(PlayerId, Item) ->
  addFightPartEquip(PlayerId, Item, normal).

addFightPartEquip(PlayerId, Item, normal) ->
  #item{itemDataId = DataId, stars = Star} = Item,
  case etsBaseFunc:readRecord(?GlobalFightPart, PlayerId) of
    {} ->
      etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, [{DataId, Star}]});
    {_, EquipList} ->
      etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, [{DataId, Star} | EquipList]})%%左右手镯有可能是同种道具
%% 			case lists:keyfind(DataId, 1, EquipList) of
%% 				{_, _} ->
%% 					EquipList2 = lists:keyreplace(DataId, 1, EquipList, {DataId, Star}),
%% 					etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, EquipList2});
%% 				false ->
%% 					etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, [{DataId, Star}|EquipList]})
%% 			end
  end;
addFightPartEquip(PlayerId, Item, equipStren) ->
  #item{itemDataId = DataId, stars = Star} = Item,
  case etsBaseFunc:readRecord(?GlobalFightPart, PlayerId) of
    {} ->
      ok;
    {_, EquipList} ->
      case lists:keyfind(DataId, 1, EquipList) of
        {_, _} ->
          EquipList2 = lists:keyreplace(DataId, 1, EquipList, {DataId, Star}),
          etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, EquipList2});
        false ->
          ok
      end
  end.

%% 卸装备、宝石
decFightPartEquip(PlayerId, Item) ->
  #item{itemDataId = DataId} = Item,
  case etsBaseFunc:readRecord(?GlobalFightPart, PlayerId) of
    {} ->
      ok;
    {_, EquipList} ->
      case lists:keyfind(DataId, 1, EquipList) of
        {_, _} ->
          EquipList2 = lists:keydelete(DataId, 1, EquipList),
          etsBaseFunc:insertRecord(?GlobalFightPart, {PlayerId, EquipList2});
        false ->
          ok
      end
  end.

%% 计算装备(强化)、宝石战斗力
%%otherFight(PlayerId) ->
%%  case etsBaseFunc:readRecord(?GlobalFightPart, PlayerId) of
%%    {} ->
%%      0;
%%    {_, EquipList} ->
%%      lists:sum([perSword(Id, Star) || {Id, Star} <- EquipList])
%%  end.
%%
%%perSword(Id, Star) ->
%%  Sword1 =
%%  case data_equipment:get_item(Id) of
%%    #equipmentCfg{sword = Value} ->
%%      Value;
%%    _ ->
%%      0
%%  end,
%%  Sword2 =
%%  case data_strength_cost:get_item(Star) of
%%    #strength_costCfg{sword = Value2} ->
%%      Value2;
%%    _ ->
%%      0
%%  end,
%%  Sword1 + Sword2.

update_curse(EquipDataArray, Item, PK) ->
  Curse = Item#item.curse,
  Lucky = Item#item.luck,
  case Lucky > 0 of
    true ->
      NewCurse = Curse;
    false ->
      case Curse >= 9 of
        true ->
          NewCurse = Curse;
        false ->
          CurseCfg = data_curse:get_item(Curse),
          case common:rand(1, 10000) =< CurseCfg#curseCfg.add_curse_rate of
            false ->
              NewCurse = Curse;
            true ->
              NewCurse = Curse + 1
          end
      end
  end,
  case PK >= ?Fight_Pk_Red of
    false ->
      NewLucky = Lucky;
    true ->
      case Lucky =< 0 of
        true ->
          NewLucky = Lucky;
        false ->
          LuckyCfg = data_luckupgrade:get_item(Lucky),
          case common:rand(1, 10000) =< LuckyCfg#luckupgradeCfg.killrate of
            false ->
              NewLucky = Lucky;
            true ->
              NewLucky = Lucky - 1
          end
      end
  end,
  case NewCurse =:= Curse andalso NewLucky =:= Lucky of
    true ->
      ingore;
    false ->
      NewItem = Item#item{curse = NewCurse, luck = NewLucky},
      NewEquipDataArray = array:set(?Equip_Part_Weapon, NewItem, EquipDataArray),
      playerAssist:setCurPlayerProperty(#player.equipDataArray, NewEquipDataArray),
      playerMapFight:changePlayerEquipData(NewEquipDataArray),
      case NewCurse =/= Curse of
        true ->
          achievement:hook(?AchievementCurse, NewCurse),
          ChangeList = [#pk_changeValue{type = ?Item_Change_Type_Curse, value = NewCurse, newAdvanceProperties = []}];
        false ->
          ChangeList = []
      end,
      case NewLucky =/= Lucky of
        true ->
          ChangeList1 = [#pk_changeValue{type = ?Item_Change_Type_Luck, value = NewLucky, newAdvanceProperties = []} | ChangeList];
        false ->
          ChangeList1 = ChangeList
      end,
      case ChangeList1 of
        [] ->
          ingore;
        _ ->
          NoticeMsg = #pk_GS2C_ItemChange{
            temp = ?Item_Bag_Type_EquipOn,
            index = ?Equip_CfgPlace_Weapon,
            change = ChangeList1},
          player:send(?CMD_GS2C_ItemChange, NoticeMsg)
      end
  end,
  achievement:hook(?AchievementPk, PK).

%% 玩家进程内调用
updatePlayerCurseLucky(PK) ->
  Player = playerAssist:getCurPlayerRecord(),
  EquipDataArray = Player#player.equipDataArray,
  case array:get(?Equip_Part_Weapon, EquipDataArray) of
    undefined ->  %%没有装备武器
      ok;
    Item ->
      update_curse(EquipDataArray, Item, PK)
  end.

%%玩家进程可调用
%%获取和我同一个地图的玩家的ID列表， 除了我
getSameMapPlayerIdList() ->
  PlayerMapDynamicInfo = erlang:get(?Player_PlayerMapDynamicInfo),
  MapPlayerEts = PlayerMapDynamicInfo#playerMapDynamicInfo.mapPlayerEts,
  MapPlayerIdList = ets:select(MapPlayerEts, [{#mapPlayer{id = '$1', _ = '_'}, [], ['$1']}]),
  lists:delete(playerAssist:getCurPlayerID(), MapPlayerIdList).

%%发送资源邮件礼包
sendDownMailByLevel(Player) ->
  case variant:getPlayerVarFlag(Player#player.varArray, ?PlayerVariant_Index_RankList_Award, ?PlayerVariant_Bit_DownGif) of
    true -> ok;
    false ->
      case variant:getPlayerVarFlag(Player#player.varArray, ?PlayerVariant_Index_RankList_Award, ?PlayerVariant_Bit_IsSendDownMailGif) of
        true -> ok;
        false ->
          case Player#player.level > 39 of
            true ->
              variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_RankList_Award, ?PlayerVariant_Bit_IsSendDownMailGif, 1),
              mailMgrMod:sendSystemMail(?Mail_Kill_SendName, 2, ?Resource_AwardPackage,
                ?Mail_Kill_SendName,
                Player#player.id,
                [], 0, 0, 0, 0);
            false -> ok
          end
      end
  end.

%%在线清理玩家附加信息数据
resetOnlinePlayerAttachInfo() ->
  Attachinfo = #player_attachinfo{playerid = playerAssist:getCurPlayerID(),
    liveNessValue = 0, liveNessList = [], drewLnAwardList = []},
  erlang:put(player_attachinfo, Attachinfo),
  liveness:onlineSendLiveInfo().

%%返回当前进程玩家活跃度
getCurAttachInfoProperty(PropertyIndex) ->
  case get(player_attachinfo) of
    undefined -> 0;
    AttachInfo -> element(PropertyIndex, AttachInfo)
  end.

%%设置当前进程玩家活跃度
setCurAttachInfoProperty(PropertyIndex, Value) ->
  case get(player_attachinfo) of
    undefined -> 0;
    AttachInfo ->
      AttachInfo1 = setelement(PropertyIndex, AttachInfo, Value),
      erlang:put(player_attachinfo, AttachInfo1)
  end.

%%杀人处理战绩值
updatePlayerKillScore(IsAddKillScore) ->
  case IsAddKillScore of
    false ->
      ingore;
    true ->
      KillScore = getCurPlayerProperty(#player.killScore),
      setCurPlayerProperty(#player.killScore, KillScore + 1)
  end.

%%玩家初始化身上武器装备或者背包
initializeItemArray(ItemDataId, Count, Position, BagArray) ->
  case data_item:get_item(ItemDataId) of
    false -> BagArray;
    Cfg ->
      Item = itemMod:createItem(ItemDataId, Count, Cfg#itemCfg.bind, 0, 0, undefined),
      case Item of
        undefined -> BagArray;
        _ -> array:set(Position, Item, BagArray)
      end
  end.

msgReqHurtUiInfo() ->
  VarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  TimesOne = case variant:getPlayerVarValue(VarArray, ?PlayerVariant_MinHurtTims) of
               undefined -> 3 + vipMod:getExtraHurtVipTimes(vipMod:vipLevel());
               ReadyTimesOne -> 3 + vipMod:getExtraHurtVipTimes(vipMod:vipLevel()) - ReadyTimesOne
             end,
  TimesTwo = case variant:getPlayerVarValue(VarArray, ?PlayerVariant_MaxHurtTims) of
               undefined -> 3 + vipMod:getExtraHurtVipTimes(vipMod:vipLevel());
               ReadyTimesTwo -> 3 + vipMod:getExtraHurtVipTimes(vipMod:vipLevel()) - ReadyTimesTwo
             end,
  Msg = #pk_GS2C_returnHuntingInfo{timesOne = TimesOne, timesTwo = TimesTwo},
  playerSend:sendToPlayerSendByPid(playerAssist:getCurPlayerSendPid(), ?CMD_GS2C_returnHuntingInfo, Msg).


resetHurtTime() ->
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_MinHurtTims, 0),
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_MaxHurtTims, 0).

modifySkillPoints(Points) ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  OldPoints =
    case variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_SkillPoints) of
      Integer when erlang:is_integer(Integer) ->
        Integer;
      _ -> 0
    end,
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_SkillPoints, OldPoints + Points).

%%--------------------------------------------------------------------
%% 功能：获取该部位已开孔的数目
%% @para Part
%% @return 已开孔的数目
%%--------------------------------------------------------------------
getEquipOpenHoleNum(Part) ->
  PlayerVarArray = getCurPlayerProperty(#player.varArray),
  case variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_EquipOpenHole_0 + Part) of
    Integer when is_integer(Integer) ->
      Integer;
    _ ->
      1 %% 默认会开一个孔
  end.

%%--------------------------------------------------------------------
%% 功能：该部位再开一个孔
%% @para Part
%% @return true or false
%%--------------------------------------------------------------------
addEquipOpenHoleNum(Part) ->
  IndexPart = ?PlayerVariant_Index_EquipOpenHole_0 + Part,
  NewOpenHoleNum = getEquipOpenHoleNum(Part) + 1,
  variant:setPlayerVarValueFromPlayer(IndexPart, NewOpenHoleNum).

resetEveryDayTask() ->
  %%清理每日任务
  SingleCompletedTaskList = get(?Player_SingleCompletedTaskList),
  TaskItemFun = fun(TaskItem, SingleCompletedTaskList1) ->
    case TaskItem#taskCfg.type == 2 of
      true ->%%每日任务
        myBits:clearBit(SingleCompletedTaskList1, TaskItem#taskCfg.id);
      false -> SingleCompletedTaskList1
    end
                end,
  NewSingleCompletedTaskList = lists:foldl(TaskItemFun, SingleCompletedTaskList, data_task:get_items()),
  erlang:put(?Player_SingleCompletedTaskList, NewSingleCompletedTaskList).

execute_in_player(PlayerId, {M, F, A}) ->
  PlayerPid = playerAssist:getPlayerPID(PlayerId),
  case erlang:is_pid(PlayerPid) andalso erlang:is_process_alive(PlayerPid) of
    true ->
      erlang:send(PlayerPid, {execute, M, F, A});
    false ->
      ignore
  end.

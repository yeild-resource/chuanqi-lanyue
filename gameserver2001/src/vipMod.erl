-module(vipMod).

%% ====================================================================
%% Include
%% ====================================================================
-include("common_include/logger.hrl").
-include("playerDefine.hrl").
-include("record.hrl").
-include("pt.hrl").
-include("itemDefine.hrl").
-include("variant.hrl").
-include("tipStr.hrl").
-include("mapDefine.hrl").
-include("playerProcDictKey.hrl").
-include("digitAdjustDefine.hrl").
-include("money.hrl").
-include("achievement.hrl").
-include("activity.hrl").
-include("serverStr.hrl").
-include("platformDefine.hrl").
%% ====================================================================
%% Define
%% ====================================================================
-define(Vip_EveryDayTimes, 1).
-define(Vip_EveryDayHaveTimes, 1).
-define(Vip_EveryDayNotHaveTimes, 0).
%% ====================================================================
%% API functions
%% ====================================================================
-export([
  addTreasure/1,
  vipLevel/0,
  vipLevel/1,
  getVipEveryDay/0,
  setVipEveryDay/1,
  vipEveryDayGet/0,
  isHaveEveryDayTimes/0,
  resetVipEveryDayOnline/0,
  resetVipEveryDayOnTime/0,
  vipTitle/0,
  vipTitle/1,
  %%%vip 等级奖励%%%%%
  vipLevelGetAward/1,
  vipLevelCanGetAward/1,
  vipSetLevelAwardCan/1,
  giftGet/1,
  vipCfgData/1,
  vipHp/1,
  getExtraCopyCdIncludeArenaCopy/2,
  getVipLevelByMoney/2,
  getFirstPay/0,
  isFirstPay/0,
  resetVipBenifits/0,
  isMineForFree/0,
  getMineTotalFreeTime/0,
  getMineUsedFreeTime/0,
  costMineFreeTime/1,
  isRicherForFree/0,
  getRicherTotalFreeTime/0,
  getRicherUsedFreeTime/0,
  costRicherFreeTime/1,
 	isDrinkForFree/0,
%% 		 getDrinkTotalFreeTime/0,
%% 		 getDrinkUsedFreeTime/0,
 	costDrinkFreeTime/1,
  isEatForFree/0,
  costEatFreeTime/1,
  getVipExtraDrawLuckyCnt/2,
  setEveryDayPay/1,
  isGetEveryDayPay/0,
  getEveryDayPay/0,
  getFirstPayState/0,
  setFirstPay/0,
  getExtraHurtVipTimes/1,
  recalculate_vip_award/1
]).


%% 领取首杀奖励
getFirstPay() ->
  IsFirstPay = isFirstPay(),
  IsGetFirstPay = isGetFirstPay(),
  ?DEBUG(getFirstPay, "IsFirstPay:~p, IsGetFirstPay:~p", [IsFirstPay, IsGetFirstPay]),
  case IsFirstPay andalso IsGetFirstPay =:= false of
    true ->
      case playerAssist:getCurPlayerRecord() of
        undefined -> ?ERR(getFirstPay, "there are no this player");
        Player ->
          case data_vipfirstpay:get_item(1) of
            false -> ?ERR(getFirstPay, "there are no this award");
            DataVipFirstPay ->
              AwardList = bagModGiveAward:filterAwardByCarrerAndSex(Player, DataVipFirstPay#vipfirstpayCfg.awarditems,
                DataVipFirstPay#vipfirstpayCfg.zhanshiawarditems,
                DataVipFirstPay#vipfirstpayCfg.daoshiawarditems,
                DataVipFirstPay#vipfirstpayCfg.fashiawarditems),
              ?DEBUG(getFirstPay, "DataVipFirstPay:~p,AwardList:~p", [DataVipFirstPay, AwardList]),
              AddItemList = bagModGiveAward:makeItemsFromBoxItem(AwardList),
              AddItemArray = array:from_list(AddItemList),
              BagArray = bagMod:get_bag_array(),
              BagGridNum = bagMod:get_bag_grid_num(),
              case bagModAddItem:isCanAddItemsToArray(BagArray, AddItemArray, BagGridNum, ?Item_Change_Content_VipFirstPay, ?Item_Change_Content_VipFirstPay_Content) of
                false -> chat:messagePromptMe(?Wheel_BagIsEnough_CannotAdd, "");
                _NewBagArray ->
                  AwardItemFun = fun(AwardItem) ->
                    {ItemID, ItemCnt, BindFlag} = AwardItem,
                    bagMod:addItem(ItemID, ItemCnt, BindFlag, ?Item_Change_Content_VipFirstPay, ?Item_Change_Content_VipFirstPay_Content)
                                 end,
                  lists:foreach(AwardItemFun, AwardList),
                  ?DEBUG(getFirstPay, "NewBagArray:~p", [_NewBagArray]),
                  setGetFirstPay(),
                  chat:messagePromptMe(?GainRechargeTip, ""),
                  true
              end
          end
      end;
    false ->
      ?ERR(getFirstPay, "you cannot get the award")
  end.

%%	获取每日充值礼包
getEveryDayPay() ->
  IsGetEveryDayPay = isGetEveryDayPay(),
  ?DEBUG(getEveryDayPay, " IsGetFirstPay:~p", [IsGetEveryDayPay]),
  case IsGetEveryDayPay =:= 1 of
    true ->
      case playerAssist:getCurPlayerRecord() of
        undefined -> ?ERR(getEveryDayPay, "there are no this player");
        Player ->
          case data_vipEveryDayPay:get_item(1) of
            false -> ?ERR(getEveryDayPay, "there are no this award");
            DataVipEveryDayPay ->
              AwardList = bagModGiveAward:filterAwardByCarrerAndSex(Player, DataVipEveryDayPay#vipEveryDayPayCfg.awarditems,
                DataVipEveryDayPay#vipEveryDayPayCfg.zhanshiawarditems,
                DataVipEveryDayPay#vipEveryDayPayCfg.daoshiawarditems,
                DataVipEveryDayPay#vipEveryDayPayCfg.fashiawarditems),
              ?DEBUG(getEveryDayPay, "DataVipFirstPay:~p,AwardList:~p", [DataVipEveryDayPay, AwardList]),
              case bagModGiveAward:isCanGiveAwardList(AwardList, ?Item_Change_Content_VipEveryDayPay, ?Item_Change_Content_VipEveryDayPay_Content) of
                false -> chat:messagePromptMe(?Wheel_BagIsEnough_CannotAdd, "");
                NewBagArray ->
                  ?DEBUG(getEveryDayPay, "NewBagArray:~p", [NewBagArray]),
                  bagModGiveAward:giveAwardList(NewBagArray),
                  chat:messagePromptMe(?EveryDayPayTip, ""),
                  setEveryDayPay(2),
                  true
              end
          end
      end;
    false ->
      ?ERR(getEveryDayPay, "you cannot get the award")
  end.


%% vip 增加的hp值
vipHp(VipLevel) ->
  case vipCfgData(VipLevel) of
    false -> 0;
    VipCfg -> VipCfg#vipCfg.hp
  end.

%% vip 增加的其它副本或竞技场免费次数
%% @return ExtraCopyCd
getExtraCopyCdIncludeArenaCopy(ActivityID, VipLevel) ->
  case VipLevel =< 0 of
    true -> 0;
    false ->
      case ActivityID of
        ?Activity_Id_Arena ->
          getVipExtraArenaCd(VipLevel);
        ?Activity_Id_MoLongCopy ->
          getMagicDragonCopyVipExtraCd(VipLevel);
        ?Activity_Id_JiangJunFenCopy ->
          getJiangJunFenCopyVipExtraCd(VipLevel);
        ?Activity_Id_NiMoCopy ->
          getNiMoCopyVipExtraCd(VipLevel);
        _ ->
          0
      end
  end.

getExtraHurtVipTimes(VipLevel) ->
  case VipLevel =< 0 of
    true -> 0;
    false ->
      case vipCfgData(VipLevel) of
        false -> 0;
        VipCfg -> VipCfg#vipCfg.huntingtime
      end
  end.


%% 增加的除魔副本
%%getVipExtraMagicCopyCd(VipLevel) ->
%%  case vipCfgData(VipLevel) of
%%    false -> 0;
%%    VipCfg -> VipCfg#vipCfg.extracopycd
%%  end.

%% 增加的竞技场次数
getVipExtraArenaCd(VipLevel) ->
  case vipCfgData(VipLevel) of
    false -> 0;
    VipCfg -> VipCfg#vipCfg.arena
  end.

%% 增加的魔龙宝地次数
getMagicDragonCopyVipExtraCd(VipLevel) ->
  case vipCfgData(VipLevel) of
    false -> 0;
    VipCfg -> VipCfg#vipCfg.molongcopy
  end.

%% 增加的将军坟次数
getJiangJunFenCopyVipExtraCd(VipLevel) ->
  case vipCfgData(VipLevel) of
    false -> 0;
    VipCfg -> VipCfg#vipCfg.jiangjunfencopy
  end.

%% 增加的逆魔次数
getNiMoCopyVipExtraCd(VipLevel) ->
  case vipCfgData(VipLevel) of
    false -> 0;
    VipCfg -> VipCfg#vipCfg.nimocopy
  end.

%% 根据vip的等级获取vip的结构信息
vipCfgData(VipLevel) ->
  DataVips = data_vip:get_items(),
  lists:keyfind(VipLevel, #vipCfg.viplevel, DataVips).

%% 领取激活码奖励
%% @para GiftCode
%% @return 
giftGet(GiftCode) ->
  case gameDbProcess:get_Gift_Code(GiftCode) of
    [] ->
      ?ERR(giftGet, "not found gift code"),
      chat:messagePromptMe(?TipStr_GiftCode_NotFound, "");
    [GiftData] ->
      [_Platform, SystemId, _SystemName, UserId] = GiftData,
      if
        UserId =/= 0 ->
          chat:messagePromptMe(?TipStr_GiftCode_RepeatByOther, "");
        true ->
          IsHaveGiftCode = isHaveGiftCode(SystemId),
          case  IsHaveGiftCode of
            true ->
              ?ERR(giftGet, "gift code you had it"),
              chat:messagePromptMe(?TipStr_GiftCode_Repeat, "");
            false ->
              giveGiftAward(SystemId, GiftCode),
              true
          end
      end
  end.

%% 是否可以发放奖励
giveGiftAward(SystemId, GiftCode) ->
  case data_gift:get_item(SystemId) of
    false ->
      ?ERR(isCanGiveGiftAward, "there are no this award"),
      false;
    GiftData ->
      Award = GiftData#giftCfg.award,
      case bagModGiveAward:isCanGiveAwardList(Award, ?Item_Change_Content_AddItem_Gift, ?Item_Change_Content_AddItem_Gift_Content) of
        false ->
          chat:messagePromptMe(?TipStr_GiftCode_BagNotEnough, "");
        NewBagArray ->
          bagModGiveAward:giveAwardList(NewBagArray),
          %% 设置领取奖励
          PlayerID = playerAssist:getCurPlayerID(),
          gameDbProcess:update_Gift_Code(PlayerID, GiftCode),
          %% 设置已领标志
          setHaveGiftCode(SystemId),
          %% 返回客户端领取的奖励物品
          AwardRets = makeGiftItemRets(Award),
          player:send(?CMD_GS2C_GiftGetRet, #pk_GS2C_GiftGetRet{giftItems = AwardRets}),
          %%写日志
          logdbProcess:insertLogGiftCode(PlayerID, GiftCode),
          true
      end
  end.

%% 构建激活码返回值
makeGiftItemRets(AwardList) ->
  Fun = fun(Award, Acc) ->
    {ItemDataId, ItemNum, _Flag} = Award,
    lists:append(Acc, [#pk_GS2C_GiftItem{itemDataId = ItemDataId, num = ItemNum}])
        end,
  lists:foldl(Fun, [], AwardList).

%% 获取玩家领取过的激活码类型
%% call by player process
getHaveGiftCode() ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  case variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_GiftCode) of
    undefined ->
      [];
    GiftCode ->
      GiftCode
  end.

%% 设置玩家领取过的激活码类型
%% call by player process
setHaveGiftCode(GiftCodeNum) ->
  OldCodeList = getHaveGiftCode(),
  NewCodeList = lists:keystore(GiftCodeNum, 1, OldCodeList, {GiftCodeNum}),
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_GiftCode, NewCodeList).

%% 判定玩家是否已经领取了指定的激活码
%% @para GiftCodeNum
%% call by player process
isHaveGiftCode(GiftCodeNum) ->
  OldCodeList = getHaveGiftCode(),
  case lists:keyfind(GiftCodeNum, 1, OldCodeList) of
    false -> false;
    _ -> true
  end.

%% 领取vip等级奖励
vipLevelGetAward(Level) ->
  ?DEBUG(vipLevelGetAward, "Level:~p", [Level]),
  RewardList = vipAward(Level),
  case vipLevelCanGetAward(Level) of
    true ->
      case bagModGiveAward:isCanGiveAwardList(RewardList, false, false) of
        false ->
          chat:messagePromptMe(?Wheel_BagIsEnough_CannotAdd, "");
        _ ->
          [bagMod:addItem(ItemDataId, Count, Flag, ?Item_Change_Content_AddItem_VipLevelAward, ?Item_Change_Content_AddItem_VipLevelAward_Content) || {ItemDataId, Count, Flag} <- RewardList],
          vipSetLevelAward(Level),
          true
      end;
    false ->
      ?ERR(vipLevelGetAward, "you cannot get the award")
  end.

%% 判断vip level 是否可以领奖
%% call by player process
vipLevelCanGetAward(Level) when Level =< 0 ->
  false;
vipLevelCanGetAward(Level) ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  variant:getPlayerVarFlag(PlayerVarArray, ?PlayerVariant_Index_VipLevel_GetAwardCan, Level - 1) andalso
    variant:getPlayerVarFlag(PlayerVarArray, ?PlayerVariant_Index_VipLevel_GetAward, Level - 1) =:= false.

%% 设置指定的等级可以领奖
%% call by player process
vipSetLevelAwardCan(Level) when Level =< 0 ->
  false;
vipSetLevelAwardCan(Level) ->
  variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_VipLevel_GetAwardCan, Level - 1, 1).

%% 设置指定的等级已经领奖
%% call by player process
vipSetLevelAward(Level) when Level =< 0 ->
  false;
vipSetLevelAward(Level) ->
  variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_VipLevel_GetAward, Level - 1, 1).

%% 获取vip指定等级的奖励内容
%% @para VipLevel
%% @return
vipAward(VipLevel) ->
  DataVips = data_vip:get_items(),
  case lists:keyfind(VipLevel, #vipCfg.viplevel, DataVips) of
    false ->
      [];
    DataVip ->
      Player = playerAssist:getCurPlayerRecord(),
      bagModGiveAward:filterAwardByCarrerAndSex(Player, DataVip#vipCfg.awarditems,
        DataVip#vipCfg.zhanshiawarditems,
        DataVip#vipCfg.daoshiawarditems, DataVip#vipCfg.fashiawarditems)
  end.

%%获取vip对应的称号id
%% call by player process
vipTitle() ->
  vipTitleLocal(vipLevel()).

%%获取vip对应的称号id
%% call by other process 
vipTitle(PlayerId) ->
  vipTitleLocal(vipLevel(PlayerId)).

vipTitleLocal(VipLevel) ->
  DataVips = data_vip:get_items(),
  case lists:keyfind(VipLevel, #vipCfg.viplevel, DataVips) of
    false ->
      0;
    DataVip ->
      DataVip#vipCfg.title
  end.

-spec resetVipEveryDayOnTime() -> boolean().
resetVipEveryDayOnTime() ->
  setVipEveryDay(0),
  vipHandle:on_C2GS_VipEveryDayGet().

resetVipEveryDayOnline() ->
  setVipEveryDay(0).

vipEveryDayGet() ->
  ?DEBUG(vipEveryDayGet, "times:~p", [getVipEveryDay()]),
  case isHaveEveryDayTimes() of
    ?Vip_EveryDayHaveTimes ->
      case everyDayGet() of
        true ->
          NowTimes = getVipEveryDay(),
          setVipEveryDay(NowTimes + 1),
          vipHandle:on_C2GS_VipEveryDayGet();
        false ->
          ?DEBUG(vipEveryDayGet, "vip everyday get Item Error")
      end;
    ?Vip_EveryDayNotHaveTimes ->
      ?DEBUG(vipEveryDayGet, "you do not have times")
  end.

isHaveEveryDayTimes() ->
  case vipLevel() > 0 of
    true ->
      Times = getVipEveryDay(),
      ?DEBUG(isHaveEveryDayTimes, "Times:~p", [Times]),
      case Times < ?Vip_EveryDayTimes of
        true ->
          ?Vip_EveryDayHaveTimes;
        false ->
          ?Vip_EveryDayNotHaveTimes
      end;
    false ->
      ?Vip_EveryDayNotHaveTimes
  end.

%%
getVipEveryDay() ->
  Player = playerAssist:getCurPlayerRecord(),
  Player#player.vipEveryDay.

setVipEveryDay(Times) ->
  playerAssist:setCurPlayerProperty(#player.vipEveryDay, Times).

-define(FIRST_PAY_RETURN_MAX, 200000).
addTreasure(AddMoney) ->
  Player = playerAssist:getCurPlayerRecord(),
  PlayerID = Player#player.id,
  OldMoney = Player#player.totaltreasure,
  PlatformId = Player#player.platformID,
  OldLevel = getVipLevelByMoney(PlatformId, OldMoney),
  playerAssist:setCurPlayerProperty(#player.totaltreasure, AddMoney + OldMoney),
  VipLevel = vipLevel(),
  main:changePlayerState_cast(PlayerID, [{#player_state.vipLevel, VipLevel}]),
  erlang:send(leaguePID, {player_vip_level, PlayerID, VipLevel}),
  charPropertyMod:sendSinglePropertyToClient(?Player_Prop_TotalTreasure, AddMoney + OldMoney),
  case isFirstPay() =:= false of
    true ->
      setFirstPay();
    %%首冲充值送等额非绑定元宝,最多200000,开服前15天有效
%% 			case mytime:timestamp()-myshare:get_env(server_open_timestamp) > 86400*15 of
%% 				true->
%% 					ingore;
%% 				false->
%% 					% moneyMod:addPlayerMoney(erlang:min(AddMoney, ?FIRST_PAY_RETURN_MAX), ?Money_Change_Firstpay,  ?Money_BindTreasure, {}),
%% 					case AddMoney > ?FIRST_PAY_RETURN_MAX of
%% 						true->
%% 							moneyMod:addPlayerMoney(?FIRST_PAY_RETURN_MAX, ?Money_Change_Firstpay, ?Money_BindTreasure, {});
%% 						false->
%% 							moneyMod:addPlayerMoney(AddMoney, ?Money_Change_Firstpay, ?Money_BindTreasure, {})
%% 					end
%% 			end;
    false ->
      ignore
  end,

  case VipLevel =/= OldLevel of
    true ->
      case OldLevel =:= 0 of
        true ->
          resetVipEveryDayOnline();
        false ->
          ignore
      end,
      if
        VipLevel > OldLevel ->
          VipUpList = lists:seq(1, VipLevel),
          Fun = fun(VipUpLevelItem, {_ValueAcc, VarArrayAcc}) ->
            %%?DEBUG(addTreasure," VipUpLevelItem ~p OldLevel ~p",[VipUpLevelItem,OldLevel]),
            case VipUpLevelItem > OldLevel of
              true ->
                VipCfgForBroad = data_vip:get_item(#vipCfg.viplevel, VipUpLevelItem),
                case VipCfgForBroad of
                  false ->
                    ok;
                  _ ->
                    BroadcastID = VipCfgForBroad#vipCfg.gonggao,
                    ?DEBUG(addTreasure, " addTreasure BroadcastID ~p", [BroadcastID]),
                    chat:messageClient(0, BroadcastID, [playerAssist:getCurPlayerProperty(#player.name)])
                end;
              _ ->
                ok
            end,
            variant:setVarFlag(VarArrayAcc, ?PlayerVariant_Index_VipLevel_GetAwardCan, VipUpLevelItem - 1, 1)
                end,
          {NewValue, _NewVarArray} = lists:foldl(Fun, {0, Player#player.varArray}, VipUpList),
          variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_VipLevel_GetAwardCan, NewValue),
          achievement:hook(?AchievementVip, lists:seq(OldLevel + 1, VipLevel)),
          mapInterface:changeMapPlayerField_cast(playerAssist:getCurPlayerMapPID(), PlayerID, #mapPlayer.vipLevel, VipLevel),
          Msg = #pk_GS2C_PlayerSinglePropertySync{playerID = PlayerID, type = ?Player_Prop_VipLevel, value = VipLevel},
          playerBroadcast:broadcastTo9Grid(PlayerID, true, ?CMD_GS2C_PlayerSinglePropertySync, Msg),
          charPropertyMod:sendSinglePropertyToClient(?Player_Prop_VipLevel, VipLevel),
          %% 处理玩家摇钱树摇钱次数的修改
          richerUpdateTimes(OldLevel, VipLevel),
          %% vip增加除魔副本及竞技场副本进入次数
          updateCopyCdIncludeArenaCopy(OldLevel, VipLevel),
          rushMissionPlayer:vipAddChallengeTimes(VipLevel), %%VIP增加的封魔塔挑战次数
          mailVipAward(VipLevel),
          doUpgradeVipLevel(playerAssist:getCurPlayerRecord(), VipLevel);
        true ->
          ignore
      end;
    false ->
      ignore
  end,
  ?DEBUG(addtreasure, "AddMoney:~p", [AddMoney]),
  %% 更新玩家的单次充值奖励的逻辑
  vipModEachPay:addTreasure(AddMoney),

  %% 更新玩家的累计充值奖励
  vipModTotalPay:incTodayTotalPay(AddMoney),
  masteriesMod:calculatePlayerMasteriesPoints(AddMoney).

%% call by player process
%% 
vipLevel() ->
  Player = playerAssist:getCurPlayerRecord(),
  Money = Player#player.totaltreasure,
  PlatformId = Player#player.platformID,
  ?DEBUG(vipLevel, "Money:~p", [Money]),
  RetLevel = getVipLevelByMoney(PlatformId, Money),
  ?DEBUG(vipLevel, "RetLevel:~p", [RetLevel]),
  RetLevel.

%% 获取vip等级
%% call by other process
vipLevel(PlayerId) ->
  case playerAssist:getPlayerRecord(PlayerId) of
    undefined ->
      0;
    Player ->
      Money = Player#player.totaltreasure,
      PlatformId = Player#player.platformID,
      ?DEBUG(vipLevel, "Money:~p", [Money]),
      RetLevel = getVipLevelByMoney(PlatformId,Money),
      ?DEBUG(vipLevel, "RetLevel:~p", [RetLevel]),
      RetLevel
  end.


%% ====================================================================
%% Internal functions
%% ====================================================================
%%根据玩家的充值金额，获取当前等级
getVipLevelByMoney(Platform996, Money) when Platform996 =:= ?PLATFORM_SIFU_996 orelse Platform996 =:= ?PLATFORM_SIFU_996_FangYou orelse
  Platform996 =:= ?PLATFORM_SIFU_195 orelse Platform996 =:= ?PLATFORM_SIFU_195_1 orelse Platform996 =:= ?PLATFORM_SIFU_DAMAI ->
  case data_vip_996:get_items() of
    [] ->
      ?DEBUG(getVipLevelByMoney, "NO Vip"),
      0;
    Vips ->
      Fun = fun(VipItem, Acc) ->
        VipMoney = VipItem#vip_996Cfg.money,
        case VipMoney > Money of
          true ->
            throw(Acc);
          false ->
            VipItem#vip_996Cfg.viplevel
        end
            end,
      try
        lists:foldl(Fun, 0, lists:keysort(#vip_996Cfg.money, Vips))
      catch
        throw:Ret -> Ret
      end
  end;
getVipLevelByMoney(PlatformYufeng, Money) when PlatformYufeng =:= ?PLATFORM_SIFU_YUFENG ->
  case data_vip_yf:get_items() of
    [] ->
      ?DEBUG(getVipLevelByMoney, "NO Vip"),
      0;
    Vips ->
      Fun = fun(VipItem, Acc) ->
        VipMoney = VipItem#vip_yfCfg.money,
        case VipMoney > Money of
          true ->
            throw(Acc);
          false ->
            VipItem#vip_yfCfg.viplevel
        end
            end,
      try
        lists:foldl(Fun, 0, lists:keysort(#vip_yfCfg.money, Vips))
      catch
        throw:Ret -> Ret
      end
  end;
getVipLevelByMoney(_PlatformId, Money) ->
  case data_vip:get_items() of
    [] ->
      ?DEBUG(getVipLevelByMoney, "NO Vip"),
      0;
    Vips ->
      Fun = fun(VipItem, Acc) ->
        VipMoney = VipItem#vipCfg.money,
        case VipMoney > Money of
          true ->
            throw(Acc);
          false ->
            VipItem#vipCfg.viplevel
        end
            end,
      try
        lists:foldl(Fun, 0, lists:keysort(#vipCfg.money, Vips))
      catch
        throw:Ret -> Ret
      end
  end.

%%获取具体的奖励物品
everyDayGet() ->
  VipLevel = vipLevel(),
  case data_vipEveryDay:get_item(vipLevel()) of
    false ->
      ?DEBUG(everyDayGet, "vip is Error:~p", [VipLevel]),
      false;
    VipEveryDay ->
      ItemDataId = VipEveryDay#vipEveryDayCfg.itemdataid,
      Ret = bagMod:addItem(ItemDataId, 1, ?Vip_EveryDay_Bind, ?Item_Change_Content_AddItem_VipEveryAward, ?Item_Change_Content_AddItem_VipEveryAward_Content),
      Ret
  end.

%% 更新玩家的vip摇钱树次数
richerUpdateTimes(OldVipLevel, NewVipLevel) ->
  DataVips = data_vip:get_items(),
  OldTimes = case lists:keyfind(OldVipLevel, #vipCfg.viplevel, DataVips) of
               false ->
                 0;
               OldVipCfg ->
                 OldVipCfg#vipCfg.richertimes
             end,
  NewTimes = case lists:keyfind(NewVipLevel, #vipCfg.viplevel, DataVips) of
               false ->
                 0;
               NewVipCfg ->
                 NewVipCfg#vipCfg.richertimes
             end,
  case NewTimes > OldTimes of
    true ->
      richer:addRicherTimes(NewTimes - OldTimes),
      richer:on_C2GS_RicherGetTimes();
    false ->
      ignore
  end.


updateCopyCdIncludeArenaCopy(OldVipLevel, NewVipLevel) ->
  case NewVipLevel =< 0 of
    true -> ignore;
    false ->
      UpdateFunc = fun(#pk_PlayerCopyCDInfo{map_data_id = MapDataId} = CDInfo) ->
        OldExtraCd = getExtraCopyCdIncludeArenaCopy(MapDataId, OldVipLevel),
        NewExtraCd = getExtraCopyCdIncludeArenaCopy(MapDataId, NewVipLevel),
        case NewExtraCd > OldExtraCd of
          true ->
            NewCdInfo = CDInfo#pk_PlayerCopyCDInfo{
              remain_cnt = CDInfo#pk_PlayerCopyCDInfo.remain_cnt + NewExtraCd - OldExtraCd  %%剩余的次数
            },
            player:send(?CMD_GS2C_UpdatPlayerCopyCDInfo, #pk_GS2C_UpdatPlayerCopyCDInfo{map_data_id = NewCdInfo#pk_PlayerCopyCDInfo.map_data_id,
              enter_cnt = NewCdInfo#pk_PlayerCopyCDInfo.enter_cnt,
              remain_cnt = NewCdInfo#pk_PlayerCopyCDInfo.remain_cnt,
              bought_cd_cnt = NewCdInfo#pk_PlayerCopyCDInfo.bought_cd_cnt}),
            NewCdInfo;
          false ->
            CDInfo
        end
                   end,
      NewList = lists:map(UpdateFunc, get(?Player_CopyCDInfoList)),
      put(?Player_CopyCDInfoList, NewList)
  end.


%% arenaUpdateTimes(OldLevel, NewVipLevel) ->
%% 	OldTimes = vipArena(OldLevel),
%% 	NewTimes = vipArena(NewVipLevel),
%% 	case NewTimes > OldTimes of
%% 		true ->
%% 			arenaMod:addArenaCopyTimes(NewTimes - OldTimes);
%% 		false ->
%% 			ignore
%% 	end.

%% upgrade player
doUpgradeVipLevel(#player{} = Player, VipLevel) ->
  ?DEBUG(doUpgradeVipLevel, "doUpgradePlayer --- VipLevel:~p", [VipLevel]),
  Career = Player#player.career,
  ID = Player#player.id,
  Level = Player#player.level,
  case gen_server:call(playerAssist:getCurPlayerMapFightPID(), {'onPlayerLevelChanged', ID, Career, Level, VipLevel}) of
    {ok, FightPlayer} ->
      ?DEBUG(doUpgradeVipLevel, "doUpgradePlayer --- FightPlayer:~p", [FightPlayer]),
      Ret = true;
    {err, 0} -> Ret = false
  end,
  Ret.

%% 判定是否是首冲
%% @return true | false
isFirstPay() ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  variant:getPlayerVarFlag(PlayerVarArray, ?PlayerVariant_Index_Vip_GetAward, ?PlayerVariant_Bit_Vip_FirstAward_Can).

%% 设置首充
setFirstPay() ->
  variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_Vip_GetAward, ?PlayerVariant_Bit_Vip_FirstAward_Can, 1).

%% 获取首充礼包状态是否为新创建玩家角色可以领取
getFirstPayState() ->
  State = variant:getWorldVarValue(?WorldVariant_NewPlayer_GetFirstPay_State),
  ?DEBUG(getFirstPayState, "the state is ~p~n", [State]),
  case State =:= 1 andalso isGetFirstPay() =:= false of
    true ->
      true;
    false ->
      false
  end.


%% 判定是否领取了首充值奖励
%% @return true | false
isGetFirstPay() ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  variant:getPlayerVarFlag(PlayerVarArray, ?PlayerVariant_Index_Vip_GetAward, ?PlayerVariant_Bit_Vip_FirstAward).

%% 设置首充
setGetFirstPay() ->
  variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_Vip_GetAward, ?PlayerVariant_Bit_Vip_FirstAward, 1).

%% 判定是否领取了每日充值奖励
%% @return 1 | 0 | 2 (1：表示可以领取)
isGetEveryDayPay() ->
  PlayerVarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  variant:getPlayerVarValue(PlayerVarArray, ?PlayerVariant_Index_Vip_EveryDayPayAward).

%% 设置每日充值领取标志
setEveryDayPay(Flage) ->
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_EveryDayPayAward, Flage).


%%重置vip 带来的好处，每天凌晨做

resetVipBenifits() ->
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeMine, 0),
  variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeRicher, 0),
%% 	variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeDrink, 0),
  setEveryDayPay(0),
  ok.

isMineForFree() ->
  OldMineTime = getMineUsedFreeTime(),
  OldMineTime < getMineTotalFreeTime().

getMineTotalFreeTime() ->
  VipLevel = vipMod:vipLevel(),
  case vipMod:vipCfgData(VipLevel) of
    false ->
      0;
    VicCfg ->
      VicCfg#vipCfg.minetime
  end.

getMineUsedFreeTime() ->
  VarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  OldMineTime0 = variant:getPlayerVarValue(VarArray, ?PlayerVariant_Index_Vip_FreeMine),
  case OldMineTime0 of
    undefined ->
      OldMineTime = 0;
    _ ->
      OldMineTime = OldMineTime0
  end,
  OldMineTime.

costMineFreeTime(CostTime) ->
  case CostTime < 0 of
    true ->
      ?ERR(costMineFreeTime, "costMineFreeTime ~p PlayerID ~p", [CostTime, playerAssist:getCurPlayerID()]);
    _ ->
      OldMineTime = getMineUsedFreeTime(),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeMine, OldMineTime + CostTime)
  end.



isRicherForFree() ->
  OldMineTime = getRicherUsedFreeTime(),
  OldMineTime < getRicherTotalFreeTime().

getRicherTotalFreeTime() ->
  VipLevel = vipMod:vipLevel(),
  case vipMod:vipCfgData(VipLevel) of
    false ->
      0;
    VicCfg ->
      VicCfg#vipCfg.richertime
  end.

getRicherUsedFreeTime() ->
  VarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  OldMineTime0 = variant:getPlayerVarValue(VarArray, ?PlayerVariant_Index_Vip_FreeRicher),
  case OldMineTime0 of
    undefined ->
      OldMineTime = 0;
    _ ->
      OldMineTime = OldMineTime0
  end,
  OldMineTime.

costRicherFreeTime(CostTime) ->
  case CostTime < 0 of
    true ->
      ?ERR(costMineFreeTime, "costMineFreeTime ~p PlayerID ~p", [CostTime, playerAssist:getCurPlayerID()]);
    _ ->
      OldFreeTime = getRicherUsedFreeTime(),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeRicher, OldFreeTime + CostTime)
  end.

%% 获取额外的翻牌次数
getVipExtraDrawLuckyCnt(VipLevel, MapId) ->
  ExtraCopy =
  case data_copy_info:get_item(MapId) of
    false ->
      false;
    CopyCfg ->%% [{0}] 或是[{20},{20},```]
      erlang:length(CopyCfg#copy_infoCfg.draw_lucky_price) > 1
  end,
  case ExtraCopy of
    true ->
      case data_vip:get_item(#vipCfg.viplevel, VipLevel) of
        VipCfg when erlang:is_record(VipCfg, vipCfg) ->
          VipCfg#vipCfg.chumofanpai;
        _ ->
          0
      end;
    false ->
      0
  end.

%% ------------------------   vip 篝火晚会免费喝酒次数处理-----------------------------------	
isDrinkForFree() ->
  OldDrinkTime = getDrinkUsedFreeTime(),
 	OldDrinkTime < getDrinkTotalFreeTime().

%% 获取能够免费喝酒次数（吃肉）
getDrinkTotalFreeTime()->
 	VipLevel = vipMod:vipLevel(),
 	case vipMod:vipCfgData(VipLevel) of
 		false->
 			0;
 		VicCfg->
 			VicCfg#vipCfg.drinktime + 1
 	end.

getDrinkUsedFreeTime()->
 	VarArray = playerAssist:getCurPlayerProperty(#player.varArray),
 	OldDrinkTime0 = variant:getPlayerVarValue(VarArray, ?PlayerVariant_Index_Vip_FreeDrink),
 	case OldDrinkTime0 of
 		undefined->
 			OldDrinkTime = 0;
 		_->
 			OldDrinkTime = OldDrinkTime0
 	end,
 	OldDrinkTime.

costDrinkFreeTime(CostTime)->
 	case CostTime < 0 of
 		true->
 			?ERR(costDrinkFreeTime,"costDrinkFreeTime ~p PlayerID ~p",[CostTime,playerAssist:getCurPlayerID()]);
 		_->
 			OldFreeTime = getDrinkUsedFreeTime(),
 			variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeDrink, OldFreeTime + CostTime)
 	end.

%% 下面是吃肉
isEatForFree() ->
  OldEatTime = getEatUsedFreeTime(),
  OldEatTime < getEatTotalFreeTime().

%% 获取能够免费喝酒次数（吃肉）
getEatTotalFreeTime()->
  VipLevel = vipMod:vipLevel(),
  case vipMod:vipCfgData(VipLevel) of
    false->
      0;
    VicCfg->
      VicCfg#vipCfg.drinktime + 1
  end.

getEatUsedFreeTime()->
  VarArray = playerAssist:getCurPlayerProperty(#player.varArray),
  OldEatTime0 = variant:getPlayerVarValue(VarArray, ?PlayerVariant_Index_Vip_FreeEat),
  case OldEatTime0 of
    undefined->
      OldEatTime = 0;
    _->
      OldEatTime = OldEatTime0
  end,
  OldEatTime.

costEatFreeTime(CostTime)->
  case CostTime < 0 of
    true->
      ?ERR(costEatFreeTime,"costEatFreeTime ~p PlayerID ~p",[CostTime,playerAssist:getCurPlayerID()]);
    _->
      OldFreeTime = getEatUsedFreeTime(),
      variant:setPlayerVarValueFromPlayer(?PlayerVariant_Index_Vip_FreeEat, OldFreeTime + CostTime)
  end.

mailVipAward(VipLevel) ->
  VipCfg = data_vip:get_item(#vipCfg.viplevel, VipLevel),
  case VipCfg of
    false ->
      ignore;
    #vipCfg{mailaward = MailAward} ->
      case MailAward of
        [] ->
          ignore;
        [{Coin} | ItemList ] ->
          MailTitle = ?ServerStr(43),
          MailContent = io_lib:format(?ServerStr(158),[VipLevel]),
          MailSendName = ?ServerStr(5),
          PkLS2GSItemList = lists:map(fun({ItemDataId, ItemNum, BindFlag}) ->
            #pk_LS2GS_Item{itemDataId = ItemDataId, itemCnt = ItemNum, flag = BindFlag}
                                      end,
                                      ItemList),
          mailMgrMod:sendSystemMail(MailTitle, MailContent, MailSendName,playerAssist:getCurPlayerID(),PkLS2GSItemList,Coin, 0, 0, 0)
      end
  end.

recalculate_vip_award(VipLevel) when (VipLevel > 0) ->
  VipUpList = lists:seq(1, VipLevel),
  lists:foreach(fun(I) ->
    variant:setPlayerVarFlagFromPlayer(?PlayerVariant_Index_VipLevel_GetAwardCan, I - 1, 1)
                end,
  VipUpList),
  achievement:hook(?AchievementVip, lists:seq(1, VipLevel));
recalculate_vip_award(_VipLevel) ->
  ignore.


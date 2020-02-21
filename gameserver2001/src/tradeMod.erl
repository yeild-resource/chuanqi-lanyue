-module(tradeMod).

-include("record.hrl").
-include("pt.hrl").
-include("trade.hrl").
-include("money.hrl").
-include("common_include/logger.hrl").
-include("playerDefine.hrl").
-include("itemDefine.hrl").
-include("tipStr.hrl").
-include("globalDefine.hrl").
-include("npc.hrl").
-include("variant.hrl").
-include("leagueDefine.hrl").
-include("liveness.hrl").
-include("platformDefine.hrl").

-define(TradeBusy, "tradeBusy").
-define(TradeLevel, 40).
%%
%% Exported Functions
%%
-export([
  tradeChange/7,
  npc_buy/3,
  get_npc_item/2,
  deleteIndex/1,
  require/1,
  agree/2,
  addItem/4,
  delItem/2,
  changeTreasure/3,
  lock/1,
  unLock/1,
  ensure/1,
  cancelTradeByPlayerID/0,
  cancel/1,
  cancelWithOutNotice/1,
  storeBuy/2,
  isTradeBusy/0,
  setTradeBusy/1,
  setTradeBusyByTradeProcess/2,
  on_tradeDeleteTimerRpc/0,
  vipBuy/2,
  mysteryShopBuyItem/2
]).

%% vip 购买蓝药和红药
vipBuy(VipBuyItemID, VipBuyItemNum) ->
  Player = playerAssist:getCurPlayerRecord(),
  Level = Player#player.level,
  VipLevel = vipMod:vipLevel(),
  VipBuyData = getVipBuyData(Level),
  ?INFO(vipBuy, "vipBuyData:~p, VipLevel:~p", [VipBuyData, VipLevel]),
  case VipBuyData#vipbuyCfg.vipneed =< VipLevel andalso (VipBuyData#vipbuyCfg.itemid_hp =:= VipBuyItemID orelse VipBuyData#vipbuyCfg.itemid_mp =:= VipBuyItemID) of
    true ->
      case data_item:get_item(VipBuyItemID) of
        false ->
          ?ERR(vipBuy, "NO This Item, item data id error,VipBuyItemID:~p", [VipBuyItemID]);
        ItemCfg ->
          MoneyType = ItemCfg#itemCfg.buytype,
          MoneyNum = ItemCfg#itemCfg.buyprice,
          case MoneyType =:= ?Money_None of
            true ->
              ?INFO(vipBuy, "this is item cannot buy");
            false ->
              case moneyMod:is_money_enough(MoneyType, VipBuyItemNum * MoneyNum) of
                false ->
                  ?INFO(vipBuy, "YOU DONOT HAVE ENOUGH MONEY");
                true ->
                  case bagMod:is_can_add_item(VipBuyItemID, VipBuyItemNum, ?Item_Bind_Type_Bind) of
                    false ->
                      ?DEBUG(vipBuy, "BAG NOT ENOUGH");
                    true ->
                      ?DEBUG(vipBuy, "MoneyType:~p, MoneyNum:~p", [MoneyType, VipBuyItemNum * MoneyNum]),
                      moneyMod:decMoney(MoneyType, VipBuyItemNum * MoneyNum, ?Money_Change_VipBuy),
                      bagMod:addItem(VipBuyItemID, VipBuyItemNum, ?Item_Bind_Type_Bind, ?Item_Change_Content_VipBuyItem, ?Item_Change_Content_VipBuyItem_Content)
                  end
              end
          end
      end;
    false ->
      ?INFO(vipBuy, "vip level not enough,VipBuyItemID ~p VipLevel ~p ~n VipBuyData~p", [VipBuyItemID, VipLevel, VipBuyData])
  end.

%% 获取根据等级能够股买的物品
%% @para Level  玩家等级
%% @return #vipbuyCfg
getVipBuyData(Level) ->
  Fun = fun(VipBuyCfg, Acc) ->
    case Level < VipBuyCfg#vipbuyCfg.level of
      true -> throw(VipBuyCfg);
      false -> Acc
    end
        end,
  try
    lists:foldl(Fun, #vipbuyCfg{}, data_vipbuy:get_items())
  catch
    throw:Ret -> Ret
  end.


%% clear 异常的交易信息
on_tradeDeleteTimerRpc() ->
  ?TradePidName ! {tradeDeleteTimer}.

%% 交易修改玩家的物品
%% 
tradeChange(ItemArray, Treasure, Coin, DestItemArray, DestTreasure, DestCoin, DestPlayerID) ->
  tradePro:tradeChange(ItemArray, Treasure, Coin, DestItemArray, DestTreasure, DestCoin, DestPlayerID).

%% call by all process
isTradeBusy() ->
  case get(?TradeBusy) of
    undefined -> false;
    Ret -> Ret
  end.

%% set trade busy
setTradeBusy(Busy) ->
  put(?TradeBusy, Busy),
  case Busy of
    true -> mineMod:stop_mine();
    false -> ignore
  end.

%% 设置玩家忙碌 call by tradeprocess
setTradeBusyByTradeProcess(PlayerID, Busy) ->
  case playerAssist:getPlayerPID(PlayerID) of
    0 ->
      ignore;
    PlayerPid ->
      PlayerPid ! {setTradeBusy, Busy}
  end.


%%功能：商城购买物品
%% call by player process
%% @para StoreItemID
%% @para StoreItemNum
%% @return
storeBuy(StoreItemID, StoreItemNum) ->
  Player = playerAssist:getCurPlayerRecord(),
  #player{platformID = PlatformId} = Player,
  ShopCfg =
    case PlatformId of
      Sifu996 when Sifu996 =:= ?PLATFORM_SIFU_996 orelse Sifu996 =:= ?PLATFORM_SIFU_996_FangYou orelse
        Sifu996 =:= ?PLATFORM_SIFU_195 orelse Sifu996 =:= ?PLATFORM_SIFU_195_1 orelse Sifu996 =:= ?PLATFORM_SIFU_DAMAI ->
        [Item] = ets:match_object(otherOnlineShopTable, #shop_996Cfg{id = StoreItemID, _='_'}),
        erlang:setelement(1, Item, shopCfg);
      SifuYufeng when SifuYufeng =:= ?PLATFORM_SIFU_YUFENG ->
        [Item] = ets:match_object(otherOnlineShopTable, #shop_yfCfg{id = StoreItemID, _='_'}),
        erlang:setelement(1, Item, shopCfg);
      _ ->
        etsBaseFunc:readRecord(onlineShopTable, StoreItemID)
    end,
  MoneyType = ShopCfg#shopCfg.price_type,
  MoneyNum = ShopCfg#shopCfg.sellprice,
  Bind = ShopCfg#shopCfg.bind,
  case MoneyType =:= ?Money_None of
    true ->
      ?INFO(storeBuy, "this is item cannot buy");
    false ->
      case moneyMod:is_money_enough(MoneyType, StoreItemNum * MoneyNum) of
        false ->
          ?INFO(storeBuy, "YOU DONOT HAVE ENOUGH MONEY");
        true ->
          ItemDataId = ShopCfg#shopCfg.itemid,
          BagDataArray = bagMod:get_bag_array(),
          case data_item:get_item(ItemDataId) of
            false ->
              ?INFO(storeBuy, "no this item");
            ItemCfg ->
              FixNum0 = StoreItemNum div ItemCfg#itemCfg.overlaycnt,
              Rem = StoreItemNum rem ItemCfg#itemCfg.overlaycnt,
              case Rem > 0 of
                true -> FixNum = FixNum0 + 1;
                false -> FixNum = FixNum0
              end,
              case bagMod:get_idle_num(BagDataArray) >= FixNum of
                false ->
                  ?DEBUG(storeBuy, "BAG NOT ENOUGH"),
                  chat:messagePromptMe(?TipStr_StoreBuy_BagNotEnough, "");
                true ->
                  ?DEBUG(storeBuy, "MoneyType:~p, MoneyNum:~p, ItemDataId:~p", [MoneyType, StoreItemNum * MoneyNum, ItemDataId]),
                  case bagMod:addItem(ItemDataId, StoreItemNum, Bind, ?Item_Change_Content_AddItem_StoreBuy, ?Item_Change_Content_AddItem_StoreBuy_Content) of
                    false ->
                      ?ERR(storeBuy, "storeBuy ~p failed ItemDataId ~p StoreItemNum ~p busy ~p ",
                        [playerAssist:getCurPlayerID(), ItemDataId, StoreItemNum, tradeMod:isTradeBusy()]),
                      chat:messagePromptMe(?TipStr_TowerCode_GoldIsNotEnough, ""), %%TODO 临时TIPS
                      ok;
                    _ ->
                      moneyMod:decMoney(MoneyType, StoreItemNum * MoneyNum, ItemDataId),
                      liveness:onFinishLiveNess(?LiveNess_ShangCheng, 1),
                      ok
                  end,
                  ItemName = case data_item:get_item(ItemDataId) of
                               false ->
                                 "";
                               ItemCfg ->
                                 ItemCfg#itemCfg.name
                             end,
                  chat:messagePromptMe(?TipStr_StoreBuy_Suc, [ItemName, StoreItemNum])
              end
          end
      end
  end.

%%功能：发起交易请求
require(PlayerID) ->
  PlayerRecord = playerAssist:getCurPlayerRecord(),
  case PlayerRecord#player.level >= ?TradeLevel of
    true ->
      CurPlayerID = playerAssist:getCurPlayerID(),
      case blackListMod:checkBlackList(PlayerID, CurPlayerID) of
        true -> chat:messagePrompt(CurPlayerID, ?TipStr_TradeFailed_InBlack, "");
        false ->
          case tradeMod:isTradeBusy() of
            true ->
              ?INFO(require, "Player is busy ~p dest ~p", [CurPlayerID, PlayerID]),
              false;
            _ ->
              put("TradeItemGrid", []),
              ?INFO(require, "Player reque trade src ~p dest ~p", [CurPlayerID, PlayerID]),
              ?TradePidName ! {require, CurPlayerID, PlayerID}
          end
      end;
    false -> false
  end.

%%功能：同意交易请求
agree(TradeID, Respond) ->
  PlayerRecord = playerAssist:getCurPlayerRecord(),
  case PlayerRecord#player.level >= ?TradeLevel of
    true ->
      CurPlayerID = playerAssist:getCurPlayerID(),
      case tradeMod:isTradeBusy() of
        true ->
          ?INFO(agree, "Player is TradeID ~p Respond ~p", [TradeID, Respond]),
          false;
        _ ->
          put("TradeItemGrid", []),
          ?INFO(agree, "Player agree TradeID ~p Respond ~p", [TradeID, Respond]),
          ?TradePidName ! {agree, CurPlayerID, TradeID, Respond}
      end;
    false ->
      false
  end.

%%功能：增加物品
addItem(TradeID, Index, ItemId, Part) ->
  CurPlayerID = playerAssist:getCurPlayerID(),

  case bagMod:getItemByIndex(Index) of
    undefined ->
      ?DEBUG(addItem, "YOU DONOT HAVE THE ITEM");
    Item ->
      case Item#item.id =:= ItemId of
        false -> ?DEBUG(addItem, "YOU DONOT HAVE THE ITEM");
        true ->
          case Item#item.flag =:= ?Item_Bind_Type_UnBind of
            true ->
              TradeItem = #tradeItem{
                id = Item#item.id,
                index = Index, %% 背包中的位置
                itemDataId = Item#item.itemDataId,
                count = Item#item.count,
                flag = Item#item.flag,
                stars = Item#item.stars,
                luck = Item#item.luck,
                equipRandAttrArray = Item#item.equipRandAttrArray,
                fujia = Item#item.fujiaRandAttrArray,
                insuranceTimes = Item#item.insuranceTimes,
                curse = Item#item.curse,
                expiretime = Item#item.expiretime,
                itemArrayForSpaceRing = Item#item.itemArrayForSpaceRing,
                curProcessValue = Item#item.processValue
              },

              case Item#item.itemArrayForSpaceRing =/= undefined andalso wareHouseMod:checkItemInSpaceRing(0, Item#item.itemArrayForSpaceRing) =/= true of
                true -> chat:messagePromptMe(?SpaceRing_Is_Not_Trade, "");
                false ->
                  FunFind = fun(OldID, Acc) ->
                    case OldID =:= Index of
                      true ->
                        true;
                      _ ->
                        Acc
                    end
                            end,
                  OldIDList0 = get("TradeItemGrid"),
                  case OldIDList0 of
                    undefined ->
                      OldIDList = [];
                    _ ->
                      OldIDList = OldIDList0
                  end,
                  case lists:foldl(FunFind, false, OldIDList) of
                    true ->
                      ?ERR(addItem, "trade cheat item  ~p", [playerAssist:getCurPlayerID()]),
                      ok;
                    _ ->
                      NewIDList = [Index | OldIDList],
                      put("TradeItemGrid", NewIDList),
                      ?TradePidName ! {addItem, CurPlayerID, TradeID, Part, TradeItem}
                  end
              end;
            false ->
              chat:messagePromptMe(?TipStr_Trade_Bind_Cannot_Trade, "")
          end
      end
  end.

%%功能：减少物品
delItem(TradeID, Part) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {delItem, CurPlayerID, TradeID, Part}.

deleteIndex(Index) ->
  case get("TradeItemGrid") of
    undefiend ->
      ?ERR(deleteIndex, "player~P", [playerAssist:getCurPlayerRecord()]),
      ingore;
    OldIDList0 ->
      put("TradeItemGrid", lists:delete(Index, OldIDList0))
  end.

%%功能:改变元宝
changeTreasure(TradeID, Treasure, Coin) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  case moneyMod:is_money_enough(?Money_Coin, Coin)%%TODO:这是调整货币类型时暂定的金钱类型，维护的人可到时候根据文档设置具体的钱的类型(绑定和非绑定)
    andalso moneyMod:is_money_enough(?Money_Treasure, Treasure) of%%TODO:这是调整货币类型时暂定的金钱类型，维护的人可到时候根据文档设置具体的钱的类型(绑定和非绑定)
    true ->
      ?TradePidName ! {changeTreasure, CurPlayerID, TradeID, Treasure, Coin};
    false ->
      ?DEBUG(changeTreasure, "YOU DONOT HAVE ENOUGH MONEY")
  end.

%%功能：锁定交易
lock(TradeID) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {lock, CurPlayerID, TradeID}.

%%功能：解除交易
unLock(TradeID) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {unLock, CurPlayerID, TradeID}.

%%功能：确定交易
ensure(TradeID) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {ensure, CurPlayerID, TradeID}.

%%功能：解除确定交易
cancel(TradeID) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {cancel, CurPlayerID, TradeID}.

%%功能：解除确定交易
cancelWithOutNotice(TradeID) ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {cancelWithOutNotice, CurPlayerID, TradeID}.

%%功能：解除玩家的交易记录
cancelTradeByPlayerID() ->
  CurPlayerID = playerAssist:getCurPlayerID(),
  ?TradePidName ! {cancelByPlayerID, CurPlayerID}.


%%功能：array根据key进行查找
%%@para NpcDataId
%%@para ItemDataId
%%@para Num
%%@return

%%NPC ID 10, 行会商店
npc_buy(10, ItemDataId, Num) ->
  PlayerId = playerAssist:getCurPlayerID(),
  LeaguePlayerState = etsBaseFunc:readRecord(?LeaguePlayerStateTableAtom, PlayerId),
  case LeaguePlayerState of
    {} ->
      chat:messagePromptMe(3235, []);
    _LeaguePlayerState ->
      #leaguePlayer_state{contributions = MyLeagueContribution, leagueId = MyLeagueId} = LeaguePlayerState,
      LeagueState = etsBaseFunc:readRecord(?LeagueStateTableAtom, MyLeagueId),
      LeagueLevel = LeagueState#league_state.level,
      LeagueShopItem = data_leagueShop:get_item(LeagueLevel),
      BuyingItemList = LeagueShopItem#leagueShopCfg.items,
      case lists:keyfind(ItemDataId,1, BuyingItemList) of
        false ->
          chat:messagePromptMe(3241, []),
          ignore;
        {ItemDataId, _MoneyType, RequiredMoneyNum, Bind} ->
          case MyLeagueContribution >= RequiredMoneyNum of
            false ->
              chat:messagePromptMe(3235, []);
            true  ->
              case bagMod:is_can_add_item(ItemDataId, Num, Bind) of
                false ->
                  ?ERR( npc_buy, "Cannot buy item cause bag is full");
                true ->
                  erlang:send(leaguePID,{addContribution, MyLeagueId, PlayerId, -RequiredMoneyNum}),
                  bagMod:addItem(ItemDataId, Num, Bind, ?Item_Change_Content_AddItem_NpcBuy,?Item_Change_Content_AddItem_NpcBuy_Content)
              end
          end
      end
  end;
npc_buy(NpcDataId, ItemDataId, Num) ->
  case get_npc_item(NpcDataId, ItemDataId) of
    false ->
      ?DEBUG(npc_buy, "YOU CANNOT BUY THIS ITEM");
    {_, MoneyType, MoneyTmp, Bind} ->
      case data_item:get_item(ItemDataId) of
        false ->
          ?ERR(npc_buy, "NO This Item, item data id error,ItemDataId:~p", [ItemDataId]);
        _ItemCfg ->
          PlayerId = playerAssist:getCurPlayerID(),
          NpcData = data_npc:get_item(NpcDataId),
          case NpcData of
            false -> ?DEBUG(get_npc_item, "NO THIS NPC");
            _ ->
              NpcFunction = NpcData#npcCfg.function,
              MoneyNum =
                case NpcFunction  of
                  ?Npc_Func_HuangChengWar ->
                    case variant:getWorldVarValue(?WorldVariant_Huang_Cheng_Zheng_Ba_LeagueId) of
                      undefined ->
                        MoneyTmp;
                      LeagueId ->
                        case etsBaseFunc:readRecord(?LeaguePlayerStateTableAtom, PlayerId) of
                          {} -> MoneyTmp;
                          LeaguePlayer ->
                            if LeaguePlayer#leaguePlayer_state.leagueId =:= LeagueId ->
                              common:ceil(MoneyTmp * 0.8);
                              true -> MoneyTmp
                            end
                        end
                    end;
                  _ ->
                    MoneyTmp
                end,
              case MoneyNum > 0 of
                false ->
                  ignore;
                true ->
                  case MoneyType of
                    ?Money_None ->
                      ?INFO(npc_buy, "this is item cannot buy");
                    ?Money_LeagueContribution ->
                        LeaguePlayerState = etsBaseFunc:readRecord(?LeaguePlayerStateTableAtom, PlayerId),
                        case LeaguePlayerState of
                          {} ->
                            chat:messagePromptMe(3235, []);
                          _LeaguePlayerState ->
                            #leaguePlayer_state{contributions = MyLeagueContribution, leagueId = MyLeagueId} = LeaguePlayerState,
                            RequiredLeagueContribution = MoneyTmp,
                            case MyLeagueContribution >= RequiredLeagueContribution of
                              false ->
                                chat:messagePromptMe(3235, []);
                              true  ->
                                case bagMod:is_can_add_item(ItemDataId, Num, Bind) of
                                  false ->
                                    ?ERR( npc_buy, "Cannot buy item cause bag is full");
                                  true ->
                                    erlang:send(leaguePID,{addContribution, MyLeagueId, PlayerId, -RequiredLeagueContribution}),
                                    bagMod:addItem(ItemDataId, Num, Bind, ?Item_Change_Content_AddItem_NpcBuy,?Item_Change_Content_AddItem_NpcBuy_Content)
                                end
                            end
                        end;
                    _ElseMoneyType ->
                      case moneyMod:is_money_enough(MoneyType, Num * MoneyNum) of
                        false ->
                          ?INFO(npc_buy, "YOU DONOT HAVE ENOUGH MONEY");
                        true ->
                          case bagMod:is_can_add_item(ItemDataId, Num, Bind) of
                            false ->
                              ?DEBUG(npc_buy, "BAG NOT ENOUGH");
                            true ->
                              ?DEBUG(npc_buy, "MoneyType:~p, MoneyNum:~p", [MoneyType, Num * MoneyNum]),
                              moneyMod:decMoney(MoneyType, Num * MoneyNum, ?Money_Change_NpcBuy),
                              taskMod:updateBuyProgress(NpcDataId, Num),
                              bagMod:addItem(ItemDataId, Num, Bind, ?Item_Change_Content_AddItem_NpcBuy, ?Item_Change_Content_AddItem_NpcBuy_Content)
                          end
                      end
                  end
              end
          end
      end
  end.

%%功能；获取商店卖出的物品信息
%%@para NpcDataId
%%@para ItemDataId
%%@return
get_npc_item(NpcDataId, ItemDataId) ->
  NpcData = data_npc:get_item(NpcDataId),
  case NpcData of
    false ->
      ?DEBUG(get_npc_item, "NO THIS NPC"),
      false;
    _ ->
      Sells = NpcData#npcCfg.sell,
      case lists:keyfind(ItemDataId, 1, Sells) of
        false ->
          false;
        Result ->
          Result
      end
  end.

%% 神秘商店购买物品（花费非绑定元宝）
mysteryShopBuyItem(ItemDataId, StoreItemNum) ->
  ShoplimitedCfg = data_shoplimitedTimeDiscount:get_item(#shoplimitedTimeDiscountCfg.itemid, ItemDataId) ,
  MoneyType = ?Money_Treasure,
  case moneyMod:is_money_enough(MoneyType, ShoplimitedCfg#shoplimitedTimeDiscountCfg.sellprice * StoreItemNum) of
    false ->
      ?ERR(mysteryShopBuyItem, "YOU DONOT HAVE ENOUGH MONEY");
    true ->
      BagDataArray = bagMod:get_bag_array(),
      case data_item:get_item(ItemDataId) of
        false ->
          ?INFO(mysteryShopBuyItem, "no this item");
        ItemCfg ->
          FixNum0 = StoreItemNum div ItemCfg#itemCfg.overlaycnt,
          Rem = StoreItemNum rem ItemCfg#itemCfg.overlaycnt,
          case Rem > 0 of
            true -> FixNum = FixNum0 + 1;
            false -> FixNum = FixNum0
          end,
          case bagMod:get_idle_num(BagDataArray) >= FixNum of
            false ->
              ?DEBUG(mysteryShopBuyItem, "BAG NOT ENOUGH"),
              chat:messagePromptMe(?TipStr_StoreBuy_BagNotEnough, "");
            true ->
              case bagMod:addItem(ItemDataId, StoreItemNum, ShoplimitedCfg#shoplimitedTimeDiscountCfg.bind,
                ?Item_Change_Content_AddItem_StoreBuy,
                ?Item_Change_Content_AddItem_StoreBuy_Content) of
                false ->
                  ?ERR(mysteryShopBuyItem, "storeBuy ~p failed ItemDataId ~p StoreItemNum ~p",[playerAssist:getCurPlayerID(), ItemDataId, StoreItemNum]),
                  chat:messagePromptMe(?TipStr_TowerCode_GoldIsNotEnough, ""), %%TODO 临时TIPS
                  ok;
                _ ->
                  moneyMod:decMoney(MoneyType, StoreItemNum * ShoplimitedCfg#shoplimitedTimeDiscountCfg.sellprice,ItemDataId),
                  ok
              end,
              ItemName = case data_item:get_item(ItemDataId) of
                           false ->
                             "";
                           ItemCfg ->
                             ItemCfg#itemCfg.name
                         end,
              chat:messagePromptMe(?TipStr_StoreBuy_Suc, [ItemName, StoreItemNum])
          end
      end
  end.


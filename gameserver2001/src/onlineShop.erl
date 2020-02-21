-module(onlineShop).

-behaviour(gen_server).

-include("common_include/logger.hrl").
-include("record.hrl").
-include("pt_20.hrl").
-include("playerDefine.hrl").
-include("platformDefine.hrl").
-include("common_include/condition_compile.hrl").
-include_lib("stdlib/include/ms_transform.hrl").

-define(Flag_Normal, 0).%热卖
-define(Flag_Hot, 1).%热卖
-define(Flag_ChepPrice, 2).%优惠促销

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/0, onGetShopItemList/0, requestModifySellPrice/2, requestUpdateAllItem/0]).


-record(shopState, {shopEts}).

start_link() ->
  gen_server:start_link({local, onlineShopPid}, ?MODULE, [], [{timeout, ?Start_Link_TimeOut_ms}]).

init([]) ->
  OnlineShopTable = ets:new(onlineShopTable, [set, public, named_table, {keypos, #shopCfg.id}, {read_concurrency, true}]),
  ets:new(otherOnlineShopTable, [bag, public, named_table,{read_concurrency, true}]),
  insertAllItem(),
  {ok, #shopState{shopEts = OnlineShopTable}}.

handle_call(Request, _From, State) ->
  ?ERR(handle_call, "unkown msg:~p", [Request]),
  {noreply, State}.


handle_cast(Msg, State) ->
  ?ERR(handle_cast, "unkown msg:~p", [Msg]),
  {noreply, State}.

handle_info(Info, State) ->
  case Info of
    {requestModifySellPrice, ID, NewSellPrice} ->
      NewState = onModifySellPrice(State, ID, NewSellPrice);
    {requestUpdateAllItem} ->
      onUpdateAllItem(State),
      NewState = State;
    _ ->
      NewState = State
  end,
  {noreply, NewState}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

onGetShopItemList() ->
  Player = playerAssist:getCurPlayerRecord(),
  #player{platformID = PlatformId, id = PlayerId} = Player,
  getShopItemList(PlayerId, PlatformId).

getShopItemList(PlayerId, PlatformId) when PlatformId =:= ?PLATFORM_SIFU_996_FangYou orelse PlatformId =:= ?PLATFORM_SIFU_996 orelse
  PlatformId =:= ?PLATFORM_SIFU_195 orelse PlatformId =:= ?PLATFORM_SIFU_195_1 orelse PlatformId =:= ?PLATFORM_SIFU_DAMAI ->
  FunConvert = fun(ItemCfg) ->
    case ItemCfg#shop_996Cfg.sellprice =/= ItemCfg#shop_996Cfg.price of
      true ->
        NewFlag = ?Flag_ChepPrice;
      _ ->
        NewFlag = ItemCfg#shop_996Cfg.flag
    end,
    #pk_shopItem{
      shopID = ItemCfg#shop_996Cfg.id,
      itemID = ItemCfg#shop_996Cfg.itemid,
      item_type = ItemCfg#shop_996Cfg.item_type,
      price_type = ItemCfg#shop_996Cfg.price_type,
      sell_price = ItemCfg#shop_996Cfg.sellprice,
      flag = NewFlag,
      show_order = ItemCfg#shop_996Cfg.show_order,
      show_price = ItemCfg#shop_996Cfg.price,
      bind = ItemCfg#shop_996Cfg.bind
    }
               end,
  Q = ets:fun2ms(fun(X) when erlang:is_record(X,shop_996Cfg) -> X end),
  ItemList = ets:select(otherOnlineShopTable, Q),
  SendList = lists:map(FunConvert, ItemList),
  Msg = #pk_GS2C_shopItemList{itemList = SendList},
  playerAssist:sendToPlayerByPlayerID(PlayerId, ?CMD_GS2C_shopItemList, Msg);

getShopItemList(PlayerId, PlatformId) when PlatformId =:= ?PLATFORM_SIFU_YUFENG ->
  FunConvert = fun(ItemCfg) ->
    case ItemCfg#shop_yfCfg.sellprice =/= ItemCfg#shop_yfCfg.price of
      true ->
        NewFlag = ?Flag_ChepPrice;
      _ ->
        NewFlag = ItemCfg#shop_yfCfg.flag
    end,
    #pk_shopItem{
      shopID = ItemCfg#shop_yfCfg.id,
      itemID = ItemCfg#shop_yfCfg.itemid,
      item_type = ItemCfg#shop_yfCfg.item_type,
      price_type = ItemCfg#shop_yfCfg.price_type,
      sell_price = ItemCfg#shop_yfCfg.sellprice,
      flag = NewFlag,
      show_order = ItemCfg#shop_yfCfg.show_order,
      show_price = ItemCfg#shop_yfCfg.price,
      bind = ItemCfg#shop_yfCfg.bind
    }
               end,
  Q = ets:fun2ms(fun(X) when erlang:is_record(X,shop_yfCfg) -> X end),
  ItemList = ets:select(otherOnlineShopTable, Q),
  SendList = lists:map(FunConvert, ItemList),
  Msg = #pk_GS2C_shopItemList{itemList = SendList},
  playerAssist:sendToPlayerByPlayerID(PlayerId, ?CMD_GS2C_shopItemList, Msg);

getShopItemList(PlayerID, _OtherPlatformId) ->
  ItemList = ets:tab2list(onlineShopTable),
  FunConvert = fun(ItemCfg) ->
    case ItemCfg#shopCfg.sellprice =/= ItemCfg#shopCfg.price of
      true ->
        NewFlag = ?Flag_ChepPrice;
      _ ->
        NewFlag = ItemCfg#shopCfg.flag
    end,
    #pk_shopItem{
      shopID = ItemCfg#shopCfg.id,
      itemID = ItemCfg#shopCfg.itemid,
      item_type = ItemCfg#shopCfg.item_type,
      price_type = ItemCfg#shopCfg.price_type,
      sell_price = ItemCfg#shopCfg.sellprice,
      flag = NewFlag,
      show_order = ItemCfg#shopCfg.show_order,
      show_price = ItemCfg#shopCfg.price,
      bind = ItemCfg#shopCfg.bind
    }
               end,
  SendList = lists:map(FunConvert, ItemList),
  Msg = #pk_GS2C_shopItemList{itemList = SendList},
  playerAssist:sendToPlayerByPlayerID(PlayerID, ?CMD_GS2C_shopItemList, Msg).


requestModifySellPrice(ID, NewSellPrice) ->
  ?INFO(requestModifySellPrice, "onModifySellPrice ID ~p,NewSellPrice ~p", [ID, NewSellPrice]),
  onlineShopPid ! {requestModifySellPrice, ID, NewSellPrice},
  ok.

onModifySellPrice(State, ID, NewSellPrice) ->
  case etsBaseFunc:readRecord(onlineShopTable, ID) of
    {} ->
      ?INFO(onModifySellPrice, "onModifySellPrice ID ~p,NewSellPrice ~p,not exists", [ID, NewSellPrice]);
    OldRecord ->
      case NewSellPrice > OldRecord#shopCfg.price of
        true ->
          SellPrice = OldRecord#shopCfg.price;
        _ ->
          SellPrice = NewSellPrice
      end,
      case SellPrice < OldRecord#shopCfg.price of
        true ->
          NewRecord = OldRecord#shopCfg{sellprice = NewSellPrice,
            flag = ?Flag_ChepPrice
          };
        _ ->
          NewRecord = OldRecord#shopCfg{sellprice = NewSellPrice,
            flag = ?Flag_Normal
          }
      end,
      etsBaseFunc:insertRecord(onlineShopTable, NewRecord)
  end,
  State.

requestUpdateAllItem() ->
  ?INFO(requestModifySellPrice, "requestUpdateAllItem", []),
  onlineShopPid ! {requestUpdateAllItem},
  ok.

onUpdateAllItem(State) ->
  ets:delete_all_objects(onlineShopTable),
  insertAllItem(),
  State.

insertAllItem() ->
  %% 	FunInsert=fun(ShopCfg)->
  %% 					  ets:insert(onlineShopTable, ShopCfg)
  %% 			  end,
  %% 	lists:foreach(FunInsert, data_shop:get_items()),
  case data_shop:get_items() of
    [] ->
      ignore;
    ShopCfgList when erlang:is_list(ShopCfgList) ->
      ets:insert(onlineShopTable, ShopCfgList)
  end,
  Shop996 = data_shop_996:get_items(),
  ShopYufeng = data_shop_yf:get_items(),
  ets:insert( otherOnlineShopTable, Shop996 ++ ShopYufeng ),
  ok.





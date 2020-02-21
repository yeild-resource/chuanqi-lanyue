-ifndef(shopPackDefine_hrl).

-define(shopPackDefine_hrl, 1).

%% 商城礼包限购全服表
-record(shopPackTotal,
{
  id = 0,      %%礼包ID
  get = 0        %%全服领取数量
}).

%% 商城礼包限购玩家表
-record(shopPackUser,
{
  playerId = 0,  %%玩家ID
  getList = []  %%礼包领取情况[{礼包ID,已领取数量}]
}).

%% 商城礼包元宝兑换
-record(shopPackGold,
{
  playerId = 0,  %%玩家ID
  getList = []  %%礼包领取情况[{gold,status}]
}).

%% 商城礼包道具兑换
-record(shopPackItem,
{
  playerId = 0,  %%玩家ID
  getList = []  %%礼包领取情况[{{itemid,itemnum},status}]
}).

-define(shopPackTypeLimit, 1).  %%商城礼包限购
-define(shopPackTypeGold, 2).  %%商城礼包元宝兑换
-define(shopPackTypeItem, 3).  %%商城礼包道具兑换

-define(shopPack_Total_Ets, shopPack_Total_Ets).
-define(shopPack_User_Ets, shopPack_User_Ets).
-define(shopPack_Gold_Ets, shopPack_Gold_Ets).
-define(shopPack_Item_Ets, shopPack_Item_Ets).

-define(notGet, 1).      %%不可领取
-define(canGet, 2).      %%可领取
-define(alreadyGet, 3).    %%已领取

-endif. 
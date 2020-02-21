-ifndef(logdb_hrl).

-define(logdb_hrl, 1).

-define(CopyMap_Event_Type_Enter, 1). %%进入副本
-define(CopyMap_Event_Type_Leave, 2). %%离开副本
-define(CopyMap_Event_Type_Complete, 3). %%完成副本
-define(CopyMap_Event_Type_KillBoss, 4). %%在副本中杀死了boss
-define(CopyMap_Event_Type_KillMonster, 5). %%在副本中杀怪


-define(GroundingItem_STEvent, 1).%%交易行上架事件
-define(DelItemTimeOut_STEvent, 2).%%交易行超时下架事件
-define(DelItemSaler_STEvent, 3).%%交易行玩家下架事件
-define(TradeSaleSucc_STEvent, 4).%%交易行玩家出售成功事件
-define(TradeBugSucc_STEvent, 5).%%交易行玩家购买成功事件
-endif.
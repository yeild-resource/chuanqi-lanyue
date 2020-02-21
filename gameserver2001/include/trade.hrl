-ifndef(trade_hrl).
-define(trade_hrl, 1).

%%定时删除过期的交易信息, 30 minute
-define(TradeDeleteTimer, 30 * 60 * 1000).

-define(TradeAgreeOutTime, 5 * 60). %%交易发起3分钟无响应，自动取消

-define(TradePidName, tradePid).

-define(TradeBusyId, tradeBusyID). %%正在进行交易的玩家的名称

-define(TradeAgree, 1). %%同意交易
-define(TradeReject, 0). %%拒绝交易
-define(TradeItemSize, 6). %%交易的物品数量

-record(tradeItem, {
  id = 0, %% 物品全服唯一ID
  index = 0, %% 背包中的位置
  itemDataId = 0, %%item data id,can get item cfg by this id
  count = 0,
  flag = 0, %%一些标志位
  stars = 0, %% 强化(即升星)
  luck = 0, %% 幸运值
  promoteLevel = 0, %%进阶
  equipRandAttrArray = [],%% 装备的随机属性
  fujia = [], %% 装备的附加属性
  itemArrayForSpaceRing = [],%% 空间戒指
  insuranceTimes = 0,
  curse = 0,
  expiretime = 0,
  curProcessValue = 0
}).


%%交易的结构
-record(tradeInfo, {id = 0, reqID = 0, aceID = 0, status = 0,
  itemReqArray, itemAceArray, reqTreasure = 0, reqCoin = 0,
  aceTreasure = 0, aceCoin = 0,
  reqDataArray, aceDataArray, reqGridNum = 0, aceGridNum = 0,
  time = 0}).

%%交易的状态定义
-define(Trade_Status_Init, 0). %%发起交易，初始化
-define(Trade_Status_Agree, 1).%%同意交易
-define(Trade_Status_ReqLock, 2). %%发起方锁定交易
-define(Trade_Status_AceLock, 3). %%接受方锁定交易
-define(Trade_Status_AllLock, 4). %%双方锁定交易
-define(Trade_Status_ReqEnsure, 5). %%发起方确定交易
-define(Trade_Status_AceEnsure, 6). %%接受方确定交易
-define(Trade_Status_Suc, 7). %%交易完成
-define(Trade_Status_CancelTrade, 8). %%取消交易
-define(Trade_Status_Fail, 9). %%交易失败


-endif.

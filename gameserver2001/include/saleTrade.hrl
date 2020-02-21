%%%-------------------------------------------------------------------
%%% @author luoyifan
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 八月 2015 15:10
%%%-------------------------------------------------------------------
-author("Administrator").

-define(IF(Condition, RResult, FResult), if Condition -> RResult; true -> FResult end).
-record(sale_item, {
  id = 0, %% 物品全服唯一ID
  itemDataId = 0, %%item data id,can get item cfg by this id
  flag = 0, %%一些标志位
  stars = 0, %% 强化(即升星)
  promoteLevel = 0, %%装备进阶等级
  equipRandAttrArray = [],%% 装备的随机属性
  fujiaRandAttrArray = [],%% 装备的附加属性
  itemArrayForSpaceRing = undefined,%% 空间戒指增加的空间(弃用)
  luck = 0,
  curse = 0, %%诅咒(只有武器才有，杀人时增加)
  crit = 0,   %%致命一击(装备生成的时候，随机一个值，后续洗练？)
  insuranceTimes = 0,  %%投保次数
  expiretime = 0,
  processValue = 0, %%进度值
  ownerid = 0, %%主人ID
  ownername = "",%%主人名字
  item_level = 0,%%道具等级
  sale_price = 0,%%出售价格
  sale_count = 0,%%出售数量
  groundingTime = 0, %%上架时间
  timeType = 0,%%时间类型12,24,48
  saleType = 10,%%物品类型
  lockTime = 0%%锁定时间
}).
%%玩家拍卖列表
-record(playerSales, {playerId, saleList}).
%%计时数据
-record(itemTimer, {startTime, dataId}).
%%购买超时时间
-define(StbuyItemOvertime, 15).
%%查找冷却时间
-define(StFind_Colding_Time, 1).
%%翻页方式
-define(TrunPage_Front, 0). %%上一页
-define(TrunPage_Next, 1).  %%下一页
%%偏移count
-define(PageShiftCount, 1000).
-define(PageShiftPageNum, 100).
%%时间类型跟对应时间
-define(SaleTime_Type_12H, 1).
-define(SaleTime_Type_24H, 2).
-define(SaleTime_Type_48H, 3).
%%消耗金钱
-define(DelMoneyNum12H, 20000).
-define(DelMoneyNum24H, 40000).
-define(DelMoneyNum48H, 80000).
%%时间值（秒）
-define(Sales_Time_12H, 43200).%12*60*60
-define(Sales_Time_24H, 86400).%24*60*60
-define(Sales_Time_48H, 172800).%48*60*60
%%更新拍卖时间，
-define(SaleUpdateTimer, 60000).
%%下架返回
-define(St_TakeDown_Succ, 0).         %%下架成功
-define(St_TakeDown_AlreadySell, -1). %%下架失败，已经被买走
-define(St_TakeDown_NotSeller, -2).   %%下架失败，不是本订单的卖家
-define(St_TakeDown_ProtectTime, -3). %%下架失败，还在下架保护时间
-define(St_TakeDown_Buying, -4).      %%下架失败，正在被购买中
%%下架保护时间
-define(TakeDown_Protect_Time, 60).
%%每次发送给客户端的最大订单数量
-define(sendToPlayerMaxCount, 10).
%%交易税
-define(SaleTradeTaxes, 0.1).
%%交易场操作提示tips
-define(StOper_FindSucc, 3).%%查找成功
-define(StOper_BuySucc, 2).%%购买道具成功
-define(StOper_GroundingSucc, 1).%%上架道具成功
-define(StOper_ItemErr, -1).%%上架道具不存在
-define(StOper_ItemNunErr, -2).%%上架道具数量小于0
-define(StOper_ItemPriceErr, -3).%%上架道具定价小于0
-define(StOper_ItemTimeTypeErr, -4).%%上架道具时间类型错误
-define(StOper_ItemMoneyErr, -5).%%上架道具保管费不足
-define(StOper_ItemBindErr, -6).%%上架道具时间不是非绑定
-define(StOper_ItemTypeErr, -7).%%物品不属于交易行上架类型
-define(StOper_RoleSaleNumErr, -8).%%玩家上架道具数量超过上线了
-define(StOper_AllSaleNumErr, -9).%%玩家上架道具数量超过上线了
-define(StOper_BuyByOther, -10).%%正在被别人购买
-define(StOper_BuyNeedMoneyErr, -11).%%购买所需的金钱不足

%%查找返回
-define(St_Find_Succ, 0).
-define(St_Find_Failed_Colding, -1).%%翻页失败(已经是第一页或者最后一页),
-define(St_Find_Failed_CannotTrunPage, -2).%%查找太过频繁
-define(St_Find_Failed_TypeErr, -3).%%查找道具类型错误



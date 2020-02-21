-ifndef(ManorBattle_hrl).
-define(ManorBattle_hrl, true).

-define(ManorMaxTakeupNum, 1).%领地最大占有数量

-define(ManorState_Normal, 0).%领地状态，正常状态
-define(ManorState_Enroll, 1).%领地状态，竞标状态
-define(ManorState_Fight, 2).%领地状态，战斗状态
-define(ManorState_WaitingFight, 3).%领地状态，等着开战

-record(manorRecord, {mapDataID = 0,
  owerGuildID = 0,
  ownerGuildName = "",
  attackGuildID = 0,
  attackGold = 0,
  attackPlayer = 0,
  moneyToGain = 0,
  leftFightTime = 0,
  attackPlayerNum = 0,
  deFenderPlayerNum = 0,
  state = ?ManorState_Normal,
  moneyList = []
}
).

-define(ManorBattle_MinLevel, 1).%
-define(ManorBattle_MinNumber, 1).%
-define(MinPriceMarkup, 50).%单次最少的加价
-define(ManorBattleLastTime, 1800).%领地争夺战持续时间
-define(MaxEnterManorNumPerGuild, 20).%一个公会最多可以进多少人
-define(ManorAwardNeedMinSpace, 3).%领地战奖励所需的最小的背包空间大小
-define(DeadBanReliveTime, 10).%在领地战地图中死了，禁止复活的时间
-define(ManorBattleAheadStart, 5 * 60).%开战前多少s 发准备开打的提示

-define(EnrollManor_Success, 0).%报名成功
-define(EnrollManor_NoAuthrity, -1).%没权限报名
-define(EnrollManor_OfferTowLow, -2).%报价不够
-define(EnrollManor_LackofGold, -3).%元宝不足
-define(EnrollManor_NotEnrollNow, -4).%当前不能报名争夺
-define(EnrollManor_ItsYours, -5).%不能报名打自己的领地
-define(EnrollManor_MemberNotEnough, -6).%满足参展资格的人不足
-define(EnrollManor_Invalid, -7).%未知错误
-define(EnrollManor_TooManyManor, -8).%领地占有太多

-define(EnterManor_Success, 0).
-define(EnterManor_NoAuthrity, -1).%没资格进这个领地战地图
-define(EnterManor_NotFightYet, -2).%当前领地地图没发送战斗
%%-define(EnterManor_KeepPeace,-3).%当前领地不需要战斗
-define(EnterManor_TooManyPeaple, -4).%进去的人太多了
-define(EnterManor_UnkownError, -5).%未知错误
-define(EnterManor_Compelte, -6).%活动已经结束

-define(BuyBuff_Success, 0).%购买buff成功
-define(BuyBuff_RejectAtThisMap, -1).%当前地图不能购买
-define(BuyBuff_GoldNotEnough, -2).%元宝不足
-define(BuyBuff_HighestLevel, -3).%buff到了最高等级了

-define(GainManorAward_success, 0).
-define(GainManorAward_NoLeague, -1).%没有工会
-define(GainManorAward_EveryGained, -2).%今天已经领过了
-define(GainManorAward_NotEnoughBagSpace, -3).%背包不足
-define(GainManorAward_NoManorAward, -4).%没领地奖励

-define(GaveBackReason_MeetHigherPrice, 0).%遇到更高的竞标价格，退回
-define(GaveBackReason_EnrollOtherManor, 1).%竞标了新的领地，退回

-define(GaveBackManor_Success, 0).%放弃成功
-define(GaveBackManor_NoLeague, -1).%没有工会
-define(GaveBackManor_NoAuthrity, -2).%没有权限
-define(GaveBackManor_NotYours, -3).%不是你的领地不能放弃
-define(GaveBackManor_Today, -4).%领地战当天不能放弃

-endif.
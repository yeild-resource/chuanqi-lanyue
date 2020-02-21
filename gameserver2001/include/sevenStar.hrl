-record(sevenStarInfo,
{
  playerId = 0,
  typeList = []  %%[{星座ID,星座等级}]
}).

-record(sevenStarTotal,
{
  playerId = 0,
  reiki = 0,    %%灵气
  goldtimes = 0,  %%当日元宝充灵次数
  cointimes = 0,  %%当日金币充灵次数
  isSaved = 0    %%是否已经保存数据库，0保存了 1未保存
}
).


-define(SevenStarInfoTableAtom, 'SevenStarInfoTableAtom').    %%北斗七星星座表
-define(SevenStarTotalTableAtom, 'SevenStarTotalTableAtom').  %%北斗七星总计表

-define(Charge_Type_Gold, 1).  %%充灵类型：元宝
-define(Charge_Type_Coin, 2).  %%%充灵类型：金币

-define(REIKIBALL, 50061).  %%灵气珠ID

-define(REIKIPER, 10).    %%每次充灵获得的基础灵气数量
-define(Charge_Reiki_Item_Num, 3).      %%充灵花费灵珠数量

-define(GoldFunc(Times), (2 * (Times + 1))).  %%元宝充灵公式
-define(CoinFunc(Times), (10000 * (Times + 1))).  %%金币充灵公式


%% 元宝充灵暴击公式，请保证权重和为100
-define(GoldOdd(R),
  (
      if
        R =< 50 ->
          1;
        R =< 80 ->
          2;
        R =< 100 ->
          3
      end)
).

%% 金币充灵暴击公式，请保证权重和为100
-define(CoinOdd(R),
  (if
     R =< 50 ->
       1;
     R =< 80 ->
       2;
     R =< 100 ->
       3
   end)
).


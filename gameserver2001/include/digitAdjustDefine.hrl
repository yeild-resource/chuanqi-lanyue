-ifndef(__DIGIT_AJUST_DEFINE_HRL__).
-define(__DIGIT_AJUST_DEFINE_HRL__, 1).
%% 定义与数值策划相关的一些参数
-define(DigitAdjust_MineID, 22). %% 探矿编号
-define(DigitAdjust_GongChengAwardID, 23). %% 怪物攻城防守成功发奖编号
-define(DigitAdjust_GongChengJudgeID, 24). %% 攻城怪物消失数之防守结果判定编号
-define(DigitAdjust_luxurySigninRechange, 25). %% 可以领取豪华签到的每日充值金额

-ifndef(DIGIT_AJUST_TEST).
-define(DIGIT_AJUST_TEST, 1).
-endif.

-ifdef(DIGIT_AJUST_TEST).
%%护身戒指
-define(MpNum_Replace_One_Hp, digitAjustMod:getValue(1)). %%护身戒指 护身时，N：代替1点hp需要多少mp
%%麻痹戒指
-define(Benumb_Rate_For_PutOnBenumbRing, digitAjustMod:getValue(2)). %%麻痹戒指,近战攻击(战士的所有技能和普通攻击)会触发该效果, 触发几率：万分数
-define(Benumb_BufferId_For_PutOnBenumbRing, digitAjustMod:getValue(3)).%%麻痹戒指触发麻痹后，添加的buff id
%%吸血戒指
%% 恢复的血量 = 目标减少血量 * 近战（远程）系数 * 群体系数（单体技能=1）  
-define(SuckHp_Near_Percent, digitAjustMod:getValue(4)). %%近战转化的百分数
-define(SuckHp_Far_Percent, digitAjustMod:getValue(5)).  %%远程转化的百分数
-define(SuckHp_Group_Percent, digitAjustMod:getValue(6)). %%群体百分数
%% 诱惑之光
%%诱惑之光每次击中目标后,有三种效果1)会使目标麻痹X毫秒  2)使目标直接死亡  3)使目标成为法师的宠物
-define(Tempt_No_Effect, 0).
-define(Tempt_Benumb_Effect, 1).
-define(Tempt_Dead_Effect, 2).
-define(Tempt_Change_Pet_Effect, 3).
-define(Tempt_Benumb_Weight, digitAjustMod:getValue(7)).
-define(Tempt_Dead_Weight, digitAjustMod:getValue(8)).
-define(Tempt_Change_Pet_Weight, digitAjustMod:getValue(9)).
-define(WAKUANG_INTERVAL_TIME, digitAjustMod:getValue(10)).
-define(Vip_FirstPay_Item, digitAjustMod:getValue(12)).


-else.

%%护身戒指
-define(MpNum_Replace_One_Hp, 3). %%护身戒指 护身时，N：代替1点hp需要多少mp

%%麻痹戒指
-define(Benumb_Rate_For_PutOnBenumbRing, 2000). %%麻痹戒指,近战攻击(战士的所有技能和普通攻击)会触发该效果, 触发几率：万分数
-define(Benumb_BufferId_For_PutOnBenumbRing, 109).%%麻痹戒指触发麻痹后，添加的buff id


%%吸血戒指
%% 恢复的血量 = 目标减少血量 * 近战（远程）系数 * 群体系数（单体技能=1）  
-define(SuckHp_Near_Percent, 10). %%近战转化的百分数
-define(SuckHp_Far_Percent, 5).  %%远程转化的百分数
-define(SuckHp_Group_Percent, 20). %%群体百分数

%% 诱惑之光
%%诱惑之光每次击中目标后,有三种效果1)会使目标麻痹X毫秒  2)使目标直接死亡  3)使目标成为法师的宠物
-define(Tempt_Benumb_Effect, 1).
-define(Tempt_Dead_Effect, 2).
-define(Tempt_Change_Pet_Effect, 3).
-define(Tempt_Benumb_Weight, 2000).
-define(Tempt_Dead_Weight, 4000).
-define(Tempt_Change_Pet_Weight, 4000).
-define(WAKUANG_INTERVAL_TIME, 60000). %%挖矿的给予奖励的间隔时间

-define(Vip_FirstPay_Item, digitAjustMod:getValue(12)).

-endif.

-endif.

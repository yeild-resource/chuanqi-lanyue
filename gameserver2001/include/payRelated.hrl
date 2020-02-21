%% ====================================================================
%% 日充累充头文件
%% ====================================================================
%% -record(paysingleCfg,{id,gold,items}).%%单笔充值
%% -record(paytodayCfg,{id,gold,items}).%%日充
%% -record(paytotalCfg,{id,gold,items}).%%累计充值
-record(constotalCfg, {id, gold, items}).%%累计消耗

-define(PayRelatedType, 2).  %%本次活动只开单日充值,如果只开累计充值，请配置为2

-define(PayRelatedTableAtom, 'PayRelatedTableAtom').      %%日充累充信息表
-define(PayRelatedGoldTableAtom, 'PayRelatedGoldTableAtom').  %%日充累充金额表

-define(SinglePay, 1).    %单笔充值
-define(DayPay, 2).      %每日充值
-define(TotalPay, 3).    %累计充值
-define(TotalCons, 4).    %累计消耗

%%是否获取过某种奖励，不管是否领取了
-define(CanGet, 0).      %还未获得过该奖励
-define(AlreadyGet, 1).    %已经获得过该奖励

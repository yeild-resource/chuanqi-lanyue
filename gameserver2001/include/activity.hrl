-ifndef(activity_hrl).

-define(activity_hrl, 1).
-include("excelDefine.hrl").

%%%%%%%%%%%%%%%%%%%%%%ActivityList start%%%%%%%%%%%%%
-define(Activity_Type_Id_Campfire, 1003). %%征战四方，篝火活动的id
-define(Activity_Type_Id_Indiana, 1006). %%夺宝奇兵活动的id
-define(Activity_Type_Id_manorbattle, 3). %% 领地战
-define(Activity_Type_Id_EquipEnvoy, 4). %% 重装使者
-define(Activity_Type_Id_LunHuiDao, 5). %%轮回道
-define(Activity_Type_Id_KillingIsLand, 1002). %%杀人岛活动的id

-define(Activity_Campfire_LevelNeed, 45).  %%篝火活动等级限制
-define(Activity_Indiana_LevelNeed, 30).  %%夺宝奇兵活动等级限制
-define(Activity_KillingIsLand_LevelNeed, 30).  %%杀人岛活动活动等级限制
%%%%%%%%%%%%%%%%%%%%%%ActivityList end  %%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%篝火定义开始%%%%%%%%%%%%%%%%
-define(Activity_Timer_Handle_Campfire_BeforeStart30MS, campfireBeforeStart30).  %% 篝火开始前三十分钟计时器
-define(Activity_Timer_Handle_Campfire_BeforeStart10MS, campfireBeforeStart10).  %% 篝火开始前十分钟计时器
-define(Activity_Timer_Handle_Campfire_BeforeStart5S, campfireBeforeStart5).  %% 篝火开始前五秒钟计时器
-define(Activity_Timer_Handle_Campfire_Start, campfireStart).  %% 篝火开始计时器
-define(Activity_Timer_Handle_Campfire_End, campfireEnd).  %% 篝火结束计时器
-define(Activity_Timer_Handle_Campfire_End10Seconds, campfireEndSeconds).  %% 篝火倒数10秒计时器


-define(Activity_Campfire_Open, 1).  %% 篝火活动开启
-define(Activity_Campfire_Closed, 0).  %% 篝火活动结束
-define(Activity_Campfire_Action_DrinkGold, 20).  %% 篝火饮酒花费20元宝
-define(Activity_Campfire_Action_DrinkRateMax, 100).  %% 篝火饮酒最大醉酒度
-define(Activity_Campfire_Action_DrinkRateAdd, 5).  %% 篝火饮酒每次增加的醉酒度
-define(Activity_Campfire_Action_Eat_Meat_Gold, 20). %%篝火每次吃肉20元宝
-define(Activity_Campfire_Action_Eat_Meat_Rate_Add, 1). %%篝火每次吃肉增加的醉酒度
-define(Activity_Campfire_Action_DrinkOrEatTimes, 20). %%篝火喝酒或者吃肉总次数
-define(Activity_Campfire_Action_Kill_Player_Rate_Add, 1). %%篝火每次杀人增加的醉酒度

-define(Activity_Campfire_Action_Dance, 1).  %% 篝火跳舞
-define(Activity_Campfire_Action_Sing, 2).  %% 篝火唱歌
-define(Activity_Campfire_Action_Bitchy, 3).  %% 篝火犯贱
-define(Activity_Campfire_Action_Drink, 4).  %% 篝火饮酒
-define(Activity_Campfire_Action_Eat_Meat, 5). %%篝火吃肉


%%-define(Activity_Timer_Campfire_IntervalTime, 86400000).  %%篝火活动的间隔时间
%%-define(Activity_Timer_Campfire_Start30MinutesTime, {11, 40, 0}).  %%篝火活动的开始前30分钟时间， 12点10分开始， 这个11点40的时候广播
%%-define(Activity_Timer_Campfire_Start10MinutesTime, 1200000).  %%篝火活动的开始前10分钟时间
%%-define(Activity_Timer_Campfire_Start5SencondTime, 595000).  %%篝火活动的开始前5秒钟时间
%%-define(Activity_Timer_Campfire_StartTime, 5000).  %%篝火活动的开始时间
%%-define(Activity_Timer_Campfire_EndSecondsTime, 1190000).  %%篝火活动的倒数10秒时间
%%-define(Activity_Timer_Campfire_EndTime, 10000).  %%篝火活动的结束时间
-define(Activity_Campfire_CalExp_IntervalTime, 10000).  %%篝火活动的间隔计算经验时间  
-define(Activity_Campfire_Action_IntervalTime, 30000).  %%篝火活动做一次动作增加的经验值

-define(Activity_Campfire_CalExp_Exp, 150).  %%篝火活动每次增加的经验值系数 
-define(Activity_Campfire_Action_Exp, 10000).  %%篝火活动做一次动作增加的经验值
%%%%%%%%%%%%%%%%%%%%%%%%%%%篝火定义结束%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%夺宝奇兵定义开始%%%%%%%%%%%%%%%%
-define(Activity_Timer_Handle_Indiana_Start, indianaStart).  %% 夺宝奇兵开始计时器
-define(Activity_Timer_Handle_Indiana_Close, indianaClose).  %% 夺宝奇兵关闭入口计时器
-define(Activity_Timer_Handle_Indiana_End, indianaEnd).  %% 夺宝奇兵结束计时器
-define(Activity_Timer_Handle_Indiana_Start10Minutes, indianaStart10Minutes).  %% 夺宝奇兵开始前10分钟计时器
-define(Activity_Timer_Handle_Indiana_Start30Minutes, indianaStart30Minutes).  %% 夺宝奇兵开始前30分钟计时器
-define(Activity_Timer_Handle_Indiana_KeepBox, indianaKeepBox).  %% 夺宝奇兵保存宝箱的计时器
-define(Activity_Timer_Handle_Indiana_ExpTime, indianaExpTime).  %% 夺宝奇兵发经验计时器
-define(Activity_Indiana_Open, 1).  %% 夺宝奇兵活动开启
-define(Activity_Indiana_Closed, 0).  %% 夺宝奇兵活动结束
%%-define(Activity_Timer_Indiana_IntervalTime, 86400000).  %%夺宝奇兵活动的间隔时间
%%-define(Activity_Timer_Indiana_Start30MinutesTime, 75600000).  %%夺宝奇兵活动的开始前30分钟时间
%%-define(Activity_Timer_Indiana_Start10MinutesTime, 1200000).  %%夺宝奇兵活动的开始前10分钟时间
%%-define(Activity_Timer_Indiana_StartTime, 600000).  %%夺宝奇兵活动的开始时间
%%-define(Activity_Timer_Indiana_CloseTime, 900000).  %%夺宝奇兵活动的入口关闭时间
%%-define(Activity_Timer_Indiana_EndTime, 900000).  %%夺宝奇兵活动的结束时间
-define(Activity_Timer_Indiana_KeepBoxTime, 600000).  %%夺宝奇兵活动保持宝箱的时间
-define(Activity_Timer_Indiana_ExpTime, 30000).  %%夺宝奇兵发经验的时间间隔

%% -define(Activity_Timer_Indiana_Start10MinutesTime, 120000).  %%夺宝奇兵活动的开始前10分钟时间 
%% -define(Activity_Timer_Indiana_StartTime, 60000).  %%夺宝奇兵活动的开始时间 
%% -define(Activity_Timer_Indiana_CloseTime, 60000).  %%夺宝奇兵活动的入口关闭时间 
%% -define(Activity_Timer_Indiana_EndTime, 120000).  %%夺宝奇兵活动的结束时间
%% -define(Activity_Timer_Indiana_KeepBoxTime, 60000).  %%夺宝奇兵活动保持宝箱的时间

%%%%%%%%%%%%%%%%%%%%%%%%%%%夺宝奇兵定义结束%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%闯天关定义开始%%%%%%%%%%%%%%%%
-define(Activity_RushMission_PlayerID, rushMissionPlayerId).
-define(Activity_RushMission_CurMission, rushMissionCurMission).
-define(Activity_RushMission_FirstMission, rushMissionFirstMission).
-define(Activity_RushMission_FirstMissionCanGetAward, rushMissionFirstMissionCanGetAward).
-define(Activity_RushMission_ResultCode_Suc, 1). %%闯天关成功
-define(Activity_RushMission_ResultCode_Fail, 0).%%闯天关失败
-define(Activity_RushMission_FailOutTime, 15000).%%闯天关失败15秒，把玩家踢出地图
-define(Activity_RushMission_MaxRushMission, 100). %% 闯天关最大关数
-define(Activity_RushMission_RefreshTime, 1). %% 闯天关刷新时间
-define(Activity_RushMission_FightTime, 2). %% 闯天关战斗时间
-define(Activity_RushMission_GetFristAwardTime, 3). %% 闯天关首杀奖励刷新时间
-define(Activity_RushMission_KillMonTime, 4). %% 闯天关杀怪刷新
-define(Activity_RushMission_GetAwardTime, 20000). %% 闯天关领取每层奖励的时间
-define(Activity_RushMission_ReStartInterval, 600000). %% 闯天关连续进入间隔时间

-define(RushMission_GetFirstAwardType_Player, 1). %%玩家手动领取奖励
-define(RushMission_GetClearanceAwardType_Player, 2). %%玩家手动领取通关奖励
-define(RushMission_Clear_Player, 3). %% 玩家扫荡领取通关奖励
-define(RushMission_GetFirstAwardType_System, 4). %%系统到时自动发放

-define(RushMission_Result_Fail, rushMissionResult). %%闯天关结果

-define(RushMission_LeaveType_Exit, 1). %%玩家离开
-define(RushMission_LeaveType_Dead, 2). %%玩家死亡离开

-define(RushMission_GetFirstAward_MapAITimer, firstAwardTimer). %%首杀奖励倒计时
-define(Activity_RushMission_GetAwardTimer, rushMissionGetAwardTimer). %% 闯天关领取首杀奖励的计时器
-define(Activity_RushMission_RefreshTimer, rushMissionRefreshTimer). %% 闯天关刷新计时器
-define(Activity_RushMission_FightTimer, rushMissionFightTimer). %% 闯天关战斗计时器


%%%%%%%%%%%%%%%%%%%%%%%%%%%重装使者%%%%%%%%%%%%%%%%
%% test time : 53100   39600*1000   40800*1000  34200
%% offical time: B39600*1000,E40800*1000,B57600*1000,E58800*1000
%%
-define(Copy_Timer_EquipEnvoy_BeginTimeA, 39600 * 1000).  %%重装使者副本开始时间
-define(Copy_Timer_EquipEnvoy_EndTimeA, 40800 * 1000).  %%重装使者副本结束时间
-define(Copy_Timer_EquipEnvoy_BeginTimeB, 57600 * 1000).  %%重装使者副本开始时间
-define(Copy_Timer_EquipEnvoy_EndTimeB, 58800 * 1000).  %%重装使者副本结束时间
-define(Copy_Timer_EquipEnvoy_OneDaySec, 86400 * 1000).  %%重装使者副本结束时间
-define(Copy_Timer_EquipEnvoy_PassTime, 1200 * 1000).  %%重装使者副本结束时间

-define(Copy_Timer_EquipEnvoy_BeginA, copy_Timer_EquipEnvoy_BeginA).  %%重装使者副本开始 
-define(Copy_Timer_EquipEnvoy_BeginB, copy_Timer_EquipEnvoy_BeginB).  %%重装使者副本开始
-define(Copy_Timer_EquipEnvoy_End, copy_Timer_EquipEnvoy_End).    %%重装使者副本结束

-record(moNiGongCheng, {playerId = 0}).


%%%%%%%%%%%%%%%%%%%%%%%%%%%闯天关定义结束%%%%%%%%%%%%%%%%

-define(Open_Server_Seven_Day_Second, 7*24*60*60). %% 开服七天的秒数
-define(Activity_ImpactLevelRank, activity_ImpactLevelRank). %% 冲级达人结算排行榜(进程字典key)
-define(Activity_ImpactLevelGet, activity_ImpactLevelGet). %% 冲级达人奖励领取情况列表(进程字典key)

%%%%%%%%%%%%%%%%%%%%%%%%%%%决战杀人岛定义开始%%%%%%%%%%%%%%%%
-define(Activity_Timer_Handle_KillingIsLand_Start, killingIsLandStart).  %% 决战杀人岛开始计时器
-define(Activity_Timer_Handle_KillingIsLand_End, killingIsLandEnd).  %% 决战杀人岛结束计时器
-define(Activity_Timer_Handle_KillingIsLand_Start10Minutes, killingIsLandStart10Minutes).  %% 决战杀人岛开始前10分钟计时器
-define(Activity_Timer_Handle_KillingIsLand_Start30Minutes, killingIsLandStart30Minutes).  %% 决战杀人岛开始前30分钟计时器
-define(Activity_KillingIsLand_Open, 1).  %% 决战杀人岛活动开启
-define(Activity_KillingIsLand_Closed, 0).  %% 决战杀人岛活动结束


%%%%%%%%%%%%%%%%%%%%%%%%%%%决战杀人岛定义结束%%%%%%%%%%%%%%%%

%% ============== 活动编号定义 ==============
-define(Activity_Id_Arena, 2006). %% 竞技场活动编号
-define(Activity_Id_MoLongCopy, 2004). %% 魔龙宝地活动编号
-define(Activity_Id_JiangJunFenCopy, 2005). %% 将军坟活动编号
-define(Activity_Id_NiMoCopy, 2002). %% 逆魔活动编号
-define(Activity_Id_MoNiGongCheng, 1005). %% 模拟攻城活动编号

-endif.

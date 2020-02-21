-ifndef(monster_hrl).

-define(monster_hrl, 1).

-record(pk_Ai2Map_MonsterStopMove, {id}).
-record(pk_Ai2Map_MonsterToSleep, {id}).
-record(pk_Ai2Map_MonsterMoveTo, {id, isUnbeatable, posInfos}).


%%MonsterAI状态
%% sleep
-define(Monster_AI_State_Sleep, 0).
%%闲
-define(Monster_AI_State_Idle, 1).
%%战斗
-define(Monster_AI_State_Fighting, 2).
%%往回跑
-define(Monster_AI_State_GoBack, 3).


%%从死亡到从地图消失时间
-define(Monster_Dead_Disapear_Time, 2 * 1000 * 1000).


-record(hateInfo, {id, isVisable = true, hate}).

-define(Init_Hate_Val, 0).  %%初始的仇恨值
-define(Max_Hatred_Count, 100). %%仇恨列表最大仇恨目标个数

-define(Monster_Goback_Path_Max, 30).

-define(Monster_XianMo_Boss, 2550).%%仙魔界bossid

-define(MonsterType_BatMan, 0). %%小怪
-define(MonsterType_Copy, 1). %%副本boss
-define(MonsterType_WildBossQuery, 2). %%野外boss查询
-define(MonsterType_MoJieBossQuery, 3). %%魔界boss查询
-define(MonsterType_WorldBoss, 4). %% 世界boss

-define(Monster_Type_Door, 8). %%门

-endif.
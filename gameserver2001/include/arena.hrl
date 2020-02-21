-ifndef(__CHAT_ARENA_HRL__).
-define(__CHAT_ARENA_HRL__, 1).
-define(ArenaTypePlayer, 0). %% 竞技场角色类型 玩家
-define(ArenaTypeMonster, 1).  %% 竞技场角色类型 机器人（怪物）
-record(arena_info, {
  id = 0,    %% 竞技场排名
  type = ?ArenaTypePlayer, %% 默认为怪物
  playerid = 0,     %% 玩家id
  points = 0,       %% 玩家积分
  robot_data
}).

%% -record(challenge_info, {
%%         playerid                  = 0,    %% 挑战者玩家id
%%         mirrorPlayerid            = 0,     %% 被挑战玩家镜像id
%% 		}).
-record(challenge_info, {
  playerid = 0,    %% 挑战者玩家id
  mirrorPlayerid = 0,     %% 被挑战玩家镜像id
  type = ?ArenaTypeMonster %% 被挑战者类型
}).
-define(Arena_Info_Ets, 'Arena_Info_Ets').

-define(Arena_Rank_Ets, 'Arena_Rank_Ets'). %%竞技场排行榜
-define(Max_Arena_Rank, 50).  %% 竞技场排行榜的长度
-define(Arena_Yesterday_Info_Ets, 'Arena_Yesterday_Info_Ets').

-define(Arena_Challenge_Info_Ets, 'Arena_Challenge_Info_Ets').

-define(Need_Min_Level, 30).   %% 进入竞技场最低35级
-define(Arena_Max_Rank_Len, 10000). %% 竞技场排名最多10000名

-define(ArenaCfg_Index, 1).

-define(Arena_Befor_Rank_Count, 5).  %% 竞技场获取我前面5个玩家信息

-define(Arena_Msg_Challenge, 0).        %%主动挑战
-define(Arena_Msg_BeChallenge, 1).    %%被挑战

-define(Arena_Win_Times, 8).  %% 连赢大于等于8次就全服广播


-define(Arena_Check_timer, 2000).

-define(Arena_Robot_Num, 1000). %%竞技场最多放好多机器人

-endif.

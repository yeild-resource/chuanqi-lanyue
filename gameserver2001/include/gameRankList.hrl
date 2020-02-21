-ifndef(__GAME_RANK_LIST_HRL__).
-define(__GAME_RANK_LIST_HRL__, 1).

-define(TIMER_REFRESH_OFFSET, 1 * 60 * 60).  %% 凌晨1点刷新排行榜

-define(Rank_List_Count, 100).
-define(Rank_My_List_Count, 5).
-define(Rank_Required_Level, 30). %%排行榜只取30级以上的数据

-define(Rank_Type_Fight, 1).
-define(Rank_Type_Level, 2).
-define(Rank_Type_League, 3).
-define(Rank_Type_RushMission, 4). %%闯天关
-define(Rank_Type_Arena, 5). %%竞技场
-define(Rank_Type_Kill, 6). %%战绩

-define(Career_Type_Total, 0).
-define(Career_Type_Zhanshi, 1).
-define(Career_Type_Daoshi, 2).
-define(Career_Type_Fashi, 3).

%% ets table name
-define(RankList_NiuB, 'rankList_NiuB'). %% 牛逼榜

-define(RankList_Level, 'rankList_Level').

-define(RankList_Kill, 'rankList_Kill'). %% 战绩榜

-define(RankList_League, 'rankList_League').


-define(RankList_RushMission, 'rankList_RushMission').
-define(RankList_Arena, 'rankList_Arena').


%% 帮会总榜
-record(rankList_league, {rank, %% 名次 
  leagueId, %% 帮会Id
  name, %% 帮会名
  level}). %%等级


%% 玩家信息
-record(rankList_player_record, {playerid, %% id
  player}). %% player record

-record(rankPlayer, {rank, pkRankInfo}).

-endif.
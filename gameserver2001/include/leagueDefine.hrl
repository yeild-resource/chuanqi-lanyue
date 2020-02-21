-ifndef(__LEAGUE_DEFINE_HRL__).
-define(__LEAGUE_DEFINE_HRL__, 1).

-define(NeedItemId, 50003).
-define(NeedItemCnt, 1).
-define(NeedCoin, 200000).

-define(LeagueBossIdList, [2044, 2053]).

-define(LeagueCopyDataMap1, 2000).
-define(LeagueCopyDataMap2, 2001).

%% -define(MaxLeagueMember, 50).
-define(MaxViceLeaderCount, 2).
-define(MaxAnnouncementLen, 120).

-define(Role_Common, 0).
-define(Role_ViceLeader, 1).
-define(Role_Leader, 2).

-define(Action_Exit_League, 1).
-define(Action_Appoint_Leader, 2).
-define(Action_Appoint_ViceLeader, 3).
-define(Action_Remove_ViceLeader, 4).
-define(Action_Player_Online, 5).
-define(Action_Player_Offline, 6).
-define(Action_Open_LeagueCopy, 7).
-define(Action_Close_LeagueCopy, 8).
-define(Action_Buy_LeagueCopy, 9).
-define(Action_Level_Change, 10).

-define(Max_League_Count, 500).

-define(OpenLeagueCost, 500).  %% 开启帮会pk需要500非绑定元宝

-define(DailyMaxApplyJoinCount, 6).
-define(RetJoinLeagueApplyTime, 86400).
-define(League_Check_timer, 30 * 1000).
-define(LeaguePkState_Check_timer, 30 * 1000).

-define(LeaguePkState_continue_time, 2 * 60 * 60).  %%  帮会Pk状态持续时间

-define(LeaguePkState_Close, 0).
-define(LeaguePkState_Open, 1).

-define(LeagueShopOpenTime, 3600*6).	%% 新入帮会，多久可以才可以使用商店, 开启帮会副本
%% -define(LeagueMaxLv, 5).  %% 帮会等级上限

-define(LeagueRelation_Normal, 0).
-define(LeagueRelation_Allies, 1).
-define(LeagueRelation_Hostile, 2).

-define(LeagueCampfireBoss1, 1002).
-define(LeagueCampfireBoss2, 1003).

-define(LeagueCampfireDays, [ 1, 2, 3, 4, 5, 6,  7]).
-define(LeagueCampfireStartTime, {18, 30, 00}).
-define(LeagueCampfireEndTime, {19, 00, 00}).

-record(league_state, {
  id,
  name = "",
  level = 1,
  maxCount = 0,
  leaderId,
  viceleaderIdlist = [],
  memberList = [],
  duplicateId = 0,
  announcement = "",
  manifesto = "",
  isOpenLeagueCopy = 0,%% 帮会副本是否已开启，开启为1,没有开启为0,不保存到db
  openLeagueCopyTime = 0,%%帮会副本开启的时间, getNowSeconds()获取到的,不保存到db
  isBoughtLeagueCopyBuff = 0,  %%是否有人购买了帮会副本,不保存到db
  enteredCopyMapNum = 0,
  leagueScore = 0, %%帮会繁荣度,通过玩家消费积分累计
  exp = 0,
  fund = 0,
  rank = 0,
  escortTimes = 1,
  escortState = 0, %%0为开启, 大于1, 正在护送的monster id
  robTimes = 3, %%
  robbingList = [],  %%我已经开启的打劫对象
  robbedList = [] %%正在打劫我的的帮会
}).

-record(leaguePlayer_state, {playerId,
  leagueId,
  role,
  online,
  playerScore,
  joinedTimestamp,
  contributions = 0}).

-record(leagueTimeout, {leagueId,
  joinPlayerId,
  removetime}).

-record(leaguePkState, {leagueId,
  pkLeagueId,
  relation,
  removetime = 0}).

-record(leagueInvitationList, {leagueId, inviteePlayerIdList}).

-endif.

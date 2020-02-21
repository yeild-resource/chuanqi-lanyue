-ifndef(team_hrl).
-define(team_hrl, 1).
%% team info
-record(teamInfo, {id, leaderId, memberList, copyDataID = 0}).
-record(teamMemberInfo, {playerId, playerPid, playerSendPid, isOnline, name, level, career, sex, joinTime, hp, maxhp, isReady = 0}).


%%队伍进程玩家信息
-record(teamPlayerInfo, {playerId, teamId, isOnline, isLead, removeTime, inviteTargetList}).
-record(inviteTargetInfo, {playerId, inviteTime}).
%% %%队员在地图中的信息
%% -record( teamMemberMapInfo, { playerID, playerName, level, camp, fation, sex, life_percent, x, y, map_data_id, mapID, mapPID, playerPID } ).

%%队伍最大成员数量
-define(TeamMember_MaxCount, 5).

%%玩家掉线（掉线有三分钟的保护时间，过了3分钟就视为自动退出游戏）、退出游戏自动退出队伍；
-define(Team_Max_Keep_Secs_ForOffline, 30).

%%定时删除下线超时玩家, 30 seconds
-define(TeamDeleteOfflinePlayerTimer, 30 * 1000).

%% 组队设置
-define(Player_Team_Set_Freedom, 0). % default
-define(Player_Team_Set_PermitAll, 1).%选择允许所有组队，则如果有其他玩家向该玩家发送组队邀请则自动加入队伍
-define(Player_Team_Set_RefuseAll, 2).%选择拒绝所有组队，则如果有其他玩家向该玩家发送组队邀请则自动全部拒绝


%% 移除队员的原因
-define(Remove_Team_Member_Reason_Leave, 0).  %主动离开
-define(Remove_Team_Member_Reason_Offline, 1).  %玩家下线
-define(Remove_Team_Member_Reason_Kickout, 2). %被踢出队伍


%%邀请有效时间，单位：秒 maybe
-define(TeamInviteTime, 45).
%%定时更新邀请列表 maybe
-define(TeamUpdateInviteList, 10 * 1000).

%%定时删除无队玩家, maybe
-define(TeamDeletePlayerTimer, 60 * 1000).

%% 组队进副本
-define(Player_Team_Ready_None, 0). % 未准备
-define(Player_Team_Ready_OK, 1). % 准备
-define(Player_Team_Ready_Refuse, 2). % 拒绝

-endif.




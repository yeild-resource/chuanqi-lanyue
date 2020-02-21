
-define(CMD_C2GS_InviteTeam_Req,23001).
-record(pk_C2GS_InviteTeam_Req, {
	inviteeId
	}).
-define(CMD_GS2C_TeamInvite_Msg,23002).
-record(pk_GS2C_TeamInvite_Msg, {
	inviterId,
	inviterName
	}).
-define(CMD_GS2C_JoinTeam_Req,23003).
-record(pk_GS2C_JoinTeam_Req, {
	inviterId,
	inviterName
	}).
-define(CMD_C2GS_AcceptOrRefuseTeamInvite,23004).
-record(pk_C2GS_AcceptOrRefuseTeamInvite, {
	inviterId,
	isAccept
	}).
-define(CMD_C2GS_ApproveOrRefuseJoinTeam,23005).
-record(pk_C2GS_ApproveOrRefuseJoinTeam, {
	inviterId,
	isApprove
	}).
-define(CMD_C2GS_TeamInfo_Req,23006).
-record(pk_C2GS_TeamInfo_Req, {
	}).
-define(CMD_TeamMemberInfo,23007).
-record(pk_TeamMemberInfo, {
	id,
	name,
	level,
	career,
	sex,
	hp,
	maxhp,
	vipLevel,
	fightingCapacity,
	online,
	leagueId,
	mapDataID,
	isReady
	}).
-define(CMD_GS2C_TeamInfo,23008).
-record(pk_GS2C_TeamInfo, {
	teamId,
	leadId,
	member_list
	}).
-define(CMD_GS2C_TeamInfo_Ret,23009).
-record(pk_GS2C_TeamInfo_Ret, {
	teamId,
	leadId,
	member_list
	}).
-define(CMD_GS2C_AddTeamMember,23010).
-record(pk_GS2C_AddTeamMember, {
	member
	}).
-define(CMD_GS2C_RemoveTeamMember,23011).
-record(pk_GS2C_RemoveTeamMember, {
	memberId,
	reason
	}).
-define(CMD_C2GS_ExitTeam_Req,23012).
-record(pk_C2GS_ExitTeam_Req, {
	teamId
	}).
-define(CMD_GS2C_RemoveTeam,23013).
-record(pk_GS2C_RemoveTeam, {
	teamId
	}).
-define(CMD_C2GS_ChangeTeamSet_Req,23014).
-record(pk_C2GS_ChangeTeamSet_Req, {
	teamSet
	}).
-define(CMD_GS2C_ChangeTeamSet_Ret,23015).
-record(pk_GS2C_ChangeTeamSet_Ret, {
	teamSet
	}).
-define(CMD_C2GS_TeamKickOutPlayer,23016).
-record(pk_C2GS_TeamKickOutPlayer, {
	playerId
	}).
-define(CMD_C2GS_GetNearbyTeam,23017).
-record(pk_C2GS_GetNearbyTeam, {
	}).
-define(CMD_TeamLeaderInfo,23018).
-record(pk_TeamLeaderInfo, {
	playerId,
	name,
	level,
	career,
	sex,
	online,
	hp,
	maxhp,
	vipLevel,
	fightingCapacity,
	leagueId,
	mapDataID,
	memberNum
	}).
-define(CMD_GS2C_NearbyTeamRet,23019).
-record(pk_GS2C_NearbyTeamRet, {
	teamLeaderInfoList
	}).
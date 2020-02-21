
-define(CMD_LeagueMember,24001).
-record(pk_LeagueMember, {
	playerId,
	name,
	level,
	career,
	sex,
	vip,
	role,
	mapId,
	online,
	playerScore,
	joinedTimestamp,
	contributions,
	fightingCapacity
	}).
-define(CMD_LeagueInfo,24002).
-record(pk_LeagueInfo, {
	leagueId,
	name,
	maxCount,
	level,
	leagueMemberlist,
	leagueLeaderName,
	announcement,
	manifesto,
	isOpenLeagueCopy,
	openLeagueCopyTime,
	isBoughtLeagueCopyBuff,
	leagueCopyOpenTime,
	leagueScore,
	exp,
	fund,
	alliesCount,
	hostileLeagueCount,
	leagueRank,
	hasLeagueBoss,
	hasSigned
	}).
-define(CMD_LeagueListInfo,24003).
-record(pk_LeagueListInfo, {
	leagueRank,
	leagueId,
	name,
	leaderName,
	maxCount,
	curCount,
	level,
	operation,
	relationState,
	pkLeftSeconds
	}).
-define(CMD_C2GS_CreateLeague_Req,24004).
-record(pk_C2GS_CreateLeague_Req, {
	name
	}).
-define(CMD_GS2C_CreateLeague_Ret,24005).
-record(pk_GS2C_CreateLeague_Ret, {
	info
	}).
-define(CMD_C2GS_LeagueInfo_Req,24006).
-record(pk_C2GS_LeagueInfo_Req, {
	}).
-define(CMD_GS2C_LeagueInfo_Ret,24007).
-record(pk_GS2C_LeagueInfo_Ret, {
	info
	}).
-define(CMD_C2GS_LeagueInfoList_Req,24008).
-record(pk_C2GS_LeagueInfoList_Req, {
	page
	}).
-define(CMD_GS2C_LeagueInfoList_Ret,24009).
-record(pk_GS2C_LeagueInfoList_Ret, {
	page,
	totalPage,
	info_list
	}).
-define(CMD_C2GS_JoinLeague_Req,24010).
-record(pk_C2GS_JoinLeague_Req, {
	leagueId
	}).
-define(CMD_GS2C_JoinLeague_Ret,24011).
-record(pk_GS2C_JoinLeague_Ret, {
	retCode,
	leagueId
	}).
-define(CMD_GS2C_PushJoinLeagerApply_Ret,24012).
-record(pk_GS2C_PushJoinLeagerApply_Ret, {
	playerId,
	name,
	vip,
	level,
	career,
	sex
	}).
-define(CMD_C2GS_LeagueApplicants_Req,24013).
-record(pk_C2GS_LeagueApplicants_Req, {
	}).
-define(CMD_GS2C_LeagueApplicants_Ret,24014).
-record(pk_GS2C_LeagueApplicants_Ret, {
	applicantsList
	}).
-define(CMD_C2GS_AgreeJoinLeague_Req,24015).
-record(pk_C2GS_AgreeJoinLeague_Req, {
	joinPlayerId
	}).
-define(CMD_GS2C_AgreeJoinLeague_Ret,24016).
-record(pk_GS2C_AgreeJoinLeague_Ret, {
	retCode,
	joinPlayerId
	}).
-define(CMD_C2GS_RefuseJoinLeague_Req,24017).
-record(pk_C2GS_RefuseJoinLeague_Req, {
	joinPlayerId
	}).
-define(CMD_GS2C_RefuseJoinLeague_Ret,24018).
-record(pk_GS2C_RefuseJoinLeague_Ret, {
	retCode,
	joinPlayerId
	}).
-define(CMD_C2GS_ExitLeague_Req,24019).
-record(pk_C2GS_ExitLeague_Req, {
	}).
-define(CMD_GS2C_ExitLeague_Ret,24020).
-record(pk_GS2C_ExitLeague_Ret, {
	retCode
	}).
-define(CMD_C2GS_KickoutLeague_Req,24021).
-record(pk_C2GS_KickoutLeague_Req, {
	leagueMemberId
	}).
-define(CMD_GS2C_KickoutLeague_Ret,24022).
-record(pk_GS2C_KickoutLeague_Ret, {
	retCode,
	leagueMemberId
	}).
-define(CMD_C2GS_AppointLeader_Req,24023).
-record(pk_C2GS_AppointLeader_Req, {
	viceLeaderId
	}).
-define(CMD_GS2C_AppointLeader_Ret,24024).
-record(pk_GS2C_AppointLeader_Ret, {
	retCode,
	viceLeaderId
	}).
-define(CMD_C2GS_AppointViceLeader_Req,24025).
-record(pk_C2GS_AppointViceLeader_Req, {
	leagueMemberId
	}).
-define(CMD_GS2C_AppointViceLeader_Ret,24026).
-record(pk_GS2C_AppointViceLeader_Ret, {
	retCode,
	leagueMemberId
	}).
-define(CMD_C2GS_RemoveViceLeader_Req,24027).
-record(pk_C2GS_RemoveViceLeader_Req, {
	viceLeaderId
	}).
-define(CMD_GS2C_RemoveViceLeader_Ret,24028).
-record(pk_GS2C_RemoveViceLeader_Ret, {
	retCode,
	viceLeaderId
	}).
-define(CMD_C2GS_ChangeLeagueAnnouncement_Req,24029).
-record(pk_C2GS_ChangeLeagueAnnouncement_Req, {
	announcement
	}).
-define(CMD_GS2C_ChangeLeagueAnnouncement_Ret,24030).
-record(pk_GS2C_ChangeLeagueAnnouncement_Ret, {
	retCode,
	announcement
	}).
-define(CMD_C2GS_ChangeLeagueManifesto_Req,24031).
-record(pk_C2GS_ChangeLeagueManifesto_Req, {
	manifesto
	}).
-define(CMD_GS2C_ChangeLeagueManifesto_Ret,24032).
-record(pk_GS2C_ChangeLeagueManifesto_Ret, {
	retCode,
	manifesto
	}).
-define(CMD_GS2C_LeagueAddMember,24033).
-record(pk_GS2C_LeagueAddMember, {
	playerLeagueInfo
	}).
-define(CMD_GS2C_LeagueMemberAction,24034).
-record(pk_GS2C_LeagueMemberAction, {
	action,
	playerId,
	timestamp
	}).
-define(CMD_GS2C_LeagueChangeAnnouncement,24035).
-record(pk_GS2C_LeagueChangeAnnouncement, {
	playerId,
	announcement
	}).
-define(CMD_GS2C_PlayerLeague_Ret,24036).
-record(pk_GS2C_PlayerLeague_Ret, {
	leagueId,
	role,
	leagueName
	}).
-define(CMD_GS2C_LeaguePkCost,24037).
-record(pk_GS2C_LeaguePkCost, {
	type,
	count,
	time
	}).
-define(CMD_C2GS_OpenLeaguePk_Req,24038).
-record(pk_C2GS_OpenLeaguePk_Req, {
	leagueId
	}).
-define(CMD_GS2C_OpenLeaguePk_Ret,24039).
-record(pk_GS2C_OpenLeaguePk_Ret, {
	retCode,
	leagueId
	}).
-define(CMD_C2GS_OpenLeagueAllies_Req,24040).
-record(pk_C2GS_OpenLeagueAllies_Req, {
	leagueId
	}).
-define(CMD_GS2C_LeaguePkState,24041).
-record(pk_GS2C_LeaguePkState, {
	leagueId,
	leagueName,
	state
	}).
-define(CMD_LeaguePkInfo,24042).
-record(pk_LeaguePkInfo, {
	leagueId,
	leagueName,
	leftTime
	}).
-define(CMD_GS2C_LeaguePkInfo_List,24043).
-record(pk_GS2C_LeaguePkInfo_List, {
	leaguePkInfoList
	}).
-define(CMD_C2GS_EnrollManor,24044).
-record(pk_C2GS_EnrollManor, {
	enrollMapDataID,
	goldToPayFor
	}).
-define(CMD_GS2C_EnrollManorAck,24045).
-record(pk_GS2C_EnrollManorAck, {
	errorCode
	}).
-define(CMD_GS2C_MeetHigherPay,24046).
-record(pk_GS2C_MeetHigherPay, {
	unused
	}).
-define(CMD_C2GS_RequestAllManorInfo,24047).
-record(pk_C2GS_RequestAllManorInfo, {
	}).
-define(CMD_C2GS_RequestManorInfo,24048).
-record(pk_C2GS_RequestManorInfo, {
	mapDataID
	}).
-define(CMD_GS2C_ManorInfo,24049).
-record(pk_GS2C_ManorInfo, {
	mapDataID,
	owerGuildID,
	ownerGuildName,
	attackGuildID,
	attackGold,
	attackPlayer,
	attackLeagueName,
	moneyToGain,
	leftFightTime,
	state
	}).
-define(CMD_GS2C_AllManorInfo,24050).
-record(pk_GS2C_AllManorInfo, {
	info
	}).
-define(CMD_C2GS_EnterManorMap,24051).
-record(pk_C2GS_EnterManorMap, {
	mapDataID
	}).
-define(CMD_GS2C_EnterManorMapAck,24052).
-record(pk_GS2C_EnterManorMapAck, {
	errorCode
	}).
-define(CMD_C2GS_BuyBuff,24053).
-record(pk_C2GS_BuyBuff, {
	buffIDtoBuy
	}).
-define(CMD_GS2C_BuyBuffAck,24054).
-record(pk_GS2C_BuyBuffAck, {
	errorCode
	}).
-define(CMD_GS2C_ManorBattleInfo,24055).
-record(pk_GS2C_ManorBattleInfo, {
	everBuyBuff,
	defendBossHp,
	attackBossHp,
	attackPlayerNum,
	defencePlayerNum
	}).
-define(CMD_C2GS_GainManorAward,24056).
-record(pk_C2GS_GainManorAward, {
	mapDataID
	}).
-define(CMD_GS2C_GainManorAwardAck,24057).
-record(pk_GS2C_GainManorAwardAck, {
	errorCode
	}).
-define(CMD_C2GS_GaveupManor,24058).
-record(pk_C2GS_GaveupManor, {
	mapDataID
	}).
-define(CMD_GS2C_GaveupManorAck,24059).
-record(pk_GS2C_GaveupManorAck, {
	errorCode
	}).
-define(CMD_C2GS_LeagueBuy_Req,24060).
-record(pk_C2GS_LeagueBuy_Req, {
	itemDataId,
	num
	}).
-define(CMD_GS2C_LeagueBuy_Ret,24061).
-record(pk_GS2C_LeagueBuy_Ret, {
	result
	}).
-define(CMD_GS2C_LeaguePlayerScore,24062).
-record(pk_GS2C_LeaguePlayerScore, {
	score
	}).
-define(CMD_GS2C_LeaguePlayerUseArrow,24063).
-record(pk_GS2C_LeaguePlayerUseArrow, {
	playerName,
	mapDataId,
	posX,
	posY
	}).
-define(CMD_C2GS_LeaguePlayerResponseArrow,24064).
-record(pk_C2GS_LeaguePlayerResponseArrow, {
	mapDataId,
	posX,
	posY
	}).
-define(CMD_C2GS_LeagueCancelApplication_Req,24065).
-record(pk_C2GS_LeagueCancelApplication_Req, {
	leagueId
	}).
-define(CMD_GS2C_LeagueCancelApplication_Ret,24066).
-record(pk_GS2C_LeagueCancelApplication_Ret, {
	leagueId,
	ret
	}).
-define(CMD_C2GS_LeagueInvite_Req,24067).
-record(pk_C2GS_LeagueInvite_Req, {
	inviteePlayerId
	}).
-define(CMD_GS2C_LeagueInvite_Ret,24068).
-record(pk_GS2C_LeagueInvite_Ret, {
	ret
	}).
-define(CMD_GS2C_LeagueInvite,24069).
-record(pk_GS2C_LeagueInvite, {
	leagueId,
	leagueName
	}).
-define(CMD_C2GS_LeagueAgreeInvitation_Req,24070).
-record(pk_C2GS_LeagueAgreeInvitation_Req, {
	leagueId,
	operation
	}).
-define(CMD_GS2C_LeagueAgreeInvitation_Ret,24071).
-record(pk_GS2C_LeagueAgreeInvitation_Ret, {
	ret
	}).
-define(CMD_Leader_Money,24072).
-record(pk_Leader_Money, {
	mapid,
	money
	}).
-define(CMD_GS2C_Leader_Money,24073).
-record(pk_GS2C_Leader_Money, {
	moneylist
	}).
-define(CMD_C2GS_LeagueSign_Req,24074).
-record(pk_C2GS_LeagueSign_Req, {
	}).
-define(CMD_GS2C_LeagueSign_Ret,24075).
-record(pk_GS2C_LeagueSign_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueLevelUp_Req,24076).
-record(pk_C2GS_LeagueLevelUp_Req, {
	}).
-define(CMD_GS2C_LeagueLevelUp_Ret,24077).
-record(pk_GS2C_LeagueLevelUp_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueDonate_Req,24078).
-record(pk_C2GS_LeagueDonate_Req, {
	moneyType,
	num
	}).
-define(CMD_GS2C_LeagueDonate_Ret,24079).
-record(pk_GS2C_LeagueDonate_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueBoss_Req,24080).
-record(pk_C2GS_LeagueBoss_Req, {
	}).
-define(CMD_GS2C_LeagueBoss_Ret,24081).
-record(pk_GS2C_LeagueBoss_Ret, {
	level,
	currentExp,
	requiredExp,
	currentPill,
	requiredPill,
	freeInspireTimes,
	inspired
	}).
-define(CMD_C2GS_LeagueBossInspire_Req,24082).
-record(pk_C2GS_LeagueBossInspire_Req, {
	useTreasure
	}).
-define(CMD_GS2C_LeagueBossInspire_Ret,24083).
-record(pk_GS2C_LeagueBossInspire_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueBossUpgrade_Req,24084).
-record(pk_C2GS_LeagueBossUpgrade_Req, {
	}).
-define(CMD_GS2C_LeagueBossUpgrade_Ret,24085).
-record(pk_GS2C_LeagueBossUpgrade_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueBossTrain_Req,24086).
-record(pk_C2GS_LeagueBossTrain_Req, {
	}).
-define(CMD_GS2C_LeagueBossTrain_Ret,24087).
-record(pk_GS2C_LeagueBossTrain_Ret, {
	errorCode
	}).
-define(CMD_LeagueBattleInfo,24088).
-record(pk_LeagueBattleInfo, {
	battleId,
	level,
	occupyingLeagueId,
	highestBid,
	myLeagueBid
	}).
-define(CMD_C2GS_LeagueBattleInfo_Req,24089).
-record(pk_C2GS_LeagueBattleInfo_Req, {
	}).
-define(CMD_GS2C_LeagueBattleInfo_Ret,24090).
-record(pk_GS2C_LeagueBattleInfo_Ret, {
	leagueBattleInfoList
	}).
-define(CMD_C2GS_LeagueBattleBid_Req,24091).
-record(pk_C2GS_LeagueBattleBid_Req, {
	leagueBattleId,
	currencyType,
	value
	}).
-define(CMD_GS2C_LeagueBattleBid_Ret,24092).
-record(pk_GS2C_LeagueBattleBid_Ret, {
	errorCode
	}).
-define(CMD_C2GS_LeagueEscort_Req,24093).
-record(pk_C2GS_LeagueEscort_Req, {
	index
	}).
-define(CMD_C2GS_LeagueEscortQuery_Req,24094).
-record(pk_C2GS_LeagueEscortQuery_Req, {
	}).
-define(CMD_LeagueEscortInfo,24095).
-record(pk_LeagueEscortInfo, {
	leagueName,
	leagueId,
	escortIndex
	}).
-define(CMD_GS2C_LeagueEscortQuery_Req,24096).
-record(pk_GS2C_LeagueEscortQuery_Req, {
	leagueEscortInfoList
	}).
-define(CMD_C2GS_LeagueStartRob_Req,24097).
-record(pk_C2GS_LeagueStartRob_Req, {
	leagueId,
	index
	}).
-define(CMD_C2GS_LeagueSignIn_Req,24098).
-record(pk_C2GS_LeagueSignIn_Req, {
	}).
-define(CMD_GS2C_LEagueSignIn_Ret,24099).
-record(pk_GS2C_LEagueSignIn_Ret, {
	errorCode
	}).

-define(CMD_C2GS_LuckWheelGetInfo,27001).
-record(pk_C2GS_LuckWheelGetInfo, {
	}).
-define(CMD_GS2C_LuckWheelGetInfoRet,27002).
-record(pk_GS2C_LuckWheelGetInfoRet, {
	days,
	times
	}).
-define(CMD_C2GC_LuckWheelGet,27003).
-record(pk_C2GC_LuckWheelGet, {
	}).
-define(CMD_GS2C_LuckWheelItem,27004).
-record(pk_GS2C_LuckWheelItem, {
	index
	}).
-define(CMD_GC2C_LuckWheelGetRet,27005).
-record(pk_GC2C_LuckWheelGetRet, {
	days,
	times,
	awardItems
	}).
-define(CMD_C2GS_Campfire_Action,27006).
-record(pk_C2GS_Campfire_Action, {
	action
	}).
-define(CMD_GS2C_Campfire_ActionRet,27007).
-record(pk_GS2C_Campfire_ActionRet, {
	playerID,
	action
	}).
-define(CMD_C2GS_RushMission_Start,27008).
-record(pk_C2GS_RushMission_Start, {
	}).
-define(CMD_C2GS_RushMission_Reset,27009).
-record(pk_C2GS_RushMission_Reset, {
	}).
-define(CMD_C2GS_RushMission_Leave,27010).
-record(pk_C2GS_RushMission_Leave, {
	}).
-define(CMD_GS2C_RushMission_Ret,27011).
-record(pk_GS2C_RushMission_Ret, {
	result
	}).
-define(CMD_C2GS_RushMission_GetAward,27012).
-record(pk_C2GS_RushMission_GetAward, {
	rewardType
	}).
-define(CMD_GS2C_RushMission_BattleInfo,27013).
-record(pk_GS2C_RushMission_BattleInfo, {
	currentLayer,
	aliveMonsters,
	exp,
	coin
	}).
-define(CMD_GS2C_RushMission_Time,27014).
-record(pk_GS2C_RushMission_Time, {
	type,
	time
	}).
-define(CMD_C2GS_OpenServerAward_Req,27015).
-record(pk_C2GS_OpenServerAward_Req, {
	day
	}).
-define(CMD_GS2C_OpenServerAward_Ret,27016).
-record(pk_GS2C_OpenServerAward_Ret, {
	result
	}).
-define(CMD_C2GS_LevelAward_Req,27017).
-record(pk_C2GS_LevelAward_Req, {
	level
	}).
-define(CMD_GS2C_LevelAward_Ret,27018).
-record(pk_GS2C_LevelAward_Ret, {
	result
	}).
-define(CMD_GS2C_TimeBox_LeftTime,27019).
-record(pk_GS2C_TimeBox_LeftTime, {
	sec
	}).
-define(CMD_GS2C_TimeBox_AccumulatedTime,27020).
-record(pk_GS2C_TimeBox_AccumulatedTime, {
	seconds,
	awardedStages
	}).
-define(CMD_C2GS_TimeBoxAward_Req,27021).
-record(pk_C2GS_TimeBoxAward_Req, {
	stage
	}).
-define(CMD_GS2C_TimeBoxAward_Ret,27022).
-record(pk_GS2C_TimeBoxAward_Ret, {
	result,
	awardedStage
	}).
-define(CMD_C2GS_RequestBossInfo,27023).
-record(pk_C2GS_RequestBossInfo, {
	}).
-define(CMD_SRecentKill,27024).
-record(pk_SRecentKill, {
	time,
	playerID,
	name
	}).
-define(CMD_BossInfo,27025).
-record(pk_BossInfo, {
	mapDataID,
	bossID,
	bossState,
	leftRefreshTime,
	recentKill
	}).
-define(CMD_GS2C_RequestBossInfo,27026).
-record(pk_GS2C_RequestBossInfo, {
	vinfolist
	}).
-define(CMD_C2GS_EnterUndergroundPalace,27027).
-record(pk_C2GS_EnterUndergroundPalace, {
	}).
-define(CMD_GS2C_LeftSeconds,27028).
-record(pk_GS2C_LeftSeconds, {
	leftSeconds
	}).
-define(CMD_C2GS_LeaveUndergroundPalace,27029).
-record(pk_C2GS_LeaveUndergroundPalace, {
	}).
-define(CMD_GS2C_UndergroundPalace_Ret,27030).
-record(pk_GS2C_UndergroundPalace_Ret, {
	ret
	}).
-define(CMD_UndergroundPalaceDamageInfo,27031).
-record(pk_UndergroundPalaceDamageInfo, {
	playerName,
	damage
	}).
-define(CMD_GS2C_UndergroundPalaceDamageRank,27032).
-record(pk_GS2C_UndergroundPalaceDamageRank, {
	damageList,
	myDamage
	}).
-define(CMD_GS2C_UndergroundPalaceCurrentLayer,27033).
-record(pk_GS2C_UndergroundPalaceCurrentLayer, {
	currentLayer
	}).
-define(CMD_ServerActivity,27034).
-record(pk_ServerActivity, {
	level,
	canget,
	isget
	}).
-define(CMD_C2GS_ServerActivity_Info,27035).
-record(pk_C2GS_ServerActivity_Info, {
	type
	}).
-define(CMD_GS2C_ServerActivity_Info_Ret,27036).
-record(pk_GS2C_ServerActivity_Info_Ret, {
	type,
	startTime,
	info
	}).
-define(CMD_C2GS_ServerActivity_GetAward,27037).
-record(pk_C2GS_ServerActivity_GetAward, {
	type,
	level
	}).
-define(CMD_GS2C_Server_HasOpenServerChargeAward,27038).
-record(pk_GS2C_Server_HasOpenServerChargeAward, {
	hasOpenServerChargeAward
	}).
-define(CMD_C2GS_Server_OpenServerChargeAward_Req,27039).
-record(pk_C2GS_Server_OpenServerChargeAward_Req, {
	}).
-define(CMD_GS2C_OpenServerChargeAward_Ret,27040).
-record(pk_GS2C_OpenServerChargeAward_Ret, {
	startTime,
	endTime,
	rechargedNum,
	chargeAwardGetList
	}).
-define(CMD_C2GS_OpenServerChargeAward_Get,27041).
-record(pk_C2GS_OpenServerChargeAward_Get, {
	awardid
	}).
-define(CMD_GS2C_OpenServerChargeAward_Get_Ret,27042).
-record(pk_GS2C_OpenServerChargeAward_Get_Ret, {
	chargeAwardGetList
	}).
-define(CMD_C2GS_EnterKillingIsland,27043).
-record(pk_C2GS_EnterKillingIsland, {
	}).
-define(CMD_C2GS_LeaveKillingIsland,27044).
-record(pk_C2GS_LeaveKillingIsland, {
	}).
-define(CMD_GS2C_KillingIsland_Ret,27045).
-record(pk_GS2C_KillingIsland_Ret, {
	ret
	}).
-define(CMD_KillingIslandScoreInfo,27046).
-record(pk_KillingIslandScoreInfo, {
	playerName,
	score
	}).
-define(CMD_GS2C_KillingIslandScoreRank,27047).
-record(pk_GS2C_KillingIslandScoreRank, {
	scoreList,
	myScore
	}).
-define(CMD_C2GS_OpenServerPlayerLevelAwardInfo_Req,27048).
-record(pk_C2GS_OpenServerPlayerLevelAwardInfo_Req, {
	}).
-define(CMD_ImpacitemInfo,27049).
-record(pk_ImpacitemInfo, {
	id,
	num,
	bin
	}).
-define(CMD_PlayerInfo,27050).
-record(pk_PlayerInfo, {
	playerName,
	playerLevel,
	awarditemDataIdList,
	canGetAward,
	career,
	sex
	}).
-define(CMD_RankAwardInfo,27051).
-record(pk_RankAwardInfo, {
	num,
	level,
	awardItemDataIdList,
	canGetAward
	}).
-define(CMD_GS2C_OpenServerPlayerLevelAwardInfo_Ret,27052).
-record(pk_GS2C_OpenServerPlayerLevelAwardInfo_Ret, {
	firstSecondThirdPlayerInfoList,
	rankAwardInfoList,
	time
	}).
-define(CMD_C2GS_GetOpenServerPlayerLevelAward_Req,27053).
-record(pk_C2GS_GetOpenServerPlayerLevelAward_Req, {
	buttonId
	}).
-define(CMD_C2GS_OpenGrowthFundInfo_Req,27054).
-record(pk_C2GS_OpenGrowthFundInfo_Req, {
	}).
-define(CMD_GrowthFundInfo,27055).
-record(pk_GrowthFundInfo, {
	id,
	gold,
	isBind,
	isGet
	}).
-define(CMD_GS2C_OpenGrowthFundInfo_Ret,27056).
-record(pk_GS2C_OpenGrowthFundInfo_Ret, {
	growthFundInfoList,
	isBuy
	}).
-define(CMD_C2GS_BuyGrowthFund_Req,27057).
-record(pk_C2GS_BuyGrowthFund_Req, {
	}).
-define(CMD_C2GS_GetOpenGrowthFundAward_Req,27058).
-record(pk_C2GS_GetOpenGrowthFundAward_Req, {
	id
	}).
-define(CMD_C2GS_OpenTotalChargeInfo_Req,27059).
-record(pk_C2GS_OpenTotalChargeInfo_Req, {
	}).
-define(CMD_TotalChargeitemInfo,27060).
-record(pk_TotalChargeitemInfo, {
	id,
	num,
	bin
	}).
-define(CMD_TotalChargeInfo,27061).
-record(pk_TotalChargeInfo, {
	id,
	chargeGold,
	awarditemDataList,
	canGetAward
	}).
-define(CMD_GS2C_OpenTotalChargeInfo_Ret,27062).
-record(pk_GS2C_OpenTotalChargeInfo_Ret, {
	totalChargeInfoList,
	time
	}).
-define(CMD_C2GS_GetTotalChargeAward_Req,27063).
-record(pk_C2GS_GetTotalChargeAward_Req, {
	id
	}).
-define(CMD_C2GS_OpenLuxurySigninInfo_Req,27064).
-record(pk_C2GS_OpenLuxurySigninInfo_Req, {
	}).
-define(CMD_GS2C_OpenLuxurySigninInfo_Ret,27065).
-record(pk_GS2C_OpenLuxurySigninInfo_Ret, {
	getInfoList
	}).
-define(CMD_C2GS_GetLuxurySigninAward_Req,27066).
-record(pk_C2GS_GetLuxurySigninAward_Req, {
	id
	}).
-define(CMD_C2GS_OpenExchangeWordInfo_Req,27067).
-record(pk_C2GS_OpenExchangeWordInfo_Req, {
	}).
-define(CMD_GS2C_OpenExchangeWordInfo_Ret,27068).
-record(pk_GS2C_OpenExchangeWordInfo_Ret, {
	time
	}).
-define(CMD_C2GS_GetExchangeWordAward_Req,27069).
-record(pk_C2GS_GetExchangeWordAward_Req, {
	id
	}).
-define(CMD_GS2C_GetExchangeWordAward_Ret,27070).
-record(pk_GS2C_GetExchangeWordAward_Ret, {
	errCode
	}).
-define(CMD_C2GS_GetBossExchange_Req,27071).
-record(pk_C2GS_GetBossExchange_Req, {
	id
	}).
-define(CMD_QuanminBoss,27072).
-record(pk_QuanminBoss, {
	bossID,
	bossState,
	leftRefreshTime
	}).
-define(CMD_C2GS_OpenQuanminBossInfo_Req,27073).
-record(pk_C2GS_OpenQuanminBossInfo_Req, {
	}).
-define(CMD_GS2C_OpenQuanminBossInfo_Ret,27074).
-record(pk_GS2C_OpenQuanminBossInfo_Ret, {
	bossInfoList,
	time
	}).
-define(CMD_C2GS_OpenSevenDaysCheerInfo_Req,27075).
-record(pk_C2GS_OpenSevenDaysCheerInfo_Req, {
	}).
-define(CMD_GS2C_OpenSevenDaysCheerInfo_Ret,27076).
-record(pk_GS2C_OpenSevenDaysCheerInfo_Ret, {
	leftTime,
	curDay,
	sevenDayGetList,
	activityRelated,
	sevenAchievementGetList
	}).
-define(CMD_C2GS_GetSevenDaysCheerSingleAward_Req,27077).
-record(pk_C2GS_GetSevenDaysCheerSingleAward_Req, {
	id
	}).
-define(CMD_GS2C_GetSevenDaysCheerSingleAward_Ret,27078).
-record(pk_GS2C_GetSevenDaysCheerSingleAward_Ret, {
	curDay,
	sevenDayGetList
	}).
-define(CMD_C2GS_GetSevenDaysCheerAchieveAward_Req,27079).
-record(pk_C2GS_GetSevenDaysCheerAchieveAward_Req, {
	id
	}).
-define(CMD_GS2C_GetSevenDaysCheerAchieveAward_Ret,27080).
-record(pk_GS2C_GetSevenDaysCheerAchieveAward_Ret, {
	sevenAchievementGetList
	}).

-define(CMD_GS2LS_Register_Request,11001).
-record(pk_GS2LS_Register_Request, {
	serverID,
	sign,
	startTime
	}).
-define(CMD_LS2GS_Register_Ret,11002).
-record(pk_LS2GS_Register_Ret, {
	retCode
	}).
-define(CMD_LS2GS_GetPlayerInfo_Request,11003).
-record(pk_LS2GS_GetPlayerInfo_Request, {
	userID
	}).
-define(CMD_GS2LS_GetPlayerInfo_Ret,11004).
-record(pk_GS2LS_GetPlayerInfo_Ret, {
	accountID,
	userID,
	isExist,
	career,
	sex,
	level,
	name
	}).
-define(CMD_LS2GS_UserReadyToLogin,11005).
-record(pk_LS2GS_UserReadyToLogin, {
	platId,
	accountID,
	account,
	sign,
	gyyxLf
	}).
-define(CMD_GS2LS_UserLogin,11006).
-record(pk_GS2LS_UserLogin, {
	platId,
	accountID,
	account,
	sign,
	clientip
	}).
-define(CMD_GS2LS_UserLogout,11007).
-record(pk_GS2LS_UserLogout, {
	userID
	}).
-define(CMD_LS2GS_UserKick,11008).
-record(pk_LS2GS_UserKick, {
	userID
	}).
-define(CMD_LS2GS_PayInfo_Request,11009).
-record(pk_LS2GS_PayInfo_Request, {
	webPid,
	op
	}).
-define(CMD_GS2LS_PayInfo_Ret,11010).
-record(pk_GS2LS_PayInfo_Ret, {
	webPid,
	orderId,
	retCode
	}).
-define(CMD_LS2GS_GM_CMD_Request,11011).
-record(pk_LS2GS_GM_CMD_Request, {
	webPid,
	op
	}).
-define(CMD_GS2LS_GM_CMD_Ret,11012).
-record(pk_GS2LS_GM_CMD_Ret, {
	webPid,
	name,
	retCode
	}).
-define(CMD_LS2GS_Kick_Player_Off_Request,11013).
-record(pk_LS2GS_Kick_Player_Off_Request, {
	webPid,
	name
	}).
-define(CMD_GS2LS_Kick_Player_Off_Ret,11014).
-record(pk_GS2LS_Kick_Player_Off_Ret, {
	webPid,
	name,
	retCode
	}).
-define(CMD_LS2GS_Announcement_Request,11015).
-record(pk_LS2GS_Announcement_Request, {
	webPid,
	msg
	}).
-define(CMD_GS2LS_Announcement_Ret,11016).
-record(pk_GS2LS_Announcement_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_control_activity_Request,11017).
-record(pk_LS2GS_control_activity_Request, {
	webPid,
	op
	}).
-define(CMD_GS2LS_control_activity_Ret,11018).
-record(pk_GS2LS_control_activity_Ret, {
	webPid,
	retCode
	}).
-define(CMD_GS2LS_kickOutUser,11019).
-record(pk_GS2LS_kickOutUser, {
	userId
	}).
-define(CMD_GS2LS_upadateOnlinePlayerCnt,11020).
-record(pk_GS2LS_upadateOnlinePlayerCnt, {
	onlinePlayerCnt
	}).
-define(CMD_LS2GS_Forbid_Chat_Request,11021).
-record(pk_LS2GS_Forbid_Chat_Request, {
	webPid,
	name,
	time,
	flag
	}).
-define(CMD_GS2LS_Forbid_Chat_Request_Ret,11022).
-record(pk_GS2LS_Forbid_Chat_Request_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_SET_GM_Request,11023).
-record(pk_LS2GS_SET_GM_Request, {
	webPid,
	name,
	flag
	}).
-define(CMD_GS2LS_SET_GM_Request_Ret,11024).
-record(pk_GS2LS_SET_GM_Request_Ret, {
	webPid,
	retCode
	}).
-define(CMD_GS2LS_PlayerOffline,11025).
-record(pk_GS2LS_PlayerOffline, {
	userId,
	expireTime
	}).
-define(CMD_LS2GS_Item,11026).
-record(pk_LS2GS_Item, {
	itemDataId,
	itemCnt,
	flag
	}).
-define(CMD_LS2GS_Send_System_Mail,11027).
-record(pk_LS2GS_Send_System_Mail, {
	webPid,
	flag,
	lowLevel,
	highLevel,
	mailTitle,
	mailContent,
	receiveName,
	receivePlayerID,
	itemList
	}).
-define(CMD_GS2LS_Send_System_Mail_Ret,11028).
-record(pk_GS2LS_Send_System_Mail_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_recover_role_Request,11029).
-record(pk_LS2GS_recover_role_Request, {
	webPid,
	op
	}).
-define(CMD_GS2LS_recover_role_Ret,11030).
-record(pk_GS2LS_recover_role_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_PlayerRename_Request,11031).
-record(pk_LS2GS_PlayerRename_Request, {
	webPid,
	oldName,
	newName
	}).
-define(CMD_GS2LS_PlayerRename_Ret,11032).
-record(pk_GS2LS_PlayerRename_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_LeagueRename_Request,11033).
-record(pk_LS2GS_LeagueRename_Request, {
	webPid,
	oldName,
	newName
	}).
-define(CMD_GS2LS_LeagueRename_Ret,11034).
-record(pk_GS2LS_LeagueRename_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_ManualMonster_Request,11035).
-record(pk_LS2GS_ManualMonster_Request, {
	webPid,
	monsterId,
	monsterNum,
	mapId,
	x,
	y
	}).
-define(CMD_GS2LS_ManualMonster_Ret,11036).
-record(pk_GS2LS_ManualMonster_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_Pay_Related_Request,11037).
-record(pk_LS2GS_Pay_Related_Request, {
	webPid,
	type,
	beginTime,
	endTime,
	desc,
	content
	}).
-define(CMD_GS2LS_Pay_Related_Ret,11038).
-record(pk_GS2LS_Pay_Related_Ret, {
	webPid,
	retCode
	}).
-define(CMD_LS2GS_UCVip_Info,11039).
-record(pk_LS2GS_UCVip_Info, {
	userID,
	isVip,
	first_role,
	first_pay
	}).
-define(CMD_GS2LS_CleanZombiePlayers_Ret,11040).
-record(pk_GS2LS_CleanZombiePlayers_Ret, {
	result_code
	}).
-define(CMD_GS2LS_CleanZombieLeagues_Ret,11041).
-record(pk_GS2LS_CleanZombieLeagues_Ret, {
	result_code
	}).
-define(CMD_GS2LS_BindAccount,11042).
-record(pk_GS2LS_BindAccount, {
	devimei,
	account,
	platformID,
	userID,
	playerID,
	fromserverID,
	password,
	flage
	}).
-define(CMD_LS2GS_BindAccountAck,11043).
-record(pk_LS2GS_BindAccountAck, {
	userID,
	playerID,
	errorCode,
	flage
	}).
-define(CMD_LS2GS_CrossZone,11044).
-record(pk_LS2GS_CrossZone, {
	webPid,
	data
	}).
-define(CMD_GS2LS_CrossZone,11045).
-record(pk_GS2LS_CrossZone, {
	webPid,
	errorCode
	}).
-define(CMD_LS2GS_SetFirstPay_State,11046).
-record(pk_LS2GS_SetFirstPay_State, {
	webPid,
	state
	}).
-define(CMD_LS2GS_SWITCH_USERID,11047).
-record(pk_LS2GS_SWITCH_USERID, {
	webPid,
	desAccountId,
	srcAccountId,
	srcPlayerId
	}).
-define(CMD_GS2LS_SWITCH_USERID,11048).
-record(pk_GS2LS_SWITCH_USERID, {
	webPid,
	errorCode
	}).
-define(CMD_LS2GS_ADD_VIP,11049).
-record(pk_LS2GS_ADD_VIP, {
	webPid,
	score,
	playerId
	}).
-define(CMD_GS2LS_ADD_VIP,11050).
-record(pk_GS2LS_ADD_VIP, {
	webPid,
	errorCode
	}).
-define(CMD_LS2GS_ReciveMailPlayer,11051).
-record(pk_LS2GS_ReciveMailPlayer, {
	recivePlayerID,
	recivePlayerName
	}).
-define(CMD_LS2GS_Send_PlayerMail,11052).
-record(pk_LS2GS_Send_PlayerMail, {
	webPid,
	flag,
	mailTitle,
	mailContent,
	receivePlayerList,
	itemList
	}).
-define(CMD_LS2GS_Send_BroadCast,11053).
-record(pk_LS2GS_Send_BroadCast, {
	webPid,
	spacetime,
	times,
	msgtype,
	content
	}).
-define(CMD_LS2GS_Rebate_Active,11054).
-record(pk_LS2GS_Rebate_Active, {
	webPid,
	begintime,
	endtime,
	rebateride
	}).
-define(CMD_LS2GS_Pay_Zhaocai,11055).
-record(pk_LS2GS_Pay_Zhaocai, {
	webPid,
	type,
	beginTime,
	endTime,
	content
	}).
-define(CMD_LS2GS_Start_Charge_Award,11056).
-record(pk_LS2GS_Start_Charge_Award, {
	webPid,
	begintime,
	endtime
	}).
-define(CMD_GS2LS_Start_Charge_Award_Ret,11057).
-record(pk_GS2LS_Start_Charge_Award_Ret, {
	webPid,
	errorCode
	}).
-define(CMD_LS2GS_Send_Notice,11058).
-record(pk_LS2GS_Send_Notice, {
	webPid,
	begintime,
	endtime,
	content
	}).
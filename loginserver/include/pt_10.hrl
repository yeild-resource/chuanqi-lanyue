
-define(CMD_PlatformSpecific,10001).
-record(pk_PlatformSpecific, {
	platformSpecificParameter
	}).
-define(CMD_C2LS_Login_Test,10002).
-record(pk_C2LS_Login_Test, {
	account,
	platformID,
	sign,
	deviceIMEI,
	screenSize,
	channelId,
	publicUrl,
	bundleId,
	salt,
	timestamp,
	platformSpecific
	}).
-define(CMD_LS2C_Login_Ret,10003).
-record(pk_LS2C_Login_Ret, {
	result,
	userID,
	acAccount
	}).
-define(CMD_GS2C_LS2C_LoginExData_Ret,10004).
-record(pk_GS2C_LS2C_LoginExData_Ret, {
	userID,
	refeshToken,
	customInfo
	}).
-define(CMD_C2LS_RequestGameServerList,10005).
-record(pk_C2LS_RequestGameServerList, {
	}).
-define(CMD_GameServerInfo,10006).
-record(pk_GameServerInfo, {
	id,
	name,
	status,
	desc,
	isExist,
	career,
	sex,
	level,
	playerName,
	isNew,
	regionName
	}).
-define(CMD_LS2C_GameServerList_Ret,10007).
-record(pk_LS2C_GameServerList_Ret, {
	regionCnt,
	lsBroadcast,
	gameServers
	}).
-define(CMD_C2LS_RequestSelGameServer,10008).
-record(pk_C2LS_RequestSelGameServer, {
	serverID
	}).
-define(CMD_LS2C_SelGameServer_Ret,10009).
-record(pk_LS2C_SelGameServer_Ret, {
	retCode,
	ip,
	port,
	sign,
	serverID
	}).
-define(CMD_C2LS_BackPreStatus,10010).
-record(pk_C2LS_BackPreStatus, {
	}).
-define(CMD_C2LS_RequestGameServerListEx,10011).
-record(pk_C2LS_RequestGameServerListEx, {
	platformID
	}).
-define(CMD_C2LS_LoginEx,10012).
-record(pk_C2LS_LoginEx, {
	account,
	platformID,
	sign,
	deviceIMEI,
	screenSize,
	channelId,
	serverID
	}).
-define(CMD_C2LS_Register_Test,10013).
-record(pk_C2LS_Register_Test, {
	account,
	sign
	}).
-define(CMD_LS2C_Register_Ret,10014).
-record(pk_LS2C_Register_Ret, {
	result,
	account,
	sign
	}).
-define(CMD_C2LS_CrossLogin_Test,10015).
-record(pk_C2LS_CrossLogin_Test, {
	account,
	platformID,
	sign,
	deviceIMEI,
	screenSize,
	channelId,
	direction
	}).
-define(CMD_LS2C_CrossLogin_Ret,10016).
-record(pk_LS2C_CrossLogin_Ret, {
	result,
	userID
	}).
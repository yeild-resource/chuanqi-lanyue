
-define(CMD_C2GS_Login,25001).
-record(pk_C2GS_Login, {
	accountID,
	sign,
	version,
	serverId
	}).
-define(CMD_UserPlayerData,25002).
-record(pk_UserPlayerData, {
	playerID,
	name,
	level,
	career,
	sex
	}).
-define(CMD_GS2C_Login_Ret,25003).
-record(pk_GS2C_Login_Ret, {
	retCode,
	player_list
	}).
-define(CMD_C2GS_CreatePlayer,25004).
-record(pk_C2GS_CreatePlayer, {
	name,
	career,
	sex
	}).
-define(CMD_GS2C_CreatePlayer_Ret,25005).
-record(pk_GS2C_CreatePlayer_Ret, {
	retCode,
	player_list
	}).
-define(CMD_C2GS_DeletePlayer,25006).
-record(pk_C2GS_DeletePlayer, {
	playerID
	}).
-define(CMD_GS2C_DeletePlayer_Ret,25007).
-record(pk_GS2C_DeletePlayer_Ret, {
	retCode,
	player_list
	}).
-define(CMD_C2GS_EnterGame,25008).
-record(pk_C2GS_EnterGame, {
	playerID
	}).
-define(CMD_GS2C_ReturnToSelectRoleDlg_Ret,25009).
-record(pk_GS2C_ReturnToSelectRoleDlg_Ret, {
	retCode,
	player_list
	}).
-define(CMD_GS2C_SendPlayerDataComplete,25010).
-record(pk_GS2C_SendPlayerDataComplete, {
	mapDataId,
	x,
	y
	}).
-define(CMD_C2GS_EnterMap,25011).
-record(pk_C2GS_EnterMap, {
	}).
-define(CMD_GS2C_UserQueueInfo,25012).
-record(pk_GS2C_UserQueueInfo, {
	rank,
	totalRank,
	remainTime,
	plt,
	sign,
	acc
	}).
-define(CMD_GS2C_UserQueuePrompt,25013).
-record(pk_GS2C_UserQueuePrompt, {
	result,
	rank,
	totalRank,
	remainTime
	}).
-define(CMD_C2GS_UserQueueLogin,25014).
-record(pk_C2GS_UserQueueLogin, {
	accountId,
	plt,
	sign,
	acc
	}).
-define(CMD_C2GS_CannelQueue,25015).
-record(pk_C2GS_CannelQueue, {
	accountId
	}).
-define(CMD_C2GS_LeaveGame,25016).
-record(pk_C2GS_LeaveGame, {
	}).
-define(CMD_GS2C_ReConnectKey,25017).
-record(pk_GS2C_ReConnectKey, {
	key
	}).
-define(CMD_C2GS_Reconnect,25018).
-record(pk_C2GS_Reconnect, {
	userID,
	key,
	serverId
	}).
-define(CMD_GS2C_ReconnectAck,25019).
-record(pk_GS2C_ReconnectAck, {
	errorcode
	}).
-define(CMD_C2GS_CrossGame_Req,25020).
-record(pk_C2GS_CrossGame_Req, {
	playerID
	}).
-define(CMD_GS2C_CrossGame_Ret,25021).
-record(pk_GS2C_CrossGame_Ret, {
	result
	}).
-define(CMD_GS2C_InCrossGame,25022).
-record(pk_GS2C_InCrossGame, {
	playerID,
	side,
	remainSec
	}).
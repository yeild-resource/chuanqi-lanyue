
-define(CMD_LS2PS_Register_Request,31001).
-record(pk_LS2PS_Register_Request, {
	serverID,
	sign
	}).
-define(CMD_PS2LS_Register_Ret,31002).
-record(pk_PS2LS_Register_Ret, {
	retCode
	}).
-define(CMD_PS2LS_PayInfo_Request,31003).
-record(pk_PS2LS_PayInfo_Request, {
	orderId,
	gameId,
	serverId,
	platformId,
	accountId,
	payWay,
	amount
	}).
-define(CMD_LS2PS_PayInfo_Ret,31004).
-record(pk_LS2PS_PayInfo_Ret, {
	orderId,
	retCode
	}).
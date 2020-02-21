
-define(CMD_C2GS_Start_Gather,26001).
-record(pk_C2GS_Start_Gather, {
	gatherId
	}).
-define(CMD_GS2C_Start_Gather,26002).
-record(pk_GS2C_Start_Gather, {
	gatherId,
	retCode
	}).
-define(CMD_GS2C_Interrupt_Gather,26003).
-record(pk_GS2C_Interrupt_Gather, {
	gatherId,
	interrupt_type
	}).
-define(CMD_C2GS_Complete_Gather,26004).
-record(pk_C2GS_Complete_Gather, {
	gatherId
	}).
-define(CMD_GS2C_Complete_Gather,26005).
-record(pk_GS2C_Complete_Gather, {
	gatherId,
	retCode
	}).
-define(CMD_C2GS_Ill_Wealth_Gather,26006).
-record(pk_C2GS_Ill_Wealth_Gather, {
	gatherId
	}).
-define(CMD_GS2C_Ill_Wealth_Gather,26007).
-record(pk_GS2C_Ill_Wealth_Gather, {
	playerId,
	gatherId,
	gatherCdSeconds,
	retCode
	}).
-define(CMD_C2GS_GatherEnergyTower_Req,26008).
-record(pk_C2GS_GatherEnergyTower_Req, {
	npcId
	}).
-define(CMD_GS2C_GatherEnergyTower_Ret,26009).
-record(pk_GS2C_GatherEnergyTower_Ret, {
	errorCode
	}).

-define(CMD_C2GS_MineStart,18001).
-record(pk_C2GS_MineStart, {
	posMineX,
	posMineY
	}).
-define(CMD_GS2C_MineState,18002).
-record(pk_GS2C_MineState, {
	playerId,
	type
	}).
-define(CMD_C2GS_MineInitReq,18003).
-record(pk_C2GS_MineInitReq, {
	}).
-define(CMD_GS2C_MineInitRet,18004).
-record(pk_GS2C_MineInitRet, {
	freeLuckyTimes,
	minedLuckyTimes,
	freeMysteryTimes,
	minedMysteryTimes
	}).
-define(CMD_C2GS_Mine,18005).
-record(pk_C2GS_Mine, {
	mine_type,
	mine_count,
	flag
	}).
-define(CMD_GS2C_MineRet,18006).
-record(pk_GS2C_MineRet, {
	itemDataId
	}).
-define(CMD_GS2C_MineErrRet,18007).
-record(pk_GS2C_MineErrRet, {
	}).
-define(CMD_C2GS_ResetMine,18008).
-record(pk_C2GS_ResetMine, {
	mine_type
	}).
-define(CMD_C2GS_ResetMineCost,18009).
-record(pk_C2GS_ResetMineCost, {
	mine_type
	}).
-define(CMD_GS2C_ResetMineCostRes,18010).
-record(pk_GS2C_ResetMineCostRes, {
	cost
	}).
-define(CMD_GS2C_MineBroadCast,18011).
-record(pk_GS2C_MineBroadCast, {
	name,
	itemDataId,
	count
	}).
-define(CMD_GS2C_MineBroadCastAdd,18012).
-record(pk_GS2C_MineBroadCastAdd, {
	mineBroadCast
	}).
-define(CMD_C2GC_MineBroadCastGet,18013).
-record(pk_C2GC_MineBroadCastGet, {
	}).
-define(CMD_GS2C_MineBroadCastGetRet,18014).
-record(pk_GS2C_MineBroadCastGetRet, {
	mineBroadCast
	}).

-define(CMD_escort_refresh,32001).
-record(pk_escort_refresh, {
	type
	}).
-define(CMD_escort_accept,32002).
-record(pk_escort_accept, {
	}).
-define(CMD_escort_drop,32003).
-record(pk_escort_drop, {
	}).
-define(CMD_escort_complete,32004).
-record(pk_escort_complete, {
	}).
-define(CMD_escort_robItem,32005).
-record(pk_escort_robItem, {
	playerId,
	name,
	level,
	career,
	sex,
	onLine
	}).
-define(CMD_escort_robList,32006).
-record(pk_escort_robList, {
	}).
-define(CMD_escort_robListRet,32007).
-record(pk_escort_robListRet, {
	roblist
	}).
-define(CMD_escort_stateRet,32008).
-record(pk_escort_stateRet, {
	playerId,
	beautity
	}).
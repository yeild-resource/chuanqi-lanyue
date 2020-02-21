
-define(CMD_C2GS_NpcBuy,21001).
-record(pk_C2GS_NpcBuy, {
	npcDataID,
	itemDataId,
	num
	}).
-define(CMD_C2GS_TradeRequire,21002).
-record(pk_C2GS_TradeRequire, {
	playerID
	}).
-define(CMD_GS2C_TradeRequireAgree,21003).
-record(pk_GS2C_TradeRequireAgree, {
	name,
	tradeID
	}).
-define(CMD_C2GS_TradeRespond,21004).
-record(pk_C2GS_TradeRespond, {
	tradeID,
	respond
	}).
-define(CMD_C2GS_TradeAddItem,21005).
-record(pk_C2GS_TradeAddItem, {
	tradeID,
	index,
	itemId,
	part
	}).
-define(CMD_TradeExtendProperity,21006).
-record(pk_TradeExtendProperity, {
	quality,
	propId,
	propValue
	}).
-define(CMD_GS2C_TradeItem,21007).
-record(pk_GS2C_TradeItem, {
	itemDataId,
	count,
	flag,
	stars,
	luck,
	advance_level,
	extendProps,
	fujia,
	insuranceTimes,
	expiretime,
	curse,
	curProcessValue
	}).
-define(CMD_GS2C_TradeAddItem_Ret,21008).
-record(pk_GS2C_TradeAddItem_Ret, {
	tradeID,
	part,
	tradeItem
	}).
-define(CMD_C2GS_TradeDelItem,21009).
-record(pk_C2GS_TradeDelItem, {
	tradeID,
	part
	}).
-define(CMD_C2GS_TradeChangeTreasure,21010).
-record(pk_C2GS_TradeChangeTreasure, {
	tradeID,
	treasure,
	coin
	}).
-define(CMD_C2GS_TradeLock,21011).
-record(pk_C2GS_TradeLock, {
	tradeID
	}).
-define(CMD_C2GS_TradeUnLock,21012).
-record(pk_C2GS_TradeUnLock, {
	tradeID
	}).
-define(CMD_C2GS_TradeEnsure,21013).
-record(pk_C2GS_TradeEnsure, {
	tradeID
	}).
-define(CMD_C2GS_TradeUnEnsure,21014).
-record(pk_C2GS_TradeUnEnsure, {
	tradeID
	}).
-define(CMD_GS2C_TradeInfoState,21015).
-record(pk_GS2C_TradeInfoState, {
	tradeID,
	playerID,
	tradeState
	}).
-define(CMD_C2GS_StoreBuy,21016).
-record(pk_C2GS_StoreBuy, {
	storeItemID,
	storeItemNum
	}).
-define(CMD_C2GS_VipBuy,21017).
-record(pk_C2GS_VipBuy, {
	vipBuyItemID,
	vipBuyItemNum
	}).
-define(CMD_C2GS_ExchangeItem,21018).
-record(pk_C2GS_ExchangeItem, {
	exchangeID,
	exchangeNum
	}).
-define(CMD_GS2C_ExchangeItemAck,21019).
-record(pk_GS2C_ExchangeItemAck, {
	errorCode
	}).
-define(CMD_exchangeCfg,21020).
-record(pk_exchangeCfg, {
	id,
	type,
	olditem,
	costcoin,
	costgold,
	newitem,
	ratio,
	broadcast,
	maxtimeperday,
	period,
	minlevel,
	describle,
	sendtoclient,
	explain
	}).
-define(CMD_GS2C_ExchangeCfgList,21021).
-record(pk_GS2C_ExchangeCfgList, {
	cfgList
	}).
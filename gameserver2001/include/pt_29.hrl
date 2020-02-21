
-define(CMD_C2GS_VipEveryDayGet,29001).
-record(pk_C2GS_VipEveryDayGet, {
	}).
-define(CMD_GS2C_VipEveryDayGetRet,29002).
-record(pk_GS2C_VipEveryDayGetRet, {
	canGet
	}).
-define(CMD_C2GS_GetVipEveryDay,29003).
-record(pk_C2GS_GetVipEveryDay, {
	}).
-define(CMD_C2GS_GetVipLevel,29004).
-record(pk_C2GS_GetVipLevel, {
	vipLevel
	}).
-define(CMD_C2GS_GiftGet,29005).
-record(pk_C2GS_GiftGet, {
	giftcode
	}).
-define(CMD_GS2C_GiftItem,29006).
-record(pk_GS2C_GiftItem, {
	itemDataId,
	num
	}).
-define(CMD_GS2C_GiftGetRet,29007).
-record(pk_GS2C_GiftGetRet, {
	giftItems
	}).
-define(CMD_C2GS_GetFirstPayAward,29008).
-record(pk_C2GS_GetFirstPayAward, {
	}).
-define(CMD_PayAward,29009).
-record(pk_PayAward, {
	money,
	times
	}).
-define(CMD_GS2C_EachPayAward,29010).
-record(pk_GS2C_EachPayAward, {
	eachPayList
	}).
-define(CMD_C2GS_EachPayGetAward,29011).
-record(pk_C2GS_EachPayGetAward, {
	money
	}).
-define(CMD_GS2C_TotalPayAward,29012).
-record(pk_GS2C_TotalPayAward, {
	totalPayList
	}).
-define(CMD_C2GS_TotalPayGetAward,29013).
-record(pk_C2GS_TotalPayGetAward, {
	money
	}).
-define(CMD_OneDayPay,29014).
-record(pk_OneDayPay, {
	day,
	money
	}).
-define(CMD_GS2C_PayBack,29015).
-record(pk_GS2C_PayBack, {
	day,
	totalPayList
	}).
-define(CMD_C2GS_PayBackGetAward,29016).
-record(pk_C2GS_PayBackGetAward, {
	}).
-define(CMD_GS2C_PlatformVipItem,29017).
-record(pk_GS2C_PlatformVipItem, {
	itemDataId,
	num,
	bindFlag
	}).
-define(CMD_C2GS_PlatformVip,29018).
-record(pk_C2GS_PlatformVip, {
	}).
-define(CMD_GS2C_PlatformVip,29019).
-record(pk_GS2C_PlatformVip, {
	first_role_items,
	day_login_items,
	first_pay_items
	}).
-define(CMD_C2GS_PlatformVipAward,29020).
-record(pk_C2GS_PlatformVipAward, {
	index
	}).
-define(CMD_GS2C_PlatformVipAward,29021).
-record(pk_GS2C_PlatformVipAward, {
	retCode
	}).
-define(CMD_C2GS_GetEveryDayPayAward,29022).
-record(pk_C2GS_GetEveryDayPayAward, {
	}).
-define(CMD_ZhaoCaiItem,29023).
-record(pk_ZhaoCaiItem, {
	itemId,
	num,
	bind
	}).
-define(CMD_ZhaoCaiTime,29024).
-record(pk_ZhaoCaiTime, {
	gold,
	itemList
	}).
-define(CMD_GS2C_ZhaoCai_Time,29025).
-record(pk_GS2C_ZhaoCai_Time, {
	beginTime,
	endtime,
	remainTime,
	awardList
	}).
-define(CMD_GS2C_ZhaoCai_Open,29026).
-record(pk_GS2C_ZhaoCai_Open, {
	flag
	}).
-define(CMD_C2GS_ZhaoCai_Info,29027).
-record(pk_C2GS_ZhaoCai_Info, {
	}).
-define(CMD_ZhaoCaiBuy,29028).
-record(pk_ZhaoCaiBuy, {
	day,
	num,
	isGet
	}).
-define(CMD_GS2C_ZhaoCai_Info_Ret,29029).
-record(pk_GS2C_ZhaoCai_Info_Ret, {
	awardList,
	buyList,
	buyNum
	}).
-define(CMD_C2GS_ZhaoCai_do,29030).
-record(pk_C2GS_ZhaoCai_do, {
	type,
	num
	}).
-define(CMD_C2GS_ZhaoCai_do_Ret,29031).
-record(pk_C2GS_ZhaoCai_do_Ret, {
	type,
	errCode
	}).

-define(CMD_ExtendProperity,16001).
-record(pk_ExtendProperity, {
	quality,
	propId,
	propValue,
	canTransfer
	}).
-define(CMD_changeValue,16002).
-record(pk_changeValue, {
	type,
	value,
	newAdvanceProperties
	}).
-define(CMD_GS2C_ItemChange,16003).
-record(pk_GS2C_ItemChange, {
	temp,
	index,
	change
	}).
-define(CMD_C2GS_BagGetItems,16004).
-record(pk_C2GS_BagGetItems, {
	}).
-define(CMD_GS2C_BagItem,16005).
-record(pk_GS2C_BagItem, {
	index,
	id,
	itemDataId,
	count,
	flag,
	stars,
	luck,
	advance_level,
	insuranceTimes,
	extendProps,
	fujia,
	expiretime,
	curse,
	curProcessValue
	}).
-define(CMD_GS2C_BagGetItems_Ret,16006).
-record(pk_GS2C_BagGetItems_Ret, {
	getBagItems
	}).
-define(CMD_GS2C_BagAddItem,16007).
-record(pk_GS2C_BagAddItem, {
	addItem
	}).
-define(CMD_GSWithC_BagDeleteItems,16008).
-record(pk_GSWithC_BagDeleteItems, {
	indexs
	}).
-define(CMD_C2GS_UseItem,16009).
-record(pk_C2GS_UseItem, {
	index,
	itemId,
	count,
	parameters
	}).
-define(CMD_SellItemInfo,16010).
-record(pk_SellItemInfo, {
	index,
	itemId
	}).
-define(CMD_C2GS_BagSellItems,16011).
-record(pk_C2GS_BagSellItems, {
	npcDataID,
	sellInfos
	}).
-define(CMD_GS2C_BagSellItems_Ret,16012).
-record(pk_GS2C_BagSellItems_Ret, {
	result
	}).
-define(CMD_GS2C_MoneyChanged,16013).
-record(pk_GS2C_MoneyChanged, {
	changeReason,
	moneyType,
	moneyValue
	}).
-define(CMD_GSWithC_ExchangeBagItem,16014).
-record(pk_GSWithC_ExchangeBagItem, {
	index1,
	index2
	}).
-define(CMD_GS2C_GemItem,16015).
-record(pk_GS2C_GemItem, {
	part,
	index,
	item
	}).
-define(CMD_GS2C_GemGet,16016).
-record(pk_GS2C_GemGet, {
	gemList
	}).
-define(CMD_C2GS_LookOverPlayerInfo,16017).
-record(pk_C2GS_LookOverPlayerInfo, {
	playerId
	}).
-define(CMD_Equipinfo,16018).
-record(pk_Equipinfo, {
	equipDataId,
	part,
	stars,
	luck,
	advance_level,
	flag,
	extendProps,
	fujia,
	expiretime,
	curse,
	insuranceTimes,
	curProcessValue
	}).
-define(CMD_GS2C_LookOverPlayerInfo,16019).
-record(pk_GS2C_LookOverPlayerInfo, {
	playerId,
	name,
	career,
	sex,
	level,
	fight,
	equipList,
	gemList,
	leagueName
	}).
-define(CMD_C2GS_Inlay_Ret,16020).
-record(pk_C2GS_Inlay_Ret, {
	type,
	result
	}).
-define(CMD_C2GS_BagSort,16021).
-record(pk_C2GS_BagSort, {
	}).
-define(CMD_GS2C_WareHouseGetItems_Ret,16022).
-record(pk_GS2C_WareHouseGetItems_Ret, {
	wareHouseVolume,
	wareHouseItems
	}).
-define(CMD_GS2C_WareHouseAddItem,16023).
-record(pk_GS2C_WareHouseAddItem, {
	index
	}).
-define(CMD_GS2C_WareHouseAddItemRet,16024).
-record(pk_GS2C_WareHouseAddItemRet, {
	addItem
	}).
-define(CMD_GSWithC_WareHouseDeleteItems,16025).
-record(pk_GSWithC_WareHouseDeleteItems, {
	indexs
	}).
-define(CMD_GSWithC_ExchangeWareHouseItem,16026).
-record(pk_GSWithC_ExchangeWareHouseItem, {
	index1,
	index2
	}).
-define(CMD_GS2C_ItemArrayForSpaceRingGetItems_Ret,16027).
-record(pk_GS2C_ItemArrayForSpaceRingGetItems_Ret, {
	place,
	spaceRingItems
	}).
-define(CMD_GS2C_ItemArrayForSpaceRingUnequipRet,16028).
-record(pk_GS2C_ItemArrayForSpaceRingUnequipRet, {
	place
	}).
-define(CMD_GS2C_ItemArrayForSpaceRingAddItem,16029).
-record(pk_GS2C_ItemArrayForSpaceRingAddItem, {
	place,
	index
	}).
-define(CMD_GS2C_ItemArrayForSpaceRingAddItemRet,16030).
-record(pk_GS2C_ItemArrayForSpaceRingAddItemRet, {
	place,
	addItem
	}).
-define(CMD_GSWithC_ItemArrayForSpaceRingDeleteItems,16031).
-record(pk_GSWithC_ItemArrayForSpaceRingDeleteItems, {
	place,
	indexs
	}).
-define(CMD_GSWithC_ExchangeItemArrayForSpaceRingItem,16032).
-record(pk_GSWithC_ExchangeItemArrayForSpaceRingItem, {
	place,
	index1,
	index2
	}).
-define(CMD_C2GS_MineWareHouseGet,16033).
-record(pk_C2GS_MineWareHouseGet, {
	index
	}).
-define(CMD_C2GS_MineWareHouseGetAll,16034).
-record(pk_C2GS_MineWareHouseGetAll, {
	}).
-define(CMD_GS2C_MineWareHouseDeleteItem,16035).
-record(pk_GS2C_MineWareHouseDeleteItem, {
	index
	}).
-define(CMD_C2GS_MineWareHouseGetItems,16036).
-record(pk_C2GS_MineWareHouseGetItems, {
	}).
-define(CMD_GS2C_MineWareHouseGetItemsRet,16037).
-record(pk_GS2C_MineWareHouseGetItemsRet, {
	mineItems
	}).
-define(CMD_C2GS_RicherGetTimes,16038).
-record(pk_C2GS_RicherGetTimes, {
	}).
-define(CMD_GS2C_RicherGetTimesRet,16039).
-record(pk_GS2C_RicherGetTimesRet, {
	times,
	money
	}).
-define(CMD_C2GS_Richer,16040).
-record(pk_C2GS_Richer, {
	type
	}).
-define(CMD_GS2C_RicherRet,16041).
-record(pk_GS2C_RicherRet, {
	times
	}).
-define(CMD_C2GS_LuckyUp,16042).
-record(pk_C2GS_LuckyUp, {
	is_money,
	place,
	index1
	}).
-define(CMD_C2GS_BagSplit,16043).
-record(pk_C2GS_BagSplit, {
	index,
	count
	}).
-define(CMD_GS2C_Mail_Info,16044).
-record(pk_GS2C_Mail_Info, {
	mailId,
	mailSendTime,
	mailReadState,
	mailType,
	mailTitle,
	mailContent,
	mailSendName,
	mailReceiveName,
	getBagItems,
	mailCoin,
	mailBindCoin,
	mailGold,
	mailBindGold
	}).
-define(CMD_GS2C_New_Mail_Info,16045).
-record(pk_GS2C_New_Mail_Info, {
	info
	}).
-define(CMD_GS2C_All_Mail_Info,16046).
-record(pk_GS2C_All_Mail_Info, {
	vec
	}).
-define(CMD_C2GS_Delete_Mail,16047).
-record(pk_C2GS_Delete_Mail, {
	mailId
	}).
-define(CMD_GS2C_Delete_Mail_Result,16048).
-record(pk_GS2C_Delete_Mail_Result, {
	mailId,
	retCode
	}).
-define(CMD_C2GS_Get_Attach,16049).
-record(pk_C2GS_Get_Attach, {
	mailId
	}).
-define(CMD_GS2C_Get_Attach_Result,16050).
-record(pk_GS2C_Get_Attach_Result, {
	mailId,
	retCode
	}).
-define(CMD_C2GS_Read_Mail,16051).
-record(pk_C2GS_Read_Mail, {
	mailId
	}).
-define(CMD_GS2C_Read_Mail_Result,16052).
-record(pk_GS2C_Read_Mail_Result, {
	mailId,
	retCode
	}).
-define(CMD_GS2C_Expire_Item,16053).
-record(pk_GS2C_Expire_Item, {
	id,
	timestamp
	}).
-define(CMD_C2GS_AddWareHouseVolume,16054).
-record(pk_C2GS_AddWareHouseVolume, {
	}).
-define(CMD_GS2C_AddWareHouseVolumeRet,16055).
-record(pk_GS2C_AddWareHouseVolumeRet, {
	count
	}).
-define(CMD_C2GS_InputShortCutItem,16056).
-record(pk_C2GS_InputShortCutItem, {
	index,
	itemDataId,
	itemId
	}).
-define(CMD_C2GS_WareHouseSort,16057).
-record(pk_C2GS_WareHouseSort, {
	}).
-define(CMD_C2GS_AddGeziNum,16058).
-record(pk_C2GS_AddGeziNum, {
	type,
	count
	}).
-define(CMD_C2GS_StGroundingItem,16059).
-record(pk_C2GS_StGroundingItem, {
	bagId,
	itemid,
	price,
	timeType
	}).
-define(CMD_C2GS_StTakeDown,16060).
-record(pk_C2GS_StTakeDown, {
	saleid
	}).
-define(CMD_GS2C_TakeDownResult,16061).
-record(pk_GS2C_TakeDownResult, {
	saleid,
	result
	}).
-define(CMD_C2GS_StFindItems,16062).
-record(pk_C2GS_StFindItems, {
	saletype
	}).
-define(CMD_ConSaleItem,16063).
-record(pk_ConSaleItem, {
	saleid,
	itemDataId,
	flag,
	stars,
	promoteLevel,
	luck,
	extendProps,
	fujia,
	curse,
	crit,
	insuranceTimes,
	processValue,
	expiretime,
	ownerid,
	sale_price,
	sale_count,
	leftTime
	}).
-define(CMD_GS2C_FindItemsResult,16064).
-record(pk_GS2C_FindItemsResult, {
	result,
	allCount,
	page,
	itemList
	}).
-define(CMD_C2GS_StTrunPage,16065).
-record(pk_C2GS_StTrunPage, {
	page
	}).
-define(CMD_C2GS_StBuyItem,16066).
-record(pk_C2GS_StBuyItem, {
	saleid
	}).
-define(CMD_C2GS_StClose,16067).
-record(pk_C2GS_StClose, {
	}).
-define(CMD_C2GS_StGetSelfSale,16068).
-record(pk_C2GS_StGetSelfSale, {
	}).
-define(CMD_GS2C_StSelfSale,16069).
-record(pk_GS2C_StSelfSale, {
	itemList
	}).
-define(CMD_GS2C_StTips,16070).
-record(pk_GS2C_StTips, {
	result
	}).
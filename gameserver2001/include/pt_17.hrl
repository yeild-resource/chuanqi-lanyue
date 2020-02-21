
-define(CMD_EquipExtendProperity,17001).
-record(pk_EquipExtendProperity, {
	quality,
	propId,
	propValue,
	canTransfer
	}).
-define(CMD_EquipItem,17002).
-record(pk_EquipItem, {
	id,
	part,
	equipDataId,
	stars,
	flag,
	luck,
	advance_level,
	fujia,
	extendProps,
	insuranceTimes,
	expiretime,
	curse,
	curProcessValue
	}).
-define(CMD_GS2C_EquipGetItem_Ret,17003).
-record(pk_GS2C_EquipGetItem_Ret, {
	equipItems
	}).
-define(CMD_C2GS_EquipItem,17004).
-record(pk_C2GS_EquipItem, {
	index,
	part
	}).
-define(CMD_C2GS_UnequipItem,17005).
-record(pk_C2GS_UnequipItem, {
	part
	}).
-define(CMD_GS2C_SyncEquipEvent,17006).
-record(pk_GS2C_SyncEquipEvent, {
	playerId,
	isEquip,
	part,
	index,
	equipDataId,
	stars,
	luck,
	advance_level,
	fujia,
	extendProps
	}).
-define(CMD_C2GS_StrengthenOnce,17007).
-record(pk_C2GS_StrengthenOnce, {
	type,
	equipId
	}).
-define(CMD_C2GS_Strengthen,17008).
-record(pk_C2GS_Strengthen, {
	type,
	equipId,
	itemIdList
	}).
-define(CMD_GS2C_Strengthen_Ret,17009).
-record(pk_GS2C_Strengthen_Ret, {
	type,
	result
	}).
-define(CMD_C2GS_Compose,17010).
-record(pk_C2GS_Compose, {
	itemDataId,
	num,
	type
	}).
-define(CMD_C2GS_Compose_Ret,17011).
-record(pk_C2GS_Compose_Ret, {
	result
	}).
-define(CMD_C2GS_Inlay,17012).
-record(pk_C2GS_Inlay, {
	itemId,
	part,
	index
	}).
-define(CMD_C2GS_UnInlay,17013).
-record(pk_C2GS_UnInlay, {
	part,
	index
	}).
-define(CMD_C2GS_Equip_Decompose,17014).
-record(pk_C2GS_Equip_Decompose, {
	index
	}).
-define(CMD_C2GS_StrengthenExchange,17015).
-record(pk_C2GS_StrengthenExchange, {
	srcEquipId,
	destEquipId
	}).
-define(CMD_C2GS_Equip_Insure,17016).
-record(pk_C2GS_Equip_Insure, {
	itemId,
	insureTimes
	}).
-define(CMD_GS2C_Equip_Insure_Ret,17017).
-record(pk_GS2C_Equip_Insure_Ret, {
	ret
	}).
-define(CMD_C2GS_Equip_Cancel_Insurance,17018).
-record(pk_C2GS_Equip_Cancel_Insurance, {
	itemId
	}).
-define(CMD_GS2C_Equip_Cancel_Insurance_Ret,17019).
-record(pk_GS2C_Equip_Cancel_Insurance_Ret, {
	errorCode
	}).
-define(CMD_GS2C_SyncWing,17020).
-record(pk_GS2C_SyncWing, {
	playerId,
	wingId
	}).
-define(CMD_C2GS_PrayDo,17021).
-record(pk_C2GS_PrayDo, {
	}).
-define(CMD_GS2C_PrayValue,17022).
-record(pk_GS2C_PrayValue, {
	prayValue
	}).
-define(CMD_C2GS_AutoWing,17023).
-record(pk_C2GS_AutoWing, {
	flag
	}).
-define(CMD_GS2C_Insure_Status,17024).
-record(pk_GS2C_Insure_Status, {
	status
	}).
-define(CMD_C2GS_Advance,17025).
-record(pk_C2GS_Advance, {
	itemId,
	times,
	locked,
	useTreasure
	}).
-define(CMD_AdvancePropertyIndexValue,17026).
-record(pk_AdvancePropertyIndexValue, {
	quality,
	index,
	value
	}).
-define(CMD_OneAdvanceProperty,17027).
-record(pk_OneAdvanceProperty, {
	advanceProperties
	}).
-define(CMD_GS2C_AdvaceRet,17028).
-record(pk_GS2C_AdvaceRet, {
	errorCode,
	times,
	advanceProperties
	}).
-define(CMD_C2GS_Advance_Select_One,17029).
-record(pk_C2GS_Advance_Select_One, {
	index
	}).
-define(CMD_GS2C_Advance_Select_One_Ret,17030).
-record(pk_GS2C_Advance_Select_One_Ret, {
	errorCode
	}).
-define(CMD_C2GS_ReAdvance,17031).
-record(pk_C2GS_ReAdvance, {
	advanceType,
	item_uid
	}).
-define(CMD_C2GS_Inherit,17032).
-record(pk_C2GS_Inherit, {
	inheritorIndex,
	departedIndex
	}).
-define(CMD_GS2C_AdvanceError,17033).
-record(pk_GS2C_AdvanceError, {
	error_type,
	is_ok
	}).
-define(CMD_minorEquip,17034).
-record(pk_minorEquip, {
	index,
	itemDataId,
	itemId
	}).
-define(CMD_C2GS_EquipUpgrade,17035).
-record(pk_C2GS_EquipUpgrade, {
	mainItemDataId,
	mainItemId,
	minorVec
	}).
-define(CMD_GS2C_EquipUpgrade,17036).
-record(pk_GS2C_EquipUpgrade, {
	retCode
	}).
-define(CMD_C2GS_EquipMedalUpgrad_Req,17037).
-record(pk_C2GS_EquipMedalUpgrad_Req, {
	}).
-define(CMD_GS2C_EquipMedalUpgrade_Ret,17038).
-record(pk_GS2C_EquipMedalUpgrade_Ret, {
	errorCode
	}).
-define(CMD_C2GS_EquipRandomPropertiesTransfer_Req,17039).
-record(pk_C2GS_EquipRandomPropertiesTransfer_Req, {
	sourceEquipmentId,
	attributeIndexList,
	targetEquipmentId
	}).
-define(CMD_GS2C_EquipRandomPropertiesTransfer_Ret,17040).
-record(pk_GS2C_EquipRandomPropertiesTransfer_Ret, {
	errorCode
	}).
-define(CMD_C2GS_EquipPromote_Req,17041).
-record(pk_C2GS_EquipPromote_Req, {
	itemId
	}).
-define(CMD_GS2C_EquipPromote_Ret,17042).
-record(pk_GS2C_EquipPromote_Ret, {
	errorCode,
	newPromoteLevel
	}).
-define(CMD_C2GS_EquipmentCompose_Req,17043).
-record(pk_C2GS_EquipmentCompose_Req, {
	targetEquipmentDataId
	}).
-define(CMD_GS2C_EquipmentCompose_Ret,17044).
-record(pk_GS2C_EquipmentCompose_Ret, {
	errorCode
	}).
-define(CMD_C2GS_Open_Hole,17045).
-record(pk_C2GS_Open_Hole, {
	part
	}).
-define(CMD_GS2C_Open_Hole_Ret,17046).
-record(pk_GS2C_Open_Hole_Ret, {
	errorCode,
	part,
	holeNum
	}).
-define(CMD_GS2C_Get_All_Open_Hole_Ret,17047).
-record(pk_GS2C_Get_All_Open_Hole_Ret, {
	allPartHoleNum
	}).
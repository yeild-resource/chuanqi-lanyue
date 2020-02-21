
-define(CMD_GS2C_KickOut,12001).
-record(pk_GS2C_KickOut, {
	type,
	desc
	}).
-define(CMD_GS2C_CdUseItem,12002).
-record(pk_GS2C_CdUseItem, {
	id,
	time,
	totalTime
	}).
-define(CMD_PlayerBuffInfo,12003).
-record(pk_PlayerBuffInfo, {
	buffid,
	casterId,
	duration
	}).
-define(CMD_PlayerSkillInfo,12004).
-record(pk_PlayerSkillInfo, {
	skillId,
	cdtime
	}).
-define(CMD_GS2U_AddSkill,12005).
-record(pk_GS2U_AddSkill, {
	skillId,
	cdtime
	}).
-define(CMD_GS2U_RemoveSkill,12006).
-record(pk_GS2U_RemoveSkill, {
	skillId
	}).
-define(CMD_GS2C_ReplaceSkill,12007).
-record(pk_GS2C_ReplaceSkill, {
	oldSkillId,
	newSkillId
	}).
-define(CMD_GS2C_PlayerProperty,12008).
-record(pk_GS2C_PlayerProperty, {
	playerID,
	name,
	level,
	speed,
	career,
	sex,
	exp,
	coin,
	bindCoin,
	treasure,
	bindTreasure,
	reputation,
	spirit,
	holy,
	fight,
	cdTimeUseItem,
	bagGridNum,
	vipLevel,
	totalTreasure,
	titleId,
	platformVip,
	buff_list,
	skill_list,
	state,
	pk,
	pkState,
	hp,
	mp,
	hp_total,
	mp_total,
	luck,
	curse,
	phy_attack_top,
	phy_attack_bottom,
	phy_defence_top,
	phy_defence_bottom,
	magic_attack_top,
	magic_attack_bottom,
	magic_defence_top,
	magic_defence_bottom,
	dow_attack_top,
	dow_attack_bottom,
	dodge,
	hit,
	crit,
	createTime,
	aspeed,
	fury,
	furyValue
	}).
-define(CMD_GS2C_PlayerMapFightProperty,12009).
-record(pk_GS2C_PlayerMapFightProperty, {
	state,
	level,
	pk,
	pkState,
	hp,
	mp,
	hp_total,
	mp_total,
	luck,
	curse,
	phy_attack_top,
	phy_attack_bottom,
	phy_defence_top,
	phy_defence_bottom,
	magic_attack_top,
	magic_attack_bottom,
	magic_defence_top,
	magic_defence_bottom,
	dow_attack_top,
	dow_attack_bottom,
	dodge,
	hit,
	crit,
	aspeed
	}).
-define(CMD_GS2C_PlayerSingleProperty,12010).
-record(pk_GS2C_PlayerSingleProperty, {
	type,
	value
	}).
-define(CMD_GS2C_PlayerSinglePropertySync,12011).
-record(pk_GS2C_PlayerSinglePropertySync, {
	playerID,
	type,
	value
	}).
-define(CMD_GS2C_PlayerLeaguePropertySync,12012).
-record(pk_GS2C_PlayerLeaguePropertySync, {
	playerID,
	leagueName
	}).
-define(CMD_playerSingleProperty,12013).
-record(pk_playerSingleProperty, {
	type,
	value
	}).
-define(CMD_GS2C_PlayerMultPropertySync,12014).
-record(pk_GS2C_PlayerMultPropertySync, {
	playerId,
	vec
	}).
-define(CMD_GS2U_BufferAttach,12015).
-record(pk_GS2U_BufferAttach, {
	buffid,
	duration
	}).
-define(CMD_GS2U_BufferRemove,12016).
-record(pk_GS2U_BufferRemove, {
	buffid
	}).
-define(CMD_RoleEffectInfo,12017).
-record(pk_RoleEffectInfo, {
	casterid,
	targetid,
	effectType,
	data
	}).
-define(CMD_GS2U_RoleEffect,12018).
-record(pk_GS2U_RoleEffect, {
	effects
	}).
-define(CMD_C2GS_UseSkill,12019).
-record(pk_C2GS_UseSkill, {
	skillId,
	targetId
	}).
-define(CMD_GS2U_UseSkill,12020).
-record(pk_GS2U_UseSkill, {
	casterId,
	skillId,
	targetId
	}).
-define(CMD_GS2U_StopSkill,12021).
-record(pk_GS2U_StopSkill, {
	casterId,
	skillId,
	targetId
	}).
-define(CMD_GS2U_SkillEffect,12022).
-record(pk_GS2U_SkillEffect, {
	casterId,
	skillId,
	targetId,
	effects
	}).
-define(CMD_C2GS_ChangePkState,12023).
-record(pk_C2GS_ChangePkState, {
	playerID,
	pkState
	}).
-define(CMD_C2GS_ReturnToSelectRoleDlg_Req,12024).
-record(pk_C2GS_ReturnToSelectRoleDlg_Req, {
	}).
-define(CMD_C2GS_RecoverLife_Req,12025).
-record(pk_C2GS_RecoverLife_Req, {
	recoverType
	}).
-define(CMD_GS2C_RecoverLife_Ret,12026).
-record(pk_GS2C_RecoverLife_Ret, {
	retCode
	}).
-define(CMD_GS2C_NextNormalAttack_Is_GSJF,12027).
-record(pk_GS2C_NextNormalAttack_Is_GSJF, {
	reserve,
	skillDataId,
	playerID
	}).
-define(CMD_C2GS_PetUseSkill,12028).
-record(pk_C2GS_PetUseSkill, {
	skillId,
	targetId
	}).
-define(CMD_C2GS_UseSavageCutSkill,12029).
-record(pk_C2GS_UseSavageCutSkill, {
	skillId,
	targetId,
	targetRealX,
	targetRealY,
	dirx,
	diry
	}).
-define(CMD_C2GS_BindAccount,12030).
-record(pk_C2GS_BindAccount, {
	devimei,
	account,
	platformID,
	password,
	flage
	}).
-define(CMD_GS2C_BindAccountAck,12031).
-record(pk_GS2C_BindAccountAck, {
	errorCode,
	flage
	}).
-define(CMD_C2GS_UpgradeSkill,12032).
-record(pk_C2GS_UpgradeSkill, {
	skillId
	}).
-define(CMD_GS2C_UpgradeSkill,12033).
-record(pk_GS2C_UpgradeSkill, {
	skillId,
	preSkillId
	}).
-define(CMD_GS2C_OfflineExp,12034).
-record(pk_GS2C_OfflineExp, {
	offlineExp,
	offlineTime
	}).
-define(CMD_C2GS_GetOfflineExp,12035).
-record(pk_C2GS_GetOfflineExp, {
	type
	}).
-define(CMD_GS2C_killerName,12036).
-record(pk_GS2C_killerName, {
	killname
	}).
-define(CMD_GS2C_GetOfflineExp,12037).
-record(pk_GS2C_GetOfflineExp, {
	retCode
	}).
-define(CMD_limitBuyData,12038).
-record(pk_limitBuyData, {
	shopid,
	itemId,
	price_type,
	price,
	sellprice,
	flag,
	bind,
	allQuota,
	readyAllQuota,
	oneQuota,
	readyOneQuota
	}).
-define(CMD_GS2C_limitBuyState,12039).
-record(pk_GS2C_limitBuyState, {
	ret,
	datalist,
	lefttime
	}).
-define(CMD_C2GS_limitBuyList,12040).
-record(pk_C2GS_limitBuyList, {
	}).
-define(CMD_GS2C_limitBuyList,12041).
-record(pk_GS2C_limitBuyList, {
	datalist,
	lefttime
	}).
-define(CMD_C2GS_limitBuyItem,12042).
-record(pk_C2GS_limitBuyItem, {
	shopid,
	count
	}).
-define(CMD_GS2C_limitBuyResult,12043).
-record(pk_GS2C_limitBuyResult, {
	result
	}).
-define(CMD_GS2C_PayRelated_Active,12044).
-record(pk_GS2C_PayRelated_Active, {
	begintime,
	endtime,
	lefttime,
	rebaterideInt,
	flag
	}).
-define(CMD_C2GS_getGrowGift,12045).
-record(pk_C2GS_getGrowGift, {
	}).
-define(CMD_GS2C_returnGrowGift,12046).
-record(pk_GS2C_returnGrowGift, {
	result
	}).
-define(CMD_Masteries,12047).
-record(pk_Masteries, {
	masteriesId,
	clicks
	}).
-define(CMD_C2GS_MasteriesInfo_Req,12048).
-record(pk_C2GS_MasteriesInfo_Req, {
	}).
-define(CMD_GS2C_MasteriesInfo_Ret,12049).
-record(pk_GS2C_MasteriesInfo_Ret, {
	masteriesPoints,
	masteries
	}).
-define(CMD_C2GS_clickMasteries_Req,12050).
-record(pk_C2GS_clickMasteries_Req, {
	masteriesId
	}).
-define(CMD_GS2C_clickMasteries_Ret,12051).
-record(pk_GS2C_clickMasteries_Ret, {
	errorCode
	}).
-define(CMD_C2GS_resetMasteries_Req,12052).
-record(pk_C2GS_resetMasteries_Req, {
	}).
-define(CMD_GS2C_resetMasteries_Ret,12053).
-record(pk_GS2C_resetMasteries_Ret, {
	errorCode
	}).
-define(CMD_C2GS_itemCompound_Req,12054).
-record(pk_C2GS_itemCompound_Req, {
	id
	}).
-define(CMD_GS2C_itemCompound_Ret,12055).
-record(pk_GS2C_itemCompound_Ret, {
	errorCode
	}).
-define(CMD_C2GS_MysteryShopBuyItem,12056).
-record(pk_C2GS_MysteryShopBuyItem, {
	itemId,
	num
	}).
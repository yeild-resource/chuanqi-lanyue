
-define(CMD_ShortcutInfo,20001).
-record(pk_ShortcutInfo, {
	index,
	type,
	id
	}).
-define(CMD_GSWithC_Shortcuts,20002).
-record(pk_GSWithC_Shortcuts, {
	shortcutInfos
	}).
-define(CMD_C2GS_Pickup_Item,20003).
-record(pk_C2GS_Pickup_Item, {
	id
	}).
-define(CMD_GS2C_Preference_Set_Info,20004).
-record(pk_GS2C_Preference_Set_Info, {
	teamSet
	}).
-define(CMD_VariantData,20005).
-record(pk_VariantData, {
	index,
	value
	}).
-define(CMD_GS2C_VariantDataSet,20006).
-record(pk_GS2C_VariantDataSet, {
	variant_type,
	info_list
	}).
-define(CMD_C2GS_GuideHand,20007).
-record(pk_C2GS_GuideHand, {
	status
	}).
-define(CMD_ArenaPlayerEquipinfo,20008).
-record(pk_ArenaPlayerEquipinfo, {
	equipDataId,
	part,
	stars,
	luck
	}).
-define(CMD_ArenaPlayerInfo,20009).
-record(pk_ArenaPlayerInfo, {
	playerId,
	name,
	sex,
	career,
	level,
	fight,
	rank,
	type,
	model,
	equipList
	}).
-define(CMD_ArenaMsgInfo,20010).
-record(pk_ArenaMsgInfo, {
	name,
	flag,
	rank,
	time
	}).
-define(CMD_C2GS_EnterArena_Req,20011).
-record(pk_C2GS_EnterArena_Req, {
	}).
-define(CMD_GS2C_EnterArena_Ret,20012).
-record(pk_GS2C_EnterArena_Ret, {
	ret
	}).
-define(CMD_GS2C_ArenaInfo,20013).
-record(pk_GS2C_ArenaInfo, {
	maxRank,
	curRank,
	fight,
	awardId,
	arenaPlayerList,
	arenaMsgList
	}).
-define(CMD_C2GS_StartChallenge_Req,20014).
-record(pk_C2GS_StartChallenge_Req, {
	type,
	playerId
	}).
-define(CMD_GS2C_StartChallenge_Ret,20015).
-record(pk_GS2C_StartChallenge_Ret, {
	ret
	}).
-define(CMD_C2GS_Start_Count_down_Req,20016).
-record(pk_C2GS_Start_Count_down_Req, {
	}).
-define(CMD_C2GS_Arena_Award_Req,20017).
-record(pk_C2GS_Arena_Award_Req, {
	}).
-define(CMD_GS2C_Arena_Award_Ret,20018).
-record(pk_GS2C_Arena_Award_Ret, {
	ret
	}).
-define(CMD_C2GS_ArenaClearLogs_Req,20019).
-record(pk_C2GS_ArenaClearLogs_Req, {
	}).
-define(CMD_gs2c_ArenaClearLogs_Ret,20020).
-record(pk_gs2c_ArenaClearLogs_Ret, {
	errorCode
	}).
-define(CMD_DefenseMonsterInfo,20021).
-record(pk_DefenseMonsterInfo, {
	id,
	dataId,
	isDead
	}).
-define(CMD_GS2C_Update_TowerDefenseMonster,20022).
-record(pk_GS2C_Update_TowerDefenseMonster, {
	defenseMonsterInfos
	}).
-define(CMD_GS2C_MonsterRefresh_Time,20023).
-record(pk_GS2C_MonsterRefresh_Time, {
	waveIndex,
	delayMs
	}).
-define(CMD_C2GS_Upgrade_TowerDefenseMonster,20024).
-record(pk_C2GS_Upgrade_TowerDefenseMonster, {
	id,
	dataId
	}).
-define(CMD_C2GS_RecoverLife_TowerDefenseMonster,20025).
-record(pk_C2GS_RecoverLife_TowerDefenseMonster, {
	id,
	dataId
	}).
-define(CMD_GS2C_TowerDefense_Update_AwardInfo,20026).
-record(pk_GS2C_TowerDefense_Update_AwardInfo, {
	spiritNum,
	awardExp,
	awardCoin
	}).
-define(CMD_GS2C_TowerDefenseCopy_Result,20027).
-record(pk_GS2C_TowerDefenseCopy_Result, {
	isSuccess
	}).
-define(CMD_GS2C_ArenaCopy_Result,20028).
-record(pk_GS2C_ArenaCopy_Result, {
	isSuccess
	}).
-define(CMD_Login_Notice,20029).
-record(pk_Login_Notice, {
	title,
	content,
	date,
	signature
	}).
-define(CMD_GS2C_Login_Notice,20030).
-record(pk_GS2C_Login_Notice, {
	login_Notice_lists
	}).
-define(CMD_C2GS_HeartBeat,20031).
-record(pk_C2GS_HeartBeat, {
	serverTime
	}).
-define(CMD_Pay_Info,20032).
-record(pk_Pay_Info, {
	id,
	gameMoney,
	ucMoney,
	state,
	isDouble
	}).
-define(CMD_GS2C_Pay_Info,20033).
-record(pk_GS2C_Pay_Info, {
	pay_Info_lists
	}).
-define(CMD_C2GS_Player_Get_Sign_In_Info,20034).
-record(pk_C2GS_Player_Get_Sign_In_Info, {
	}).
-define(CMD_GS2C_Player_Sign_In_Info,20035).
-record(pk_GS2C_Player_Sign_In_Info, {
	isAlready
	}).
-define(CMD_C2GS_Player_Sign_In,20036).
-record(pk_C2GS_Player_Sign_In, {
	}).
-define(CMD_GS2C_Player_Sign_In_Result,20037).
-record(pk_GS2C_Player_Sign_In_Result, {
	days,
	retCode
	}).
-define(CMD_C2GS_Player_Again_Sign_In,20038).
-record(pk_C2GS_Player_Again_Sign_In, {
	days
	}).
-define(CMD_GS2C_Player_Again_Sign_In_Result,20039).
-record(pk_GS2C_Player_Again_Sign_In_Result, {
	days,
	retCode
	}).
-define(CMD_C2GS_Player_Get_Award,20040).
-record(pk_C2GS_Player_Get_Award, {
	id
	}).
-define(CMD_GS2C_Player_Get_Award_Result,20041).
-record(pk_GS2C_Player_Get_Award_Result, {
	retCode
	}).
-define(CMD_C2GS_Sign_In_One_Key_Get_Award,20042).
-record(pk_C2GS_Sign_In_One_Key_Get_Award, {
	}).
-define(CMD_C2GS_System_Set_Request,20043).
-record(pk_C2GS_System_Set_Request, {
	type,
	flag
	}).
-define(CMD_GS2C_System_Set_Request_Result,20044).
-record(pk_GS2C_System_Set_Request_Result, {
	retCode
	}).
-define(CMD_Sha_Cheng_War_Battle,20045).
-record(pk_Sha_Cheng_War_Battle, {
	level,
	leagueIdA,
	leagueNameA,
	leagueIdB,
	leagueNameB
	}).
-define(CMD_GS2C_Sha_Cheng_War_Battle_List,20046).
-record(pk_GS2C_Sha_Cheng_War_Battle_List, {
	ownerName,
	vec
	}).
-define(CMD_C2GS_Sha_Cheng_War_Get_Award,20047).
-record(pk_C2GS_Sha_Cheng_War_Get_Award, {
	}).
-define(CMD_GS2C_Sha_Cheng_War_Get_Award,20048).
-record(pk_GS2C_Sha_Cheng_War_Get_Award, {
	retCode
	}).
-define(CMD_GS2C_Sha_Cheng_War_Start_Battle,20049).
-record(pk_GS2C_Sha_Cheng_War_Start_Battle, {
	}).
-define(CMD_C2GS_Sha_Cheng_War_Start_Battle,20050).
-record(pk_C2GS_Sha_Cheng_War_Start_Battle, {
	}).
-define(CMD_GS2C_Sha_Cheng_War_Start_Battle_Enter_Result,20051).
-record(pk_GS2C_Sha_Cheng_War_Start_Battle_Enter_Result, {
	retCode
	}).
-define(CMD_C2GS_RegistUser_Request,20052).
-record(pk_C2GS_RegistUser_Request, {
	userName,
	userPwd
	}).
-define(CMD_GS2C_RegistUser_Ret,20053).
-record(pk_GS2C_RegistUser_Ret, {
	retCode,
	userName,
	userPwd
	}).
-define(CMD_C2GS_Pay_Rebate_Request,20054).
-record(pk_C2GS_Pay_Rebate_Request, {
	}).
-define(CMD_GS2C_Pay_Rebate_Ret,20055).
-record(pk_GS2C_Pay_Rebate_Ret, {
	retCode,
	payCount,
	rebateCount,
	leftTime
	}).
-define(CMD_C2GS_Confirm_Rebate_Request,20056).
-record(pk_C2GS_Confirm_Rebate_Request, {
	}).
-define(CMD_GS2C_Confirm_Rebate_Ret,20057).
-record(pk_GS2C_Confirm_Rebate_Ret, {
	retCode
	}).
-define(CMD_GS2C_Sha_Cheng_War_Win,20058).
-record(pk_GS2C_Sha_Cheng_War_Win, {
	}).
-define(CMD_C2GS_shopPackLimitInfo,20059).
-record(pk_C2GS_shopPackLimitInfo, {
	}).
-define(CMD_GS2C_shopPackLimitInfoRet,20060).
-record(pk_GS2C_shopPackLimitInfoRet, {
	packId,
	remainTime,
	serverCount,
	userCount,
	serverLimit,
	userLimit,
	startTime,
	stopTime,
	itemId,
	price,
	name,
	introduction,
	content,
	flag
	}).
-define(CMD_C2GS_shopPackLimitGet,20061).
-record(pk_C2GS_shopPackLimitGet, {
	packId
	}).
-define(CMD_C2GS_shopPackExchangeGoldGet,20062).
-record(pk_C2GS_shopPackExchangeGoldGet, {
	gold
	}).
-define(CMD_C2GS_shopPackExchangeItemGet,20063).
-record(pk_C2GS_shopPackExchangeItemGet, {
	itemId
	}).
-define(CMD_GS2C_HeartBeat,20064).
-record(pk_GS2C_HeartBeat, {
	}).
-define(CMD_C2GS_requestEnterHuangChengMap,20065).
-record(pk_C2GS_requestEnterHuangChengMap, {
	}).
-define(CMD_GS2C_requestEnterHuangChengMap,20066).
-record(pk_GS2C_requestEnterHuangChengMap, {
	retCode
	}).
-define(CMD_GS2C_broadcastIntegral,20067).
-record(pk_GS2C_broadcastIntegral, {
	myLeaderIntegral,
	firstLeaderName,
	firstLeaderIntegral,
	secondLeaderName,
	secondLeaderIntegral,
	thirdLeaderName,
	thirdLeaderIntegral
	}).
-define(CMD_C2GS_Huang_Cheng_Zheng_Ba_Get_Award,20068).
-record(pk_C2GS_Huang_Cheng_Zheng_Ba_Get_Award, {
	}).
-define(CMD_GS2C_Huang_Cheng_Zheng_Ba_Get_Award,20069).
-record(pk_GS2C_Huang_Cheng_Zheng_Ba_Get_Award, {
	retCode
	}).
-define(CMD_C2GS_requestShopItem,20070).
-record(pk_C2GS_requestShopItem, {
	}).
-define(CMD_shopItem,20071).
-record(pk_shopItem, {
	shopID,
	itemID,
	item_type,
	price_type,
	sell_price,
	flag,
	show_order,
	show_price,
	bind
	}).
-define(CMD_GS2C_shopItemList,20072).
-record(pk_GS2C_shopItemList, {
	itemList
	}).
-define(CMD_C2GS_App_Pay_Request,20073).
-record(pk_C2GS_App_Pay_Request, {
	amount
	}).
-define(CMD_GS2C_App_Pay_Ret,20074).
-record(pk_GS2C_App_Pay_Ret, {
	retCode
	}).
-define(CMD_GS2C_ServerID,20075).
-record(pk_GS2C_ServerID, {
	serverID
	}).
-define(CMD_GS2C_ServerTime,20076).
-record(pk_GS2C_ServerTime, {
	serverTime,
	curDay
	}).
-define(CMD_gemItem,20077).
-record(pk_gemItem, {
	indexID,
	itemID
	}).
-define(CMD_C2GS_Gem_Smelt,20078).
-record(pk_C2GS_Gem_Smelt, {
	gemList
	}).
-define(CMD_GS2C_Gem_Smelt,20079).
-record(pk_GS2C_Gem_Smelt, {
	retCode
	}).
-define(CMD_C2GS_Gem_Exchange,20080).
-record(pk_C2GS_Gem_Exchange, {
	indexID,
	itemCount
	}).
-define(CMD_GS2C_Gem_Exchange,20081).
-record(pk_GS2C_Gem_Exchange, {
	retCode
	}).
-define(CMD_C2GS_SetPassword,20082).
-record(pk_C2GS_SetPassword, {
	oldPassword,
	newPassword
	}).
-define(CMD_GS2C_SetPasswordAck,20083).
-record(pk_GS2C_SetPasswordAck, {
	errorcode
	}).
-define(CMD_C2GS_InputPassword,20084).
-record(pk_C2GS_InputPassword, {
	password
	}).
-define(CMD_GS2C_InputPasswordAck,20085).
-record(pk_GS2C_InputPasswordAck, {
	errorcode
	}).
-define(CMD_C2GS_Seven_Star_List,20086).
-record(pk_C2GS_Seven_Star_List, {
	}).
-define(CMD_GS2C_Seven_Star_Info,20087).
-record(pk_GS2C_Seven_Star_Info, {
	type,
	lv
	}).
-define(CMD_C2GS_Seven_Star_Charge_Req,20088).
-record(pk_C2GS_Seven_Star_Charge_Req, {
	type
	}).
-define(CMD_GS2C_Seven_Star_Charge_Ret,20089).
-record(pk_GS2C_Seven_Star_Charge_Ret, {
	result,
	crit
	}).
-define(CMD_C2GS_Seven_Star_Upgrade,20090).
-record(pk_C2GS_Seven_Star_Upgrade, {
	type
	}).
-define(CMD_GS2C_Seven_Star_Reiki,20091).
-record(pk_GS2C_Seven_Star_Reiki, {
	playerId,
	reiki,
	gold,
	coin
	}).
-define(CMD_GS2C_Pay_Related_All,20092).
-record(pk_GS2C_Pay_Related_All, {
	timeBegin,
	timeEnd,
	timeRemain
	}).
-define(CMD_GS2C_Pay_Related_Info,20093).
-record(pk_GS2C_Pay_Related_Info, {
	type,
	lv,
	gold,
	num
	}).
-define(CMD_C2GS_Pay_Related_Get,20094).
-record(pk_C2GS_Pay_Related_Get, {
	type,
	lv,
	gold
	}).
-define(CMD_GS2C_Pay_Related_Gold,20095).
-record(pk_GS2C_Pay_Related_Gold, {
	type,
	gold
	}).
-define(CMD_C2GS_Valentine_Get,20096).
-record(pk_C2GS_Valentine_Get, {
	}).
-define(CMD_GS2C_Valentine_Ret,20097).
-record(pk_GS2C_Valentine_Ret, {
	result
	}).
-define(CMD_C2GS_Valentine_Req,20098).
-record(pk_C2GS_Valentine_Req, {
	}).
-define(CMD_GS2C_Valentine_Status,20099).
-record(pk_GS2C_Valentine_Status, {
	status,
	remainTimes
	}).
-define(CMD_GS2C_Valentine_Open,20100).
-record(pk_GS2C_Valentine_Open, {
	festivalid,
	status
	}).
-define(CMD_C2GS_Valentine_Compose,20101).
-record(pk_C2GS_Valentine_Compose, {
	type
	}).
-define(CMD_GS2C_shopPackLimitServerCount,20102).
-record(pk_GS2C_shopPackLimitServerCount, {
	packId,
	serverCount
	}).
-define(CMD_prItemInfo,20103).
-record(pk_prItemInfo, {
	itemId,
	itemNum,
	flag
	}).
-define(CMD_prInfo,20104).
-record(pk_prInfo, {
	id,
	gold,
	items
	}).
-define(CMD_C2GS_Pay_Related_Config_Request,20105).
-record(pk_C2GS_Pay_Related_Config_Request, {
	}).
-define(CMD_GS2C_Pay_Related_Config_Ret,20106).
-record(pk_GS2C_Pay_Related_Config_Ret, {
	type,
	status,
	perData
	}).
-define(CMD_GS2C_Everyday_Info,20107).
-record(pk_GS2C_Everyday_Info, {
	id,
	cNum
	}).
-define(CMD_C2GS_Everyday_Get,20108).
-record(pk_C2GS_Everyday_Get, {
	lv
	}).
-define(CMD_GS2C_Everyday_Status,20109).
-record(pk_GS2C_Everyday_Status, {
	lv,
	status
	}).
-define(CMD_GS2C_Everyday_Reset,20110).
-record(pk_GS2C_Everyday_Reset, {
	}).
-define(CMD_GS2C_Everyday_Score,20111).
-record(pk_GS2C_Everyday_Score, {
	score
	}).
-define(CMD_C2GS_GainPackageGift,20112).
-record(pk_C2GS_GainPackageGift, {
	unused
	}).
-define(CMD_GS2C_ForView,20113).
-record(pk_GS2C_ForView, {
	forView
	}).
-define(CMD_C2GS_SaleItemReq,20114).
-record(pk_C2GS_SaleItemReq, {
	pageid
	}).
-define(CMD_SaleItem,20115).
-record(pk_SaleItem, {
	onlyid,
	itemid,
	strength,
	oil,
	count,
	price,
	time,
	status
	}).
-define(CMD_GS2C_SaleItemRes,20116).
-record(pk_GS2C_SaleItemRes, {
	items
	}).
-define(CMD_C2GS_AH_Auction,20117).
-record(pk_C2GS_AH_Auction, {
	index,
	price
	}).
-define(CMD_C2GS_AH_GetMyItem,20118).
-record(pk_C2GS_AH_GetMyItem, {
	}).
-define(CMD_C2GS_AH_Buy,20119).
-record(pk_C2GS_AH_Buy, {
	onlyid
	}).
-define(CMD_GS2C_AH_Status,20120).
-record(pk_GS2C_AH_Status, {
	status
	}).
-define(CMD_C2GS_AH_MyItem,20121).
-record(pk_C2GS_AH_MyItem, {
	onlyid,
	status
	}).
-define(CMD_C2GS_AH_ClearItem,20122).
-record(pk_C2GS_AH_ClearItem, {
	}).
-define(CMD_C2GS_AH_RoleItemCount,20123).
-record(pk_C2GS_AH_RoleItemCount, {
	}).
-define(CMD_GS2C_AH_GetItemCount,20124).
-record(pk_GS2C_AH_GetItemCount, {
	count
	}).
-define(CMD_C2GS_AH_GetLog,20125).
-record(pk_C2GS_AH_GetLog, {
	}).
-define(CMD_AH_Log,20126).
-record(pk_AH_Log, {
	time,
	itemid,
	count,
	price
	}).
-define(CMD_GS2C_AH_Log,20127).
-record(pk_GS2C_AH_Log, {
	log
	}).
-define(CMD_C2GS_Cross_Signup_Req,20128).
-record(pk_C2GS_Cross_Signup_Req, {
	}).
-define(CMD_GS2C_Cross_Signup_Ret,20129).
-record(pk_GS2C_Cross_Signup_Ret, {
	result,
	sign
	}).
-define(CMD_GS2C_Cross_Player_Score,20130).
-record(pk_GS2C_Cross_Player_Score, {
	score
	}).
-define(CMD_GS2C_Cross_Zone_Score,20131).
-record(pk_GS2C_Cross_Zone_Score, {
	side,
	score
	}).
-define(CMD_GS2C_Cross_Settle,20132).
-record(pk_GS2C_Cross_Settle, {
	result,
	exp
	}).
-define(CMD_CrossItem,20133).
-record(pk_CrossItem, {
	servID
	}).
-define(CMD_C2GS_Cross_Opinfo_Req,20134).
-record(pk_C2GS_Cross_Opinfo_Req, {
	}).
-define(CMD_GS2C_Cross_Opinfo_Ret,20135).
-record(pk_GS2C_Cross_Opinfo_Ret, {
	servs
	}).
-define(CMD_C2GS_UpdateProcess,20136).
-record(pk_C2GS_UpdateProcess, {
	content
	}).
-define(CMD_C2GS_EnterEquipEnvoyCopy,20137).
-record(pk_C2GS_EnterEquipEnvoyCopy, {
	id
	}).
-define(CMD_C2GS_ExitEquipEnvoyCoyp,20138).
-record(pk_C2GS_ExitEquipEnvoyCoyp, {
	}).
-define(CMD_GS2C_EnterEquipEnvoyCopy_Ret,20139).
-record(pk_GS2C_EnterEquipEnvoyCopy_Ret, {
	leftTime
	}).
-define(CMD_ItemInfo,20140).
-record(pk_ItemInfo, {
	itemId,
	count,
	isBind
	}).
-define(CMD_GS2C_ArenaTop,20141).
-record(pk_GS2C_ArenaTop, {
	curRank,
	oldMaxRank,
	stageRank,
	awardItems
	}).
-define(CMD_C2GS_ArenaRank,20142).
-record(pk_C2GS_ArenaRank, {
	}).
-define(CMD_GS2C_ArenaRank,20143).
-record(pk_GS2C_ArenaRank, {
	rankerList
	}).
-define(CMD_C2GS_Huang_Cheng_Zheng_Ba_Open,20144).
-record(pk_C2GS_Huang_Cheng_Zheng_Ba_Open, {
	}).
-define(CMD_huangcheng_member,20145).
-record(pk_huangcheng_member, {
	id,
	name,
	sex,
	job
	}).
-define(CMD_GS2C_Huang_Cheng_Zheng_Ba_Open,20146).
-record(pk_GS2C_Huang_Cheng_Zheng_Ba_Open, {
	name,
	memebrlist
	}).
-define(CMD_C2GS_Download_Gift,20147).
-record(pk_C2GS_Download_Gift, {
	id
	}).
-define(CMD_C2GS_Activity_Config,20148).
-record(pk_C2GS_Activity_Config, {
	}).
-define(CMD_Activity_Config,20149).
-record(pk_Activity_Config, {
	id,
	type,
	queryid,
	level,
	startTime,
	date,
	closeEnterTime,
	totalTime
	}).
-define(CMD_GS2C_Activity_Config,20150).
-record(pk_GS2C_Activity_Config, {
	config
	}).
-define(CMD_GS2C_Pay_Ret,20151).
-record(pk_GS2C_Pay_Ret, {
	plantformid,
	num,
	orderid
	}).
-define(CMD_U2GS_LivenessInfo,20152).
-record(pk_U2GS_LivenessInfo, {
	}).
-define(CMD_GS2U_LivenessInfo,20153).
-record(pk_GS2U_LivenessInfo, {
	livenessValue,
	drewLnAwardlist
	}).
-define(CMD_U2GS_drewLnAward,20154).
-record(pk_U2GS_drewLnAward, {
	awardid
	}).
-define(CMD_GS2U_OnelnInfo,20155).
-record(pk_GS2U_OnelnInfo, {
	livenessId,
	finishNum
	}).
-define(CMD_GS2U_OnlineLiveness,20156).
-record(pk_GS2U_OnlineLiveness, {
	liveList
	}).
-define(CMD_GS2U_LivenessTips,20157).
-record(pk_GS2U_LivenessTips, {
	tips
	}).
-define(CMD_U2GS_getGrowAward,20158).
-record(pk_U2GS_getGrowAward, {
	growid
	}).
-define(CMD_GS2U_replyGrowAward,20159).
-record(pk_GS2U_replyGrowAward, {
	result
	}).
-define(CMD_U2GS_getDownMail,20160).
-record(pk_U2GS_getDownMail, {
	}).
-define(CMD_C2GS_Invite_Code,20161).
-record(pk_C2GS_Invite_Code, {
	playerId
	}).
-define(CMD_GS2C_Invite_Code_Ret,20162).
-record(pk_GS2C_Invite_Code_Ret, {
	retCode
	}).
-define(CMD_C2GS_Get_award,20163).
-record(pk_C2GS_Get_award, {
	playerId
	}).
-define(CMD_GS2C_Get_award_Ret,20164).
-record(pk_GS2C_Get_award_Ret, {
	playerId,
	retCode
	}).
-define(CMD_Invite_Info,20165).
-record(pk_Invite_Info, {
	awardId,
	state
	}).
-define(CMD_Invite_Player_Info,20166).
-record(pk_Invite_Player_Info, {
	playerId,
	playerName,
	carrer,
	level,
	awardList
	}).
-define(CMD_C2GS_Invite_Player_Info,20167).
-record(pk_C2GS_Invite_Player_Info, {
	}).
-define(CMD_GS2C_Invite_Player_Info,20168).
-record(pk_GS2C_Invite_Player_Info, {
	type,
	playerList
	}).
-define(CMD_Achievement_Info,20169).
-record(pk_Achievement_Info, {
	achievementId,
	nowNum,
	state
	}).
-define(CMD_GS2C_Achievement_Info,20170).
-record(pk_GS2C_Achievement_Info, {
	achievementList
	}).
-define(CMD_C2GS_Achievement_Get_Award,20171).
-record(pk_C2GS_Achievement_Get_Award, {
	achievementId,
	type
	}).
-define(CMD_GS2C__Achievement_Get_Award_Ret,20172).
-record(pk_GS2C__Achievement_Get_Award_Ret, {
	achievementId,
	errCode
	}).
-define(CMD_Title_Info,20173).
-record(pk_Title_Info, {
	type,
	achievementId,
	expireTimestamp
	}).
-define(CMD_GS2C_Title_Info,20174).
-record(pk_GS2C_Title_Info, {
	titleList
	}).
-define(CMD_C2GS_Achievement_Choose_Title,20175).
-record(pk_C2GS_Achievement_Choose_Title, {
	titleId
	}).
-define(CMD_GS2C_Achievement_Choose_Title_Ret,20176).
-record(pk_GS2C_Achievement_Choose_Title_Ret, {
	titleId,
	errCode
	}).
-define(CMD_C2GS_reqHunting,20177).
-record(pk_C2GS_reqHunting, {
	}).
-define(CMD_GS2C_returnHuntingInfo,20178).
-record(pk_GS2C_returnHuntingInfo, {
	timesOne,
	timesTwo
	}).
-define(CMD_GS2C_SendNotice,20179).
-record(pk_GS2C_SendNotice, {
	startTime,
	endTime,
	content
	}).
-define(CMD_C2GS_SendLuckyMoney,20180).
-record(pk_C2GS_SendLuckyMoney, {
	channel,
	luckyMoneyType,
	quantity,
	total
	}).
-define(CMD_G2CS_SendLuckyMoney_Ret,20181).
-record(pk_G2CS_SendLuckyMoney_Ret, {
	retCode
	}).
-define(CMD_GS2C_HasLuckyMoney,20182).
-record(pk_GS2C_HasLuckyMoney, {
	luckyMoneyId
	}).
-define(CMD_C2GS_GetLeagueLuckyMoneyInfo,20183).
-record(pk_C2GS_GetLeagueLuckyMoneyInfo, {
	}).
-define(CMD_LeagueLuckyMoney,20184).
-record(pk_LeagueLuckyMoney, {
	luckyMoneyId,
	leagueMemberName
	}).
-define(CMD_GS2C_LeagueLuckyMoney,20185).
-record(pk_GS2C_LeagueLuckyMoney, {
	leagueLuckyMoneyList
	}).
-define(CMD_C2GS_GetLuckyMoney,20186).
-record(pk_C2GS_GetLuckyMoney, {
	luckyMoneyId
	}).
-define(CMD_GS2C_GetLuckyMoney_Ret,20187).
-record(pk_GS2C_GetLuckyMoney_Ret, {
	luckyMoneyId,
	retCode
	}).
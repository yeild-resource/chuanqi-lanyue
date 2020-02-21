
-define(CMD_GS2C_ChangeMap,13001).
-record(pk_GS2C_ChangeMap, {
	mapDataID,
	mapId,
	x,
	y,
	lineNum
	}).
-define(CMD_C2GS_TransferMap,13002).
-record(pk_C2GS_TransferMap, {
	mapDataID,
	x,
	y
	}).
-define(CMD_C2GS_ReqChangeMapInTransport,13003).
-record(pk_C2GS_ReqChangeMapInTransport, {
	curMapDataID
	}).
-define(CMD_C2GS_ReqChangeMapByNpc,13004).
-record(pk_C2GS_ReqChangeMapByNpc, {
	id,
	npcDataID,
	npcTransferId
	}).
-define(CMD_C2GS_ReqChangeMapByActivityMapDataId,13005).
-record(pk_C2GS_ReqChangeMapByActivityMapDataId, {
	activityId
	}).
-define(CMD_C2GS_ReqEnterCopyMap,13006).
-record(pk_C2GS_ReqEnterCopyMap, {
	npcId,
	npcDataID,
	enterMapDataId,
	activityId
	}).
-define(CMD_GS2C_NeedBuyCopyMapCd,13007).
-record(pk_GS2C_NeedBuyCopyMapCd, {
	enterMapDataId,
	price
	}).
-define(CMD_C2GS_BuyCopyMapCd,13008).
-record(pk_C2GS_BuyCopyMapCd, {
	activityId,
	price
	}).
-define(CMD_C2GS_ReqEnterCopyMapWithBuyCd,13009).
-record(pk_C2GS_ReqEnterCopyMapWithBuyCd, {
	npcId,
	npcDataID,
	enterMapDataId,
	activityId,
	price
	}).
-define(CMD_GS2C_TheCopyMapHasOpen,13010).
-record(pk_GS2C_TheCopyMapHasOpen, {
	mapId,
	mapDataId
	}).
-define(CMD_C2GS_PlayerLeaveCopyMap,13011).
-record(pk_C2GS_PlayerLeaveCopyMap, {
	}).
-define(CMD_GS2C_CopyMapCompleted,13012).
-record(pk_GS2C_CopyMapCompleted, {
	freeDrawLuckyCnt,
	vipExtraDrawLuckyCnt,
	canBuyDrawLuckyCnt
	}).
-define(CMD_C2GS_PlayerDrawLucky,13013).
-record(pk_C2GS_PlayerDrawLucky, {
	isFree,
	cardIndex
	}).
-define(CMD_GS2C_PlayerDrawLucky_Ret,13014).
-record(pk_GS2C_PlayerDrawLucky_Ret, {
	ret,
	itemDataId,
	itemCnt,
	bind
	}).
-define(CMD_C2GS_BuyCopyMapBuff,13015).
-record(pk_C2GS_BuyCopyMapBuff, {
	}).
-define(CMD_PlayerCopyCDInfo,13016).
-record(pk_PlayerCopyCDInfo, {
	map_data_id,
	enter_cnt,
	remain_cnt,
	bought_cd_cnt
	}).
-define(CMD_GS2C_AllCopyCDInfoAndActivedHighCopy,13017).
-record(pk_GS2C_AllCopyCDInfoAndActivedHighCopy, {
	copyCdInfos,
	activedHighCopyIds
	}).
-define(CMD_GS2C_ActiveHighCopy,13018).
-record(pk_GS2C_ActiveHighCopy, {
	mapDataId
	}).
-define(CMD_GS2C_UpdatPlayerCopyCDInfo,13019).
-record(pk_GS2C_UpdatPlayerCopyCDInfo, {
	map_data_id,
	enter_cnt,
	remain_cnt,
	bought_cd_cnt
	}).
-define(CMD_C2GS_OpenLeagueCopyMap,13020).
-record(pk_C2GS_OpenLeagueCopyMap, {
	mapDataId,
	isBuy
	}).
-define(CMD_C2GS_ReqEnterLeagueCopyMap,13021).
-record(pk_C2GS_ReqEnterLeagueCopyMap, {
	enterMapDataId,
	isBuyLeagueBuff
	}).
-define(CMD_GS2C_LeagueCopyMapCompleted,13022).
-record(pk_GS2C_LeagueCopyMapCompleted, {
	mapDataId
	}).
-define(CMD_C2GS_PlayerOpenLeagueTreasureBox,13023).
-record(pk_C2GS_PlayerOpenLeagueTreasureBox, {
	}).
-define(CMD_GS2C_PlayerOpenLeagueTreasureBox_Ret,13024).
-record(pk_GS2C_PlayerOpenLeagueTreasureBox_Ret, {
	ret,
	itemDataId,
	itemCnt
	}).
-define(CMD_GS2C_CopyMapClose_Countdown,13025).
-record(pk_GS2C_CopyMapClose_Countdown, {
	mapDataId,
	second
	}).
-define(CMD_GS2C_RemainMonsterCnt,13026).
-record(pk_GS2C_RemainMonsterCnt, {
	remainCnt
	}).
-define(CMD_GS2C_ReqNpcGhostCopy,13027).
-record(pk_GS2C_ReqNpcGhostCopy, {
	npcDataID,
	mapDataId,
	isDirect
	}).
-define(CMD_C2GS_IndianaLeave,13028).
-record(pk_C2GS_IndianaLeave, {
	}).
-define(CMD_C2GS_CopyCDInfo,13029).
-record(pk_C2GS_CopyCDInfo, {
	copyID
	}).
-define(CMD_GS2C_RushDetail,13030).
-record(pk_GS2C_RushDetail, {
	canResetTime,
	freeResetTime,
	nowResetTime
	}).
-define(CMD_C2GS_JoinEasyExpActive,13031).
-record(pk_C2GS_JoinEasyExpActive, {
	moneyType
	}).
-define(CMD_GS2C_JoinEasyExpActive,13032).
-record(pk_GS2C_JoinEasyExpActive, {
	errorCode
	}).
-define(CMD_C2GS_LeaveEasyExpActive,13033).
-record(pk_C2GS_LeaveEasyExpActive, {
	}).
-define(CMD_GS2C_LunHuiDaoRemainTime,13034).
-record(pk_GS2C_LunHuiDaoRemainTime, {
	remainTime,
	remainRefreshTime
	}).
-define(CMD_GS2C_LunHuiDaoMonsterInfo,13035).
-record(pk_GS2C_LunHuiDaoMonsterInfo, {
	monsterDataIdVec
	}).
-define(CMD_GS2C_IndianaRemainTime,13036).
-record(pk_GS2C_IndianaRemainTime, {
	remainTime
	}).
-define(CMD_GS2C_ArenaRemainTime,13037).
-record(pk_GS2C_ArenaRemainTime, {
	remainTime
	}).
-define(CMD_BlockSectionInfo,13038).
-record(pk_BlockSectionInfo, {
	x,
	y,
	dx,
	dy
	}).
-define(CMD_GS2C_SetBlockSections,13039).
-record(pk_GS2C_SetBlockSections, {
	blockSectionInfo
	}).
-define(CMD_GS2C_ClearBlockSections,13040).
-record(pk_GS2C_ClearBlockSections, {
	blockSectionInfo
	}).
-define(CMD_GS2C_MoNiGongChengRemainTime,13041).
-record(pk_GS2C_MoNiGongChengRemainTime, {
	remainTime
	}).
-define(CMD_GS2C_ActivityIllWealthCoordinate,13042).
-record(pk_GS2C_ActivityIllWealthCoordinate, {
	mapDataId,
	x,
	y
	}).
-define(CMD_GS2C_LeagueCopyRemainTime,13043).
-record(pk_GS2C_LeagueCopyRemainTime, {
	remainSeconds
	}).
-define(CMD_C2GS_ReadyEnterCopy,13044).
-record(pk_C2GS_ReadyEnterCopy, {
	copyDataID,
	activityId,
	isOK
	}).
-define(CMD_GS2C_ReadyEnterCopy,13045).
-record(pk_GS2C_ReadyEnterCopy, {
	playerID,
	copyDataID,
	activityId,
	isOK
	}).
-define(CMD_C2GS_LeagueEnterLeagueBattle_Req,13046).
-record(pk_C2GS_LeagueEnterLeagueBattle_Req, {
	leagueBattleId
	}).
-define(CMD_GS2C_LeagueEnterLeagueBattle_Ret,13047).
-record(pk_GS2C_LeagueEnterLeagueBattle_Ret, {
	errorCode
	}).
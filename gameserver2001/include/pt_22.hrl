
-define(CMD_FriendInfo,22001).
-record(pk_FriendInfo, {
	playerId,
	name,
	level,
	career,
	sex,
	onLine,
	hp,
	maxhp,
	vipLevel,
	fightingCapacity
	}).
-define(CMD_C2GS_AddFriend_Req,22002).
-record(pk_C2GS_AddFriend_Req, {
	playerId
	}).
-define(CMD_GS2C_AddFriend_Ret,22003).
-record(pk_GS2C_AddFriend_Ret, {
	retCode,
	info
	}).
-define(CMD_GS2C_AddFriend_To_BeAdder_Ret,22004).
-record(pk_GS2C_AddFriend_To_BeAdder_Ret, {
	name
	}).
-define(CMD_C2GS_DelFriend_Req,22005).
-record(pk_C2GS_DelFriend_Req, {
	playerId
	}).
-define(CMD_GS2C_DelFriend_Ret,22006).
-record(pk_GS2C_DelFriend_Ret, {
	playerId,
	retCode
	}).
-define(CMD_C2GS_FriendList_Req,22007).
-record(pk_C2GS_FriendList_Req, {
	}).
-define(CMD_GS2C_FriendList_Ret,22008).
-record(pk_GS2C_FriendList_Ret, {
	friend_list
	}).
-define(CMD_GS2C_FriendUpdate_Ret,22009).
-record(pk_GS2C_FriendUpdate_Ret, {
	info
	}).
-define(CMD_C2GS_RecommendFriends_Req,22010).
-record(pk_C2GS_RecommendFriends_Req, {
	}).
-define(CMD_GS2C_RecommendFriends_Ret,22011).
-record(pk_GS2C_RecommendFriends_Ret, {
	friend_list
	}).
-define(CMD_GS2C_Army,22012).
-record(pk_GS2C_Army, {
	playerId,
	name,
	level,
	career,
	sex,
	onLine,
	flag,
	fightingCapacity,
	vipLevel
	}).
-define(CMD_C2GS_ArmyInfo_Req,22013).
-record(pk_C2GS_ArmyInfo_Req, {
	}).
-define(CMD_GS2C_ArmyInfo_Ret,22014).
-record(pk_GS2C_ArmyInfo_Ret, {
	armyInfoList
	}).
-define(CMD_C2GS_GetArmyPos,22015).
-record(pk_C2GS_GetArmyPos, {
	playerId
	}).
-define(CMD_GS2C_GetArmyPos_Ret,22016).
-record(pk_GS2C_GetArmyPos_Ret, {
	result,
	playerId,
	name,
	curMapDataId,
	posX,
	posY,
	onLine
	}).
-define(CMD_BlackListInfo,22017).
-record(pk_BlackListInfo, {
	playerId,
	name,
	level,
	career,
	sex,
	onLine,
	flag,
	fightingCapacity,
	vipLevel
	}).
-define(CMD_C2GS_BlackList_Req,22018).
-record(pk_C2GS_BlackList_Req, {
	}).
-define(CMD_GS2C_BlackList_Ret,22019).
-record(pk_GS2C_BlackList_Ret, {
	black_list
	}).
-define(CMD_GS2C_BlackListUpdate_Ret,22020).
-record(pk_GS2C_BlackListUpdate_Ret, {
	info
	}).
-define(CMD_C2GS_AddBlackList_Req,22021).
-record(pk_C2GS_AddBlackList_Req, {
	playerId
	}).
-define(CMD_C2GS_DelBlackList_Req,22022).
-record(pk_C2GS_DelBlackList_Req, {
	playerId
	}).
-define(CMD_C2GS_DelArmy_Req,22023).
-record(pk_C2GS_DelArmy_Req, {
	playerId
	}).
-define(CMD_C2GS_ArmyPosStop_Req,22024).
-record(pk_C2GS_ArmyPosStop_Req, {
	}).
-define(CMD_FlowerRankInfo,22025).
-record(pk_FlowerRankInfo, {
	playerId,
	name,
	career,
	sex,
	rank,
	value
	}).
-define(CMD_C2GS_GiveFlower_Req,22026).
-record(pk_C2GS_GiveFlower_Req, {
	playerId,
	num
	}).
-define(CMD_C2GS_FlowerValue_Req,22027).
-record(pk_C2GS_FlowerValue_Req, {
	playerId
	}).
-define(CMD_GS2C_FlowerValue_Ret,22028).
-record(pk_GS2C_FlowerValue_Ret, {
	playerId,
	name,
	value
	}).
-define(CMD_C2GS_FlowerRank_Req,22029).
-record(pk_C2GS_FlowerRank_Req, {
	playerId
	}).
-define(CMD_GS2C_FlowerRank_Ret,22030).
-record(pk_GS2C_FlowerRank_Ret, {
	info
	}).
-define(CMD_GS2C_FlowerTwenty,22031).
-record(pk_GS2C_FlowerTwenty, {
	rankList
	}).
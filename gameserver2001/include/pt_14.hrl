
-define(CMD_PosInfo,14001).
-record(pk_PosInfo, {
	x,
	y
	}).
-define(CMD_C2GS_PlayerMoveTo,14002).
-record(pk_C2GS_PlayerMoveTo, {
	curMapDataId,
	posX,
	posY,
	posInfos
	}).
-define(CMD_GS2C_PlayerStopMove,14003).
-record(pk_GS2C_PlayerStopMove, {
	id,
	posX,
	posY
	}).
-define(CMD_C2GS_PlayerStopMove,14004).
-record(pk_C2GS_PlayerStopMove, {
	curMapDataId,
	posX,
	posY
	}).
-define(CMD_GS2C_PlayerMoveInfo,14005).
-record(pk_GS2C_PlayerMoveInfo, {
	id,
	posX,
	posY,
	posInfos
	}).
-define(CMD_GS2C_LookInfoPlayer,14006).
-record(pk_GS2C_LookInfoPlayer, {
	id,
	name,
	leagueName,
	level,
	weapon,
	coat,
	hp,
	hpMax,
	mp,
	mpMax,
	x,
	y,
	move_speed,
	value_flags,
	charState,
	titleId,
	vipLevel,
	posInfos,
	fightingCapacity,
	ucVipLevel,
	wing,
	crossSide,
	robotModule,
	gathering
	}).
-define(CMD_GS2C_LookInfoMonster,14007).
-record(pk_GS2C_LookInfoMonster, {
	id,
	name,
	monster_data_id,
	hp,
	hpMax,
	mp,
	mpMax,
	x,
	y,
	move_speed,
	posInfos,
	charState,
	level,
	leagueId
	}).
-define(CMD_GS2C_LookInfoNpc,14008).
-record(pk_GS2C_LookInfoNpc, {
	id,
	npc_data_id,
	x,
	y
	}).
-define(CMD_GS2C_LookInfoItem,14009).
-record(pk_GS2C_LookInfoItem, {
	id,
	item_data_id,
	ownerId,
	x,
	y
	}).
-define(CMD_GS2C_LookInfoTrap,14010).
-record(pk_GS2C_LookInfoTrap, {
	id,
	trapDataId,
	x,
	y,
	dx,
	dy
	}).
-define(CMD_GS2C_LookInfoPet,14011).
-record(pk_GS2C_LookInfoPet, {
	id,
	masterId,
	petType,
	dataId,
	name,
	level,
	hp,
	hpMax,
	mp,
	mpMax,
	x,
	y,
	move_speed,
	posInfos,
	charState,
	petChangeId
	}).
-define(CMD_GS2C_ActorDisapearList,14012).
-record(pk_GS2C_ActorDisapearList, {
	info_list
	}).
-define(CMD_GS2C_MonsterStopMove,14013).
-record(pk_GS2C_MonsterStopMove, {
	id,
	posX,
	posY
	}).
-define(CMD_GS2C_MonsterMoveInfo,14014).
-record(pk_GS2C_MonsterMoveInfo, {
	id,
	posX,
	posY,
	posInfos
	}).
-define(CMD_C2GS_PetMoveTo,14015).
-record(pk_C2GS_PetMoveTo, {
	curMapDataId,
	posX,
	posY,
	posInfos
	}).
-define(CMD_C2GS_PetStopMove,14016).
-record(pk_C2GS_PetStopMove, {
	curMapDataId,
	posX,
	posY
	}).
-define(CMD_GS2C_PetStopMove,14017).
-record(pk_GS2C_PetStopMove, {
	id,
	posX,
	posY
	}).
-define(CMD_GS2C_PetMoveInfo,14018).
-record(pk_GS2C_PetMoveInfo, {
	id,
	posX,
	posY,
	posInfos
	}).
-define(CMD_GS2C_RoleTeleport,14019).
-record(pk_GS2C_RoleTeleport, {
	id,
	posX,
	posY
	}).
-define(CMD_C2GS_PetTeleport_OutOfView,14020).
-record(pk_C2GS_PetTeleport_OutOfView, {
	curMapDataId,
	id
	}).
-define(CMD_PushRoleInfo,14021).
-record(pk_PushRoleInfo, {
	id,
	curX,
	curY,
	targetX,
	targetY
	}).
-define(CMD_GS2C_SkillPushRoleList,14022).
-record(pk_GS2C_SkillPushRoleList, {
	castId,
	skillId,
	affectRoles
	}).
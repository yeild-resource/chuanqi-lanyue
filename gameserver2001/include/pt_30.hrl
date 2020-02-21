
-define(CMD_GS2C_RemovePet,30001).
-record(pk_GS2C_RemovePet, {
	id
	}).
-define(CMD_GS2C_PetLevelUpSync,30002).
-record(pk_GS2C_PetLevelUpSync, {
	id,
	dataId,
	petType,
	level,
	speed,
	hp,
	hpMax,
	modelId
	}).
-define(CMD_GS2C_UpdatePetInfo,30003).
-record(pk_GS2C_UpdatePetInfo, {
	id,
	dataId,
	petType,
	level,
	speed,
	hp,
	hpMax,
	modelId,
	skillId,
	name
	}).
-define(CMD_C2GS_ActivePetModel,30004).
-record(pk_C2GS_ActivePetModel, {
	modelId
	}).
-define(CMD_GS2C_ActivePetModelResult,30005).
-record(pk_GS2C_ActivePetModelResult, {
	retCode,
	modelIdList
	}).
-define(CMD_C2GS_ChangePetModel,30006).
-record(pk_C2GS_ChangePetModel, {
	modelId
	}).
-define(CMD_GS2C_ChangePetModelResult,30007).
-record(pk_GS2C_ChangePetModelResult, {
	modelId,
	retCode
	}).
-define(CMD_GS2C_InitPetModel,30008).
-record(pk_GS2C_InitPetModel, {
	modelId,
	modelIdList
	}).
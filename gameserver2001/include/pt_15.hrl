
-define(CMD_ChatEquipExtendProperity,15001).
-record(pk_ChatEquipExtendProperity, {
	quality,
	propId,
	propValue
	}).
-define(CMD_ChatEquipItem,15002).
-record(pk_ChatEquipItem, {
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
-define(CMD_ChatExtraMessage,15003).
-record(pk_ChatExtraMessage, {
	messageType,
	num
	}).
-define(CMD_ChatMyPos,15004).
-record(pk_ChatMyPos, {
	mapID,
	mapLine,
	posX,
	posY
	}).
-define(CMD_C2GS_Chat,15005).
-record(pk_C2GS_Chat, {
	channelId,
	message,
	voice,
	itemIdList,
	myPos
	}).
-define(CMD_GS2C_Chat,15006).
-record(pk_GS2C_Chat, {
	channelId,
	senderId,
	senderName,
	titleId,
	message,
	voice,
	chatEquipItem,
	chatExtraMessage,
	myPos
	}).
-define(CMD_C2GS_Chat_Private,15007).
-record(pk_C2GS_Chat_Private, {
	recverId,
	message,
	voice,
	itemIdList,
	myPos
	}).
-define(CMD_GS2C_Chat_Private,15008).
-record(pk_GS2C_Chat_Private, {
	senderId,
	senderName,
	titleId,
	message,
	voice,
	chatEquipItem,
	myPos
	}).
-define(CMD_C2GS_Chat_Private_By_Name,15009).
-record(pk_C2GS_Chat_Private_By_Name, {
	recverName,
	message,
	voice,
	itemIdList,
	myPos
	}).
-define(CMD_GS2C_Chat_Private_By_Name,15010).
-record(pk_GS2C_Chat_Private_By_Name, {
	retCode,
	recverId,
	recverName,
	titleId,
	message,
	voice,
	chatEquipItem,
	myPos
	}).
-define(CMD_GS2C_Chat_System,15011).
-record(pk_GS2C_Chat_System, {
	displayType,
	channelId,
	code,
	args
	}).
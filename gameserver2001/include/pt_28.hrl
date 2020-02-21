
-define(CMD_RankInfo,28001).
-record(pk_RankInfo, {
	rank,
	id,
	name,
	level,
	career,
	count,
	viplevel,
	leaguename
	}).
-define(CMD_C2GS_RankList_Req,28002).
-record(pk_C2GS_RankList_Req, {
	rankType,
	careerType
	}).
-define(CMD_GS2C_FightRankList_Ret,28003).
-record(pk_GS2C_FightRankList_Ret, {
	retCode,
	rankType,
	careerType,
	rank_list,
	myRankInfo
	}).
-define(CMD_GS2C_RankList_Updated,28004).
-record(pk_GS2C_RankList_Updated, {
	flag
	}).
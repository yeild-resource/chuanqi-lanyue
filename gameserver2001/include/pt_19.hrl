
-define(CMD_TaskProgess,19001).
-record(pk_TaskProgess, {
	nCurCount
	}).
-define(CMD_AcceptTask,19002).
-record(pk_AcceptTask, {
	taskDataId,
	progress_list
	}).
-define(CMD_GS2C_AcceptedTaskList,19003).
-record(pk_GS2C_AcceptedTaskList, {
	accepted_list
	}).
-define(CMD_RepeatTaskInfo,19004).
-record(pk_RepeatTaskInfo, {
	taskDataId,
	completeCnt
	}).
-define(CMD_GS2C_CompletedTasks,19005).
-record(pk_GS2C_CompletedTasks, {
	completed_repeat_list,
	completed_single_list
	}).
-define(CMD_C2GS_AcceptTask_Req,19006).
-record(pk_C2GS_AcceptTask_Req, {
	taskDataId,
	npcDataId,
	npcId
	}).
-define(CMD_GS2C_AcceptTask_Ret,19007).
-record(pk_GS2C_AcceptTask_Ret, {
	taskDataId,
	retCode
	}).
-define(CMD_GS2C_PlayerTaskProgressChanged,19008).
-record(pk_GS2C_PlayerTaskProgressChanged, {
	taskDataId,
	progress_list
	}).
-define(CMD_C2GS_CompleteTask_Req,19009).
-record(pk_C2GS_CompleteTask_Req, {
	taskDataId,
	npcDataId,
	npcId
	}).
-define(CMD_GS2C_CompleteTask_Ret,19010).
-record(pk_GS2C_CompleteTask_Ret, {
	taskDataId,
	retCode
	}).
-define(CMD_C2GS_GiveUpTask_Req,19011).
-record(pk_C2GS_GiveUpTask_Req, {
	taskDataId
	}).
-define(CMD_GS2C_GiveUpTask_Ret,19012).
-record(pk_GS2C_GiveUpTask_Ret, {
	taskDataId,
	retCode
	}).
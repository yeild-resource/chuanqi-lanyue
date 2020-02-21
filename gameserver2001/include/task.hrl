-ifndef(task_hrl).
-define(task_hrl, 1).

%%玩家已经接收任务条件信息
-record(aimProgress, {type,
  targetDataId,
  targetCnt,
  curCnt,
  gatherId,
  probability}).

%%玩家已接任务
-record(acceptTask, {taskDataId, aimProgressList}).

%%玩家已完成任务
-record(repeatCompletedTask, {taskDataId, cnt}).

-endif.
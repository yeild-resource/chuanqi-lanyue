-ifndef(__QUEUE_HRL__).
-define(__QUEUE_HRL__, 1).

-define(Queue_Full, 0).     %%排队列表已满
-define(Queue_In_Queue, 1). %%在排队列表中

%% 排队人数
-define(UserQueueMaxNum, 300).

%%排名时间界限,前10名排名时间为名次*UserQueueDelayTime,大于10名时随机10人取平均值
-define(UserQueueRank, 10).

%%排队定时器
-define(UserQueueDelayTime, 30). %%30秒
-define(UserQueueTimer, ?UserQueueDelayTime * 1000).

-record(userLoginQueue, {
  accountId = 0,
  time = 0,
  delayTime = 0,
  rank = 0,
  sign = ""
}).

-endif.
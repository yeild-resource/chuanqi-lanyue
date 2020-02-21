-ifndef(exp_hrl).

-define(exp_hrl, 1).

%%经验变化原因
-define(Exp_Change_campfire_1, 1). %% 篝火活动增加经验  about 10 second, ?Activity_Campfire_CalExp_IntervalTime
-define(Exp_Change_campfire_2, 2). %% 篝火活动一次动作的经验
-define(Exp_Change_copy, 3). %% 副本
-define(Exp_Change_escort_1, 4). %% 抢劫获得
-define(Exp_Change_escort_2, 5). %% 抢劫奖励
-define(Exp_Change_gm, 6). %% gm命令
-define(Exp_Change_item, 7). %% 使用道具
-define(Exp_Change_levelAward, 8). %% 冲级奖励
-define(Exp_Change_mine, 9). %% 挖矿   about 1 minute
-define(Exp_Change_task, 10). %% 做任务
-define(Exp_Change_killMonster, 11).  %% 杀怪
-define(Exp_Change_killMultipleMonster, 12).  %% 杀多只怪
-define(Exp_Change_EasyExp, 13).  %% 泡点房
-define(Exp_Change_Cross, 14).  %%跨服战
-define(Exp_Change_Indiana, 15). %% 夺宝奇兵
-define(Exp_Change_OffLineHangUp, 16). %%离线挂机
-define(Exp_Change_ArenaCopy, 17). %%竞技场
-define(Exp_Change_OfflineExp, 18). %%离线经验
-define(Exp_Change_ServerActivity, 19). %%开服庆典
-define(Exp_Change_KilledByMonster, 20). %%被怪打死
-define(Exp_Change_LeagueCampfire, 21). %%帮会篝火
-define(Exp_Change_EquipmentRecycle, 22). %% 装备回收

-endif.

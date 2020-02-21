-ifndef(npc_hrl).

-define(npc_hrl, 1).

%% npc 功能
-define(Npc_Func_None, 0). % 0无功能
-define(Npc_Func_Transfer, 1). %1传送
-define(Npc_Func_Sell, 2). %  2售卖
-define(Npc_Func_Collect, 3). %  3采集
-define(Npc_Func_EnterCopy, 4). % 4进入副本
-define(Npc_Func_HuangChengWar, 23). %%沙城买物品


%%与Npc对话的距离
-define(TalkToNpc_Radius_ForXY, 15).  %% 逻辑坐标

%% 拾取道具的距离
-define(PickupItem_Radius_ForXY, 2). %% 逻辑坐标


%%玩家之间交易时玩家间的距离
-define(TradeBetweenPlayers_Radius_ForXY, 30).  %% 逻辑坐标


%% 玩家与采集对象之间的距离
-define(GatherBetweenPlayer_Radius_ForXY, 1).  %% 逻辑坐标


-define(IllWealthNpcIdList, [215, 216, 217, 218, 219]).

-endif.
-ifndef(__GAMELOG_HRL__).
-define(__GAMELOG_HRL__, 1).

-define(Statistic_Online_Count_Time, 10 * 60 * 1000).


%% -include("money.hrl")
%% %%钱类型Money_Type
%% -define(Money_Coin, 0 ).%%	//	金币
%% -define(Money_BindCoin, 1 ).%%	//	绑定金币
%% -define(Money_Treasure, 2 ).%%	//	元宝
%% -define(Money_BindTreasure, 3 ).%%	//	绑定元宝
%% -define(Money_Count, 4 ).
%% 
%% %%钱变化原因Money_Change_Reason
%% -define(Money_Change_SellItem, 1 ). %% sell item
%% -define(Money_Change_Strength, 2 ). %% strength equip
%% -define(Money_Change_GM, 3 ). %% gm
%% -define(Money_Change_Compose, 4 ). %%compose 
%% -define(Money_Change_NpcBuy, 5 ). %%商店购买物品
%% -define(Money_Change_Trade, 6 ). %%交易
%% -define(Money_Change_Task,  7).  %% 任务
%% -define(Money_Change_BuyCopyDrawLucky,  8). %%购买副本抽奖次数
%% -define(Money_Change_BuyCopyBuff,  9). %%购买副本BUFF
%% -define(Money_Change_BuyCopyCd,  10). %%购买副本CD
%% -define(Money_Change_MonsterDrop,  11). %%刷怪掉落
%% -define(Money_Change_CreateLeague,  12). %%创建帮会
%% -define(Money_Change_RecoverLife,  13). %%复活
%% -define(Money_Change_MineLucky,  14). %%探矿

%% exp_change_reason
-define(Log_Exp_Change_GM, 1).    %% gm
-define(Log_Exp_Change_Task, 2).  %% complete task

-endif.

-ifndef(__COPY_HRL__).
-define(__COPY_HRL__, 1).
-include("excelDefine.hrl").

%% 玩家可使用RMB购买副本进入次数，每日每个副本购买次数上限为4次
%% 玩家花费RMB购买的副本进入次数，当日如未使用完，每日凌晨0点刷新时同样清零
-define(Buy_Copy_CD_Max_Times, 30).

-define(Buy_League_Copy_CD_Max_Times, 2).

-define(Activity_EquipEnvoy_Open, 1).  %% 重装使者副本开启
-define(Activity_EquipEnvoy_Closed, 0).  %% 重装使者副本结束

-define(League_Copy_Open_Sec, 1800).%%进行30分钟帮会副本倒计时，倒计时结束时，副本自动关闭
-define(Copy_Close_Client_Countdown_Sec, 60). %%客户端副本关闭倒计时长，单位：second
-define(Copy_Force_Player_Leave_Sec, 15). %%强制玩家退出副本时间

-define(Arena_Copy_Open_Sec, 180).%%进行5分钟竞技场副本倒计时，倒计时结束时，副本自动关闭
-define(Rush_Mission_Copy_Open_Sec, 300). %%闯天关封魔塔5分钟倒计时结束关闭
-define(MagicDragonTreasureCopy_Open_Min, 10). %% 魔龙宝地10分钟倒计时结束关闭

-define(Copy_Timer_EquipEnvoy_IntervalTime, 86400000).  %%重装使者的间隔时间  

-record(copyMapDrawLuckCntInfo, {playerId, freeDrawLuckyCnt, vipExtraDrawLuckyCnt, canBuyDrawLuckyCnt, canBuyDrawLuckyCnt_saved}).

-define(CompleteCopy_FreeDrawLuckyCnt, 1).  %%免费抽奖次数
%% -define(CompleteCopy_VipExtraDrawLuckyCnt, 0). %%VIP玩家可以额外获取的抽奖次数
%% -define(CompleteCopy_CanBuyDrawLuckyCnt, 7).  %%花费RMB可获取的抽奖次数

-define(DrawLucky_Ret_FreeCnt_Useup, 1).
-define(DrawLucky_Ret_CanBuyCnt_Useup, 2).
-define(DrawLucky_Ret_Treasure_Not_Enough, 3).
-define(DrawLucky_Ret_Win_Nothing, 4).


-define(OpenLeagueTreasureBox_Win_Nothing, 1).
-define(OpenLeagueTreasureBox_Already_Opened, 2).
-define(OpenLeagueTreasureBox_Bag_Is_Full, 3).


-record(towerDefenseAwardInfo, {spiritnum, awardexp, awardcoin}).

-endif.



-ifndef(exploreDefine_hrl).

-define(exploreDefine_hrl, 1).
-include("excelDefine.hrl").
-include("digitAdjustDefine.hrl").

-record(mineBroadCast, {
  name = 0, %%玩家的名字
  itemDataId = 0, %物品的id
  count = 0,
  flag = 0,
  time = 0
}).

%% 挖矿类型
-define(ExploreTypeLucky, 1).    %% 幸运挖矿
-define(ExploreTypeMystery, 2).    %% 神秘挖矿

%% 挖矿次数相关
-define(ExploreBaseTimes, 50).  %% 挖矿次数基数
-define(ExploreAddWithVipLevel, 5).    %% 挖矿次数随Vip等级递增
-define(ExploreResetTimes, 3).    %% 每天神秘挖矿重置次数
-define(FreeExploreForVip, {3, 0}).  %% Vip免费挖矿次数
-define(FreeExploreForNormal, {0, 0}).  %% 非Vip免费挖矿次数

%% 重置挖矿元宝消耗
-define(ExploreResetLuckyBaseCost, 50).  %% 重置幸运挖矿次数的基础元宝数量
-define(ExploreResetMysteryBaseCost, 150).  %% 重置神秘挖矿次数的基础元宝数量
-define(ExploreResetAddLuckyCostWitjVipLevel, 20).  %% 重置幸运挖矿随着次数增加消耗的元宝增加
-define(ExploreResetAddMysteryCostWithVipLevel, 150).  %% 重置神秘挖矿随着次数增加消耗的元宝增加

%% 挖矿一次的积分消耗
-define(ExploreLuckyCostAccPointPer, 10).
-define(ExploreMysteryCostAccPointPer, 1000).

%% 挖矿一次消耗的矿镐
-define(ExploreLuckyCostMineral, 1).
-define(ExploreMysteryCostMineral, 100).

%% 广播标识
-define(ExploreBroadCastFlag, 1).

-record(mineBroadCastList, {id = 0, broadcast = []}).

-define(Explore_BroadCast_Num, 10). %%探矿广播的最大数量
%% 
%% -define(Explore_Type_1, 1).  %%探矿的类型1次
%% -define(Explore_Type_10, 2). %%探矿的类型10次
%% -define(Explore_Type_50, 3). %%探矿的类型50次
%% 
-define(Explore_Type_1_Num, 1).  %%探矿的类型1次
-define(Explore_Type_10_Num, 10). %%探矿的类型10次
-define(Explore_Type_50_Num, 50). %%探矿的类型50次
%% 
%% -define(Explore_Need_Treasure, 10). %%探矿一次需要的元宝数量
%% 
%% -define(Explore_Add_Exp, 2000). %%每次增加2000经验值

-endif.
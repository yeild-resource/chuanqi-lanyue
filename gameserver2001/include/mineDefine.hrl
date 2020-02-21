-ifndef(mineDefine_hrl).

-define(mineDefine_hrl, 1).
-include("excelDefine.hrl").
-include("digitAdjustDefine.hrl").

-record(mineBroadCast, {
  name = 0, %%玩家的名字
  itemDataId = 0, %物品的id
  count = 0,
  flag = 0,
  time = 0
}).

-record(mineBroadCastList, {id = 0, broadcast = []}).

-define(Mine_BroadCast_Num, 10). %%探矿广播的最大数量

-define(Mine_Type_1, 1). %%探矿的类型1次
-define(Mine_Type_10, 2). %%探矿的类型10次
-define(Mine_Type_50, 3). %%探矿的类型50次

-define(Mine_Type_1_Num, 1). %%探矿的类型1次
-define(Mine_Type_10_Num, 10). %%探矿的类型10次
-define(Mine_Type_50_Num, 50). %%探矿的类型50次

-define(Mine_Need_Treasure, 10). %%探矿一次需要的元宝数量

-define(Mine_Add_Exp, 2000). %%每次增加2000经验值

-endif.
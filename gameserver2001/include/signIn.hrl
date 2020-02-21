-ifndef(SIGN_IN_HRL).
-define(SIGN_IN_HRL, 1).

-define(Player_Again_Sign_In_Cnt, 35). %%补签次数(不加上限)
-define(PlayerVip_Again_Sign_In_Cnt, 35). %%补签次数(不加上限)
-define(Player_Again_Sign_In_Cost_Gold, 10). %%补签所需元宝

-define(Player_Sign_In_Failed_IsAlready, -1). %%今日已签到
-define(Player_Sign_In_Succ, 1). %%签到成功

-define(Player_Again_Sign_In_Failed_Cnt, -1). %%补签次数已用完
-define(Player_Again_Sign_In_Failed_Gold, -2). %%元宝不足
-define(Player_Again_Sign_In_Failed_Time, -3). %%不能补签创角之前的
-define(Player_Again_Sign_In_Succ, 1). %%补签成功

-define(Player_Get_Award_Failed_Is_Already, -1). %%奖励已经领取过
-define(Player_Get_Award_Failed_Days_Is_Lacking, -2). %%领取奖励失败，累积签到天数不足
-define(Player_Get_Award_Failed_Bag_Full, -3). %%背包已满
-define(Player_Get_Award_Succ, 1). %%领取奖励成功

-endif.
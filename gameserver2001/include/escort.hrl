-ifndef(escort_hrl).

-define(escort_hrl, 1).
-include("excelDefine.hrl").

-define(Escort_Refresh_Type_One, 0). %% 单次刷新
-define(Escort_Refresh_Type_All, 1). %% 一键刷新
-define(Escort_Refresh_FreeTimes, 3). %% 免费刷新次数
-define(Escort_Refresh_One_Money, 1). %% 刷新一次的元宝数量
-define(Escort_Refresh_All_Money, 30). %% 一键刷新的元宝数量
-define(Escort_Refresh_Highest_Quality, 3). %% 美女最高品质

-define(Escort_Level_Limit, 35). %% 护送美女的最低等级限制
-define(Escort_Times_Limit, 5). %% 护送美女的次数限制
-define(Escort_Rob_Times_Limit, 5). %% 护送美女的次数限制
-define(Escort_Rob_Percent, 500). %% 护送美女每次抢劫的千分比
-define(Escort_Rob_Percent_LowLimit, 125). %% 护送美女获取经验的保护百分比 
-define(Escort_Rob_Level_Diff_Limint, 20). %% 护送美女等级差
-define(Escort_Rob_Time_Limit, 300). %% 抢劫的间隔时间300秒（5分钟）

-define(Escort_Rob_DoubleAward_Begin, 54000). %% 双倍经验的开始时间
-define(Escort_Rob_DoubleAward_End, 61200). %% 双倍经验的开始时间
-define(Escort_Rob_DoubleAward_Rate, 2). %% 经验加成倍数
-endif.

-ifndef(__HUANG_CHENG_ZHENG_BA_HRL__).
-define(__HUANG_CHENG_ZHENG_BA_HRL__, 1).

-define(Huang_Cheng_Zheng_Ba_On_Timer, 60000).

-define(Huang_Cheng_Zheng_Ba_Start_Battle_Week, 6).
-define(Huang_Cheng_Zheng_Ba_Start_Battle_Week_Time, 20 * 3600 + 30 * 60).
-define(Huang_Cheng_Zheng_Ba_End_Battle_Week_Time, 21 * 3600 +  0 * 60).
-define(Huang_Cheng_Zheng_Ba_Last_Time, ?Huang_Cheng_Zheng_Ba_End_Battle_Week_Time - ?Huang_Cheng_Zheng_Ba_Start_Battle_Week_Time).

-define(Killer_Integral, 1).

-define(huangcheng_leaguemember_num, huangcheng_leaguemember_num).

-define(HuangChengMaxLeagueMemberNum, 30).

-define(HuangChengTitleID, 100).%%皇城争霸称号id
-define(HuangChengMemTitleID, 110).%%沙城精锐称号id

-define(Huang_Cheng_Zheng_Ba_MapDataId1, 7001).%%皇城
-define(Huang_Cheng_Zheng_Ba_MapDataId2, 7003).%%密道
-define(Huang_Cheng_Zheng_Ba_MapDataId3, 7002).%%皇宫

-define(WorldMap_ShaBaKe, 7001). %%沙巴克
-define(WorldMap_HuangGong, 7002). %%皇宫
-define(TuCheng_MapDataId, 5005). %%土城

-define(Huang_Cheng_Zheng_Ba_Get_Award_Error, -1). %%已经领取过
-define(Huang_Cheng_Zheng_Ba_Get_Award_Error_Bag_Is_Full, -2). %%背包已满
-define(Huang_Cheng_Zheng_Ba_Get_Award_Error_League, -3). %%不属于占领者帮会
-define(Huang_Cheng_Zheng_Ba_Get_Award_Error_League_Is_Not_Exit, -4). %%沙城未被占领
-define(Huang_Cheng_Zheng_Ba_Get_Award_Succ, 1). %%成功领取奖励

-record(killLeaderIntegral, {leaderId = 0, leagueName, integral = 0}).

-record(huangchengPlayer, {playerId = 0, sex = 0, carrer = 0, name}).

-define(HuangCheng_First_Blood, huang_cheng_first_blood).%%皇城争霸一血标志，为false表示还没人拿到一血

-define(HuangCheng_League_Member, huang_cheng_league_member).%%皇城争霸获胜公会在天下霸业中显示的玩家信息

-define(HuangCheng_League, huang_cheng_league).%%皇城争霸参加工会玩家信息


-define(HuangCheng_Kill_Player, huangcheng_kill_player).

-define(HuangCheng_Item1, 16001).%%皇城武器id
-define(HuangCheng_Item2, 16002).
-define(HuangCheng_Item3, 16003).

-define(HuangCheng_Back_X1, 150).%%守方复活点
-define(HuangCheng_Back_X2, 156).
-define(HuangCheng_Back_Y1, 148).
-define(HuangCheng_Back_Y2, 154).
-define(HuangCheng_Shabake_X1, 84).%%城墙区域
-define(HuangCheng_Shabake_X2, 196).
-define(HuangCheng_Shabake_Y1, 90).
-define(HuangCheng_Shabake_Y2, 203).

-define(HuangCheng_BuffId1, 700). %% 皇城争霸携带城主之刃的buff效果id1
-define(HuangCheng_BuffId2, 701). %% 皇城争霸携带城主之刃的buff效果id2
-define(HuangCheng_BuffId3, 702). %% 皇城争霸携带城主之刃的buff效果id3
-define(HuangChang_ChengZhuZhiRen, 9999).  %% 城主之刃
-define(HuangGongPeopleMax, 10). %% 在皇宫每个帮会人数上限

-endif.
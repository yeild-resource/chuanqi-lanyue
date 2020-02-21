-ifndef(variant_hrl).
-define(variant_hrl, 1).

%%变量类型，未初始化
-define(Variant_Type_Unvalid, 0).
%%变量类型，玩家
-define(Variant_Type_Player, 1).
%%变量类型，世界
-define(Variant_Type_World, 2).


%%玩家变量最大个数
%% -define(Max_PlayerVariant_Count, 100). 取消这个限制
-define(Max_PlayerVariant_Syn_Client_Count, 50).
-define(Max_PlayerVariant_Syn_Client_Count_OnlyOnline, 200).

%%世界变量最大个数
-define(Max_WorldVariant_Count, 100).
-define(Max_WorldVariant_Syn_Client_Count, 50).

%% 
%%---------------------------------------------------玩家变量--------------------------------------------------------------
%% 玩家变量分为3类:
%%    1:是客户端服务器共享,改变时需要通知client [1,Max_PlayerVariant_Syn_Client_Count)]；
%%    2:是客户端服务器共享,只有玩家上线时要同步到client,  [Max_PlayerVariant_Syn_Client_Count+1,Max_PlayerVariant_Syn_Client_Count_OnlyOnline]
%%    3:服务器专用 [Max_PlayerVariant_Syn_Client_Count_OnlyOnline,Max_PlayerVariant_Count-1]
%% 每一类里面又分为2类，1是只在玩家进程使用(以_P结束)， 2是只在地图相关进程使用 (以_M _F结束) 
%%1---Max_PlayerVariant_Syn_Client_Count, 客户端服务器共享，需要同步客户端
-define(PlayerVariant_Index_NextRecoverTime_F, 1).%%下一次能立即复活的时间,复活介子相关的

-define(PlayerVariant_Index_CampfireExpRate_P, 2).%%篝火活动中醉酒度

-define(PlayerVariant_Index_ActivityFlag_P, 3).%%活动中的一些标志信息
-define(PlayerVariant_Index_ActivityFlag_CampfireFreeDrink_P, 0).%%篝火活动中免费饮酒次数
-define(PlayerVariant_Index__ActivityFlag_Grow1, 1).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow2, 2).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow3, 3).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow4, 4).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow5, 5).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow6, 6).%% 成长礼包奖励
-define(PlayerVariant_Index__ActivityFlag_Grow7, 7).%% 成长礼包奖励预留2个
-define(PlayerVariant_Index__ActivityFlag_IsUsedGrowGift, 10).%% 是否使用过成长礼包了
-define(PlayerVariant_Index_ActivityFlag_CampfireFreeEat_P, 11).%%篝火活动中免费吃肉次数

-define(PlayerVariant_Index_RushMission_NowMission, 4).%%闯天关当前所在层
-define(PlayerVariant_Index_RushMission_ClearanceMission, 5). %%存储最大的通关数， 用于扫荡时使用
% -define( PlayerVariant_Index_RushMission_PreviousFinishedMission, 6). %%闯天关刚打完的层
-define(PlayerVariant_Index_RushMission_FirstMission, 6).%%闯天关首杀所在层
-define(PlayerVariant_Index_RushMission_ResetTimes, 7).%%闯天关当前重置次数

-define(PlayerVariant_Index_RankList_Award, 8).%% 排行榜领奖
-define(PlayerVariant_Bit_RankList_Award_Fight, 0).%% 战斗力排行榜领奖
-define(PlayerVariant_Bit_RankList_Award_level, 1).%% 等级排行榜领奖
-define(PlayerVariant_Bit_RankList_Award_league, 2).%% 帮会排行榜领奖
-define(PlayerVariant_Bit_DownGif, 3).%% 下载资源领奖
-define(PlayerVariant_Bit_IsSendDownMailGif, 4).%% 是否发过了下载资源邮件

-define(PlayerVariant_Index_PlayerTitleType, 9).%% 玩家的称号的类型

-define(PlayerVariant_Index_OpenServer_Award, 10).%% 开服1-15天奖励
-define(PlayerVariant_Bit_OpenServer_Day_1, 0).%% 开服1天
-define(PlayerVariant_Bit_OpenServer_Day_2, 1).
-define(PlayerVariant_Bit_OpenServer_Day_3, 2).
-define(PlayerVariant_Bit_OpenServer_Day_4, 3).
-define(PlayerVariant_Bit_OpenServer_Day_5, 4).
-define(PlayerVariant_Bit_OpenServer_Day_6, 5).
-define(PlayerVariant_Bit_OpenServer_Day_7, 6).
-define(PlayerVariant_Bit_OpenServer_Day_8, 7).
-define(PlayerVariant_Bit_OpenServer_Day_9, 8).
-define(PlayerVariant_Bit_OpenServer_Day_10, 9).
-define(PlayerVariant_Bit_OpenServer_Day_11, 10).
-define(PlayerVariant_Bit_OpenServer_Day_12, 11).
-define(PlayerVariant_Bit_OpenServer_Day_13, 12).
-define(PlayerVariant_Bit_OpenServer_Day_14, 13).
-define(PlayerVariant_Bit_OpenServer_Day_15, 14).%% 开服15天

-define(PlayerVariant_Index_OpenServer_NowDay, 11).%% 现在是开服第几天

-define(PlayerVariant_Index_OpenServer_LoginDay, 12). %% 玩家开服登陆日记录
-define(PlayerVariant_Bit_OpenServer_LoginDay_1, 0).
-define(PlayerVariant_Bit_OpenServer_LoginDay_2, 1).
-define(PlayerVariant_Bit_OpenServer_LoginDay_3, 2).
-define(PlayerVariant_Bit_OpenServer_LoginDay_4, 3).
-define(PlayerVariant_Bit_OpenServer_LoginDay_5, 4).
-define(PlayerVariant_Bit_OpenServer_LoginDay_6, 5).
-define(PlayerVariant_Bit_OpenServer_LoginDay_7, 6).
-define(PlayerVariant_Bit_OpenServer_LoginDay_8, 7).
-define(PlayerVariant_Bit_OpenServer_LoginDay_9, 8).
-define(PlayerVariant_Bit_OpenServer_LoginDay_10, 9).
-define(PlayerVariant_Bit_OpenServer_LoginDay_11, 10).
-define(PlayerVariant_Bit_OpenServer_LoginDay_12, 11).
-define(PlayerVariant_Bit_OpenServer_LoginDay_13, 12).
-define(PlayerVariant_Bit_OpenServer_LoginDay_14, 13).
-define(PlayerVariant_Bit_OpenServer_LoginDay_15, 14).

-define(PlayerVariant_Index_Level_Award, 13). %% 等级奖励
-define(PlayerVariant_Bit_Level_20, 0).
-define(PlayerVariant_Bit_Level_30, 1).
-define(PlayerVariant_Bit_Level_40, 2).
-define(PlayerVariant_Bit_Level_50, 3).
-define(PlayerVariant_Bit_Level_60, 4).
-define(PlayerVariant_Bit_Level_70, 5).
-define(PlayerVariant_Bit_Level_80, 6).
-define(PlayerVariant_Bit_Level_90, 7).
-define(PlayerVariant_Bit_Level_100, 8).

-define(PlayerVariant_Index_Treasure_Score, 14). %% 玩家充值积分

-define(PlayerVariant_Index_VipLevel_GetAwardCan, 15). %% 玩家vip等级领奖是否可以领奖
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_1, 0).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_2, 1).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_3, 2).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_4, 3).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_5, 4).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_6, 5).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_7, 6).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_8, 7).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_9, 8).
-define(PlayerVariant_Bit_VipLevel_GetAwardCan_10, 9).

-define(PlayerVariant_Index_VipLevel_GetAward, 16). %% 玩家vip等级领奖是否已经领奖
-define(PlayerVariant_Bit_VipLevel_GetAward_1, 0).
-define(PlayerVariant_Bit_VipLevel_GetAward_2, 1).
-define(PlayerVariant_Bit_VipLevel_GetAward_3, 2).
-define(PlayerVariant_Bit_VipLevel_GetAward_4, 3).
-define(PlayerVariant_Bit_VipLevel_GetAward_5, 4).
-define(PlayerVariant_Bit_VipLevel_GetAward_6, 5).
-define(PlayerVariant_Bit_VipLevel_GetAward_7, 6).
-define(PlayerVariant_Bit_VipLevel_GetAward_8, 7).
-define(PlayerVariant_Bit_VipLevel_GetAward_9, 8).
-define(PlayerVariant_Bit_VipLevel_GetAward_10, 9).

-define(PlayerVariant_Index_TimeBox_Stage, 17).%% 时间宝箱在5-120的某个阶段

-define(PlayerVariant_Index_Escort, 18).%% 护送美女的标志位
-define(PlayerVariant_Bit_Escort_0, 0).%% 1号品质美女
-define(PlayerVariant_Bit_Escort_1, 1).%% 2号品质美女
-define(PlayerVariant_Bit_Escort_2, 2).%% 3号品质美女
-define(PlayerVariant_Bit_Escort_3, 3).%% 护送美女的状态

-define(PlayerVariant_Index_Escort_RefreshTimes, 19).%% 护送美女的刷新次数
-define(PlayerVariant_Index_Escort_Times, 20).%% 护送美女的次数
-define(PlayerVariant_Index_Escort_RobTimes, 21).%% 抢劫护送美女的次数
-define(PlayerVariant_Index_Escort_AwardPercent, 22).%% 护送美女获取奖励的千分比
-define(PlayerVariant_Index_Vip_GetAward, 23). %% 玩家vip领取奖励
-define(PlayerVariant_Bit_Vip_FirstAward_Can, 0). %% 是否已经首冲过
-define(PlayerVariant_Bit_Vip_FirstAward, 1). %% 是否领取过首冲奖励
-define(PlayerVariant_Bit_Vip_SevenDayPayBackAward, 2). %% 是否可以领取了今天的七日充值返利

-define(PlayerVariant_Index_Vip_TodayTotalPay, 24). %% 玩家当天充值金额

-define(PlayerVariant_Index_Sign_In_LastTime, 25). %%最后一次签到时间
-define(PlayerVariant_Index_Sign_In_Days, 26). %%签到
-define(PlayerVariant_Index_Again_Sign_In_Days_Cnt, 27). %%补签次数
-define(PlayerVariant_Index_Sign_In_Award, 28). %%签到奖励
-define(PlayerVariant_Index_NextGainManorAwardTime, 29).%% 下次领领地战奖励的时间的时间

-define(PlayerVariant_Index_Bit_Manager, 30).
-define(PlayerVariant_Index_Bit_Manager_0, 0). %%gm标识

-define(PlayerVariant_Index_Again_Sign_In_Days, 31). %%补签

-define(PlayerVariant_Index_SystemSet_Bit_Manager, 32). %%系统设置
-define(PlayerVariant_Index_SystemSet_Bit_Manager_Trade_0, 0). %%交易

-define(PlayerVariant_Index_Pay_Rebate, 33). %% 充值返利

-define(PlayerVariant_Index_Gem_smelt_value, 34). %% 宝石熔炼值

-define(PlayerVariant_Index_Vip_first_role, 35). %% uc vip 首创角
-define(PlayerVariant_Index_Vip_day_login, 36). %%  uc vip 每日登陆
-define(PlayerVariant_Index_Vip_first_pay, 37). %%  uc vip 首充值

-define(PlayerVariant_Index_Vip_FreeMine, 38). %%  免费的挖矿次数使用了的次数
-define(PlayerVariant_Index_Vip_FreeRicher, 39). %%  免费的摇钱次数使用了的次数
-define(PlayerVariant_Index_PrayValue, 40). %%  玩家当日祝福值
-define(PlayerVariant_Index_Campfire_DrinkOrEat_Times, 41). %%  免费的饮酒次数使用了的次数
-define(PlayerVariant_Index_PrayAuto, 42).  %%  玩家是否自动祝福

-define(PlayerVariant_Index_BitUse, 43).  %%  一次占用一个bit 下面是哪些bit被占用了
-define(PlayerVariant_Index_BitUse_UpdateGift, 1).%%是否领取更新有礼

-define(PlayerVariant_Index_KillPlayerNum, 44). %%玩家击杀别的玩家数量

-define(PlayerVariant_Index_Vip_EveryDayPayAward, 45). %% 玩家vip领取奖励
-define(PlayerVariant_Index_ShortCutItem, 46). %%使用物品快捷键
-define(PlayerVariant_Index_ServerActivityDay, 47). %%成就中使用的玩家创建角色第几天
-define(PlayerVariant_Rebate_Active_Flag, 48). %%完成充值返利活动标志

%% 2-- 是客户端服务器共享,只有玩家上线时要同步到client,  [Max_PlayerVariant_Syn_Client_Count+1,Max_PlayerVariant_Syn_Client_Count_OnlyOnline]
-define(PlayerVariant_Index_GuideHandStatus_P, 51).%%玩家新手引导的状态

%% 3:服务器专用 [Max_PlayerVariant_Syn_Client_Count_OnlyOnline,Max_PlayerVariant_Count-1]
-define(PlayerVariant_Index_CampfireAction_P, 61).%%玩家篝火活动中动作的时间
-define(PlayerVariant_Index_RushMission_LastStartTime, 62).%%闯天关上次进入时间
-define(PlayerVariant_Index_LastMapPos, 63).%%玩家上个地图的保存地址

-define(PlayerVariant_Index_TimeBox_Award, 64). %% 持续在线时间领奖
-define(PlayerVariant_Bit_TimeBox_5, 0). %% 持续在线时间5分钟领奖
-define(PlayerVariant_Bit_TimeBox_10, 1).
-define(PlayerVariant_Bit_TimeBox_30, 2).
-define(PlayerVariant_Bit_TimeBox_60, 3).
-define(PlayerVariant_Bit_TimeBox_120, 4).
-define(PlayerVariant_Bit_TimeBox_over, 5).
-define(PlayerVariant_Index_TimeBox_TimeStamp, 65).%% 时间宝箱阶段时间戳，用于跨天重置阶段为从5分钟开始
-define(PlayerVariant_Index_EscortBlackList, 66).%% 护送美女的黑名单
-define(PlayerVariant_Index_EscortLastRobTime, 67).%% 护送美女的上次抢劫的时间
-define(PlayerVariant_Index_GiftCode, 68).%% 激活码奖励
-define(PlayerVariant_Index_Arena_Win_Times, 69).%% 竞技场连胜次数

-define(PlayerVariant_Index_TimeBox_PassTime, 70).%% 玩家下线前累计的宝箱时间
-define(PlayerVariant_Index_VipEachPay_Award, 71). %% vip 单次 充值奖励
-define(PlayerVariant_Index_VipTodayTotalPay_Award, 72). %% vip 当天累计 充值奖励
-define(PlayerVariant_Index_VipTotalPay_Award, 73). %% vip 累计 充值奖励
-define(PlayerVariant_Index_Vip7DayTotalPay_Award, 74). %% vip 7日累计充值奖励
-define(PlayerVariant_Index_Vip7DayNowDay, 75). %% 当前在累计充值奖励的第几天
-define(PlayerVariant_Index_76_BanRelive, 76).%在设定的时间之内，禁止复活
-define(PlayerVariant_Index_77_Password, 77).%玩家的密码
-define(PlayerVariant_Index_78_PasswordEndTime, 78).%玩家的密码到期时间
-define(PlayerVariant_Index_79_Exchange, 79).%玩家物品兑换存档
-define(PlayerVariant_Index_DReward, 80). %是否发送过等级邮件奖励
-define(PlayerVariant_Bit_DReward_1, 1).  %等级奖励1
-define(PlayerVariant_Bit_DReward_2, 2).  %等级奖励2
-define(PlayerVariant_Bit_DReward_3, 3).  %等级奖励3
-define(PlayerVariant_Bit_DReward_4, 4).  %等级奖励4
-define(PlayerVariant_Bit_DReward_5, 5).  %等级奖励5

-define(PlayerVariant_Index_ClearTimes, 81).        %% 玩家每天扫荡次数
-define(PlayerVariant_Index_ChallengeTimes, 82). %% 玩家每天挑战次数
-define(PlayerVariant_Index_BuyChallengeTimes, 83). %%玩家每天可以购买的挑战次数
-define(PlayerVariant_Index_ArenaMax, 84).  %% 玩家竞技场历史最高排名

-define(PlayerVariant_Index_Last_UndergroundPalace_MapId, 85). %%之前进入的秦陵地宫活动地图ID， 保存好用于出地图后再进入， 活动结束后直接置位0

-define(PlayerVariant_Index_ServerActivity, 86). %%开服庆典

-define(PlayerVariant_Index_SpecialRing, 87). %%玩家戴过特殊戒指的标志
-define(PlayerVariant_Bit_SpecialRing_1, 0). %% 复活戒指
-define(PlayerVariant_Bit_SpecialRing_2, 1). %% 传送戒指
-define(PlayerVariant_Bit_SpecialRing_3, 2). %% 火球戒指
-define(PlayerVariant_Bit_SpecialRing_4, 3). %% 空间戒指
-define(PlayerVariant_Bit_SpecialRing_5, 4). %% 护身戒指
-define(PlayerVariant_Bit_SpecialRing_6, 5). %% 麻痹戒指
-define(PlayerVariant_Bit_SpecialRing_7, 6). %% 隐身戒指
-define(PlayerVariant_Bit_SpecialRing_8, 7). %% 吸血戒指
-define(PlayerVariant_Index_MineLucy, 88). %%玩家探矿Rate值
-define(PlayerVariant_Liveness_LunHuiCd, 89). %%玩家活跃度轮回CD
-define(PlayerVariant_Liveness_DiGongCd, 90). %%玩家活跃度地宫CD
-define(PlayerVariant_Rebate_Active_Time, 91). %%参加充值返利活动时间

-define(PlayerVariant_OpenServerPaymentAward, 93). %%开服7天充值返利数量
-define(PlayerVariant_EnteredNewbieCopyDataMapIdList, 94). %%新手副本，已经进入过的末日矿洞地图id

-define(PlayerVariant_MinHurtTims, 95). %%小狩猎次数
-define(PlayerVariant_MaxHurtTims, 96). %%大狩猎次数

-define(PlayerVariant_Index_SkillPoints, 97). %%玩家拥有的技能点
-define(PlayerVariant_Index_FuryValue, 98). %%玩家怒气值
-define(PlayerVariant_Index_Fury, 99). %%玩家怒气
-define(PlayerVariant_Index_Prestige, 100). %%玩家声望

-define(PlayerVariant_Index_Last_BattleQuartet_MapId,101). %%征战四方标志位
-define(PlayerVariant_Index_CampfireBuffDrink,102). %%喝酒buff
-define(PlayerVariant_Index_CampfireBuffEat,103). %%吃肉buff

-define(PlayerVariant_Index_EquipOpenHole_0,104). %% 装备开孔部位0
-define(PlayerVariant_Index_EquipOpenHole_1,105). %% 装备开孔部位1
-define(PlayerVariant_Index_EquipOpenHole_2,106). %% 装备开孔部位2
-define(PlayerVariant_Index_EquipOpenHole_3,107). %% 装备开孔部位3
-define(PlayerVariant_Index_EquipOpenHole_4,108). %% 装备开孔部位4
-define(PlayerVariant_Index_EquipOpenHole_5,109). %% 装备开孔部位5
-define(PlayerVariant_Index_EquipOpenHole_6,110). %% 装备开孔部位6
-define(PlayerVariant_Index_EquipOpenHole_7,111). %% 装备开孔部位7
-define(PlayerVariant_Index_EquipOpenHole_8,112). %% 装备开孔部位8
-define(PlayerVariant_Index_EquipOpenHole_9,113). %% 装备开孔部位9
-define(PlayerVariant_Index_EquipOpenHole_10,114). %% 装备开孔部位10
-define(PlayerVariant_Index_EquipOpenHole_11,115). %% 装备开孔部位11

-define(PlayerVariant_Index_LeagueSignin, 116). %%帮会签到

-define(PlayerVariant_Index_Impact_Level, 117). %% 冲级奖励领取

-define(PlayerVariant_Index_Wa_Kuang, 118). %% 每日挖矿次数

-define(PlayerVariant_Index_Masteries_Points, 119). %%天赋点
-define(PlayerVariant_Index_Masteries_List, 120). %%已经点击了的天赋id列表

-define(PlayerVariant_Index_GrowthFundIsBuy, 121). %% 是否购买成长基金标志
-define(PlayerVariant_Index_GrowthFundAward, 122). %% 成长基金奖励领取

-define(PlayerVariant_Index_TotalChargeAward, 123). %% 累计充值奖励领取

-define(PlayerVariant_Index_FirstRecharge, 124). %% 每日充值金额总和
-define(PlayerVariant_Index_LuxurySignInDays, 125). %% 豪华签道天数
-define(PlayerVariant_Index_LuxurySignInInfo, 126). %% 豪华签道，0-6位标识充值，7-13位标识是否领取

-define(PlayerVariant_Index_SevenDaysCheerSingle0, 127). %% 七天乐单项奖励领取标记0
-define(PlayerVariant_Index_SevenDaysCheerSingle1, 128). %% 七天乐单项奖励领取标记1
-define(PlayerVariant_Index_SevenDaysCheerSingle2, 129). %% 七天乐单项奖励领取标记2
-define(PlayerVariant_Index_SevenDaysCheerAward, 130). %% 七天乐单项完成度奖励领取

-define(PlayerVariant_Index_TotalLoginDays, 131). %% 累计登陆天数
-define(PlayerVariant_Index_TotalCostNonBindYuanBao, 132). %% 累计消耗非绑定元宝
-define(PlayerVariant_Index_NiMoCopy, 133). %% 参加逆魔次数
-define(PlayerVariant_Index_MagicDragonCopy, 134). %% 参加魔龙宝地次数
-define(PlayerVariant_Index_KillMonsterNum, 135). %% 杀怪数量
-define(PlayerVariant_Index_Vip_FreeDrink, 136). %% 征战四方已喝酒次数
-define(PlayerVariant_Index_Vip_FreeEat, 137). %% 征战四方已吃肉次数
-define(PlayerVariant_Index_DailyTaskNum, 138). %%每日已经接了的日常任务数量, 最多为10
-define(PlayerVariant_Index_GemCompose, 139). %% 合成宝石次数
-define(PlayerVariant_Index_EquipmentStrengthen, 140). %% 强化装备次数
-define(PlayerVariant_Index_EquipmentWash, 141). %% 洗练装备次数
-define(PlayerVariant_Index_Luck, 142). %% 幸运值
-define(PlayerVariant_Index_DoubleFirstPay, 143). %% 每一个充值项目


%%玩家充值礼包领取标志
%% -define( PlayerVariant_Index_CZLBLQ_P, 1 ).
%% %% 玩家充值礼包类型,每个类型对应第PlayerVariant_Index_CZLBLQ_P的玩家变量中的位
%% -define( RECHARGE_GIFT_BIT_0_P,0).
%% -define( RECHARGE_GIFT_BIT_1_P,1).
%% -define( RECHARGE_GIFT_BIT_2_P,2).
%% -define( RECHARGE_GIFT_BIT_3_P,3).
%% -define( RECHARGE_GIFT_BIT_4_P,4).
%% -define( RECHARGE_GIFT_BIT_5_P,5).
%% -define( RECHARGE_GIFT_BIT_6_P,6).
%% -define( RECHARGE_GIFT_BIT_7_P,7).
%% -define( RECHARGE_GIFT_BIT_8_P,8).
%% -define( RECHARGE_GIFT_BIT_9_P,9).
%% -define( RECHARGE_GIFT_BIT_10_P,10).
%% -define( RECHARGE_GIFT_BIT_11_P,11).
%% -define( RECHARGE_GIFT_BIT_12_P,12).
%% -define( RECHARGE_GIFT_BIT_13_P,13).
%% -define( RECHARGE_GIFT_BIT_14_P,14).
%% -define( RECHARGE_GIFT_BIT_15_P,15).
%% -define( RECHARGE_GIFT_MAX,16).
%% 


%%---------------------------------------------------玩家变量--------------------------------------------------------------
%% 
%% 
%% %%---------------------------------------------------世界变量--------------------------------------------------------------
%% %% 世界变量 (全局变量) 服务器存放在mainGlobal ets varArray, 不存档
%% %% 分为两类，1是客户端服务器共享；2是服务器专用
%% %%1---Max_WorldVariant_Syn_Client_Count, 客户端服务器共享，需要同步客户端
-define(WorldVariant_Activity_A, 1). %% 定时活动
-define(WorldVariant_Activity_A_Campfire, 0).  %%第一位表示篝火活动是否开启
-define(WorldVariant_Activity_A_Indiana, 1).  %%第二位表示夺宝奇兵活动是否开启
-define(WorldVariant_Activity_A_IndianaEntry, 2).  %%第3位表示夺宝奇兵活动入口是否开启
-define(WorldVariant_Activity_A_EquipEnvoy, 3).  %%第4位表示重装使者入口是否开启
-define(WorldVariant_Activity_A_LeagueCampfire, 4). %%行会篝火是否开启

%% -define( WorldVariant_Index_1_PeriodPkProt_Bit0,0).   %%是否处于定时pk保护模式，占用WorldVariant_Index_1值的第1位
%% -define( WorldVariant_Index_1_Active_Escort,1).   %%护送双倍提示，先占位，占用WorldVariant_Index_1值的第2位
%% -define( WorldVariant_Index_1_Active_Gather,2).   %%采集任务，占用WorldVariant_Index_1值的第3位
%% 
%% -define( WorldVariant_Index_2_BazzarUpdateTime, 2).		%%商城下一次刷新的时间
%% -define( WorldVariant__Num_Of_Player_Can_Join_Battle, 3).		%%能够参加战场的玩家数量

-define(WorldVariant_Activity_B, 2). %% 开服活动
-define(WorldVariant_Activity_B_Level, 0).  %%第一位表示等级活动是否开启


-define(WorldVariant_Pay_Rebate, 6). %%充值返利

-define(WorldVariant_Huang_Cheng_Zheng_Ba_LeagueId, 7).  %%皇城争霸获胜帮会id
-define(WorldVariant_Huang_Cheng_Zheng_Ba_Time, 8).
-define(WorldVariant_Huang_Cheng_Zheng_Owner_ID, 9).%%皇城争霸，拥有武器的人的ID，在删除武器的时候删这个人的
-define(WorldVariant_NewPlayer_GetFirstPay_State, 10). %% 新建玩家角色能否领取首充礼包

-define(WorldVariant_Highest_RushMission_Level, 11). %%闯天关最高层数
-define(WorldVariant_PayFlag, 12). %%
-define(WorldVariant_PayFlag_0, 0). %%是否打开充值
-define(WorldVariant_PayFlag_UrlIsRelease_1, 1). %%充值调试地址

-define(WorldVariant_IllWealth_Id, 13). %%当前使用的天降横财的配置
%% -define(WorldVariant_IllWealth_Total_Treasure, 14). %%当前天降横财已经配发的元宝总量
%% -define(WorldVariant_IllWealth_Total_Coin, 15). %%当前天降横财已经配发的金币总量

-define(WorldVariant_UndergroundPalace_Map_Line, 16). %% 秦岭地宫地图分线，获取已经创建了几张秦岭地宫地图

%%App充值返利
-define(WorldVariant_App_Rebate_BeginTime, 17). %%App充值返利活动开始时间
-define(WorldVariant_App_Rebate_EndTime, 18). %%App充值返利活动结束时间
-define(WorldVariant_App_Rebate_Ride, 19). %%App返利倍率

-define(WorldVariant_Charge_Award_Time, 20). %%聚宝盆， {开始时间， 结束时间}


%% 
%% %%2 Max_WorldVariant_Syn_Client_Count以上，服务器专用，不同步客户端, can save some not int32 var
%%-define(WorldVariant_Index_51,?Max_WorldVariant_Syn_Client_Count+1).
-define(WorldVariant_Index_51_IndianaTakeBox, 51). %% [{MapPid,PlayerIdWhoTakeItem}]
-define(WorldVariant_HuangCheng_Box_PlayerID, 52). %% 拿到玉玺的玩家id
%-define(WorldVariant_Index_52_IndianaTakeBoxTime,52).
%-define(WorldVariant_Index_53_IndianaBoxID,52).

-define(WorldVariant_BattleQuartet_Map_Line,54).

-endif.

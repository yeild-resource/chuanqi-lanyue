-ifndef(SERVERSTR_H).
-define(SERVERSTR_H, 1).
-define(ServerStr, serverStr:getStr).

-define(System, ?ServerStr(5)).

-define(Server_Str_Campfire_End10Seconds, ?ServerStr(1)).%%-define(Server_Str_Campfire_End10Seconds, "篝火酒宴将在十秒后结束。").
-define(Pet_Name_Connect_Str, ?ServerStr(2)).%%-define(Pet_Name_Connect_Str,"的").
-define(Mail_FirstAward_Title, ?ServerStr(3)).%%-define(Mail_FirstAward_Title, "首杀奖励").
-define(Mail_FirstAward_Content, ?ServerStr(4)).%%-define(Mail_FirstAward_Content, "首杀奖励").
-define(Mail_FirstAward_SendName, ?ServerStr(5)).%%-define(Mail_FirstAward_SendName, "系统").
-define(Mail_AwardFail_Title, ?ServerStr(6)).%%-define(Mail_AwardFail_Title, "副本奖励").
-define(Mail_AwardFail_Content, ?ServerStr(7)).%%-define(Mail_AwardFail_Content, "副本奖励").
-define(Mail_AwardFail_SendName, ?ServerStr(8)).%%-define(Mail_AwardFail_SendName, "系统").
-define(Mail_Kill_Title, ?ServerStr(9)).%%-define(Mail_Kill_Title, "仇杀提示").
-define(Mail_Kill_SendName, ?ServerStr(10)).%%-define(Mail_Kill_SendName, "系统").
-define(Huangcheng_SendName, ?ServerStr(11)).%%-define(Huangcheng_SendName, "系统").
-define(Huangcheng_Tittle, ?ServerStr(12)).%%-define(Huangcheng_Tittle, "皇城争霸奖励").
-define(Huangcheng_Tittle1, ?ServerStr(96)).%%-define(Huangcheng_Tittle, "皇城争霸会长奖励").
-define(Configure_Arena_Player_Name, ?ServerStr(13)).%%-define(Configure_Arena_Player_Name, "项伯熙"). %% 补位玩家name
-define(Use_Speed_Waigua, ?ServerStr(14)).%%"使用加速外挂"
-define(Team_Dot_Sign, ?ServerStr(81)).%% 一个顿号
-define(Resource_AwardPackage, ?ServerStr(82)).%%资源大礼包，下载完整资源包或资源包补丁即可获得
-define(Repeat_Login, ?ServerStr(112)). %%复复登陆
-define(Close_Server, ?ServerStr(113)). %%关服
-define(FightKillName, ?ServerStr(114)).

-define(Mail_ImpactLevelAward_Title, ?ServerStr(154)).
-define(Mail_ImpactLevelAward_Content, ?ServerStr(155)).

-define(Mail_GongChengAward_Title, ?ServerStr(156)).
-define(Mail_GongChengAward_Content, ?ServerStr(157)).

%%秦陵地宫邮件
-define(Mail_UndergroundPalace_Sender, ?ServerStr(5)).
-define(Mail_UndergroundPalace_DamageAward, ?ServerStr(88)).
-define(Mail_UndergroundPalace_LayerAward, ?ServerStr(87)).
-define(Mail_UndergroundPalace_ParticipationAward, ?ServerStr(86)).
-define(Mail_UndergroundPalace_Name, ?ServerStr(89)).
%%竞技场邮件奖励
-define(Mail_Arena_Title, ?ServerStr(23)). %%竞技场奖励物品
-define(Mail_Arena_NewRankRecordContent, ?ServerStr(90)). %%竞技场突破奖励
-define(Mail_Arena_Sender, ?ServerStr(91)). %%竞技场发放者  “竞技场”
-define(Arena_Robot_Message_Name, ?ServerStr(92)).
-define(Arena_Pet_Monster_Name, ?ServerStr(98)).

-define(LunHuiDao_Minutle, ?ServerStr(93)).
-define(LunHuiDao_Second, ?ServerStr(94)).

-define(HuangChengMailContent1, ?ServerStr(99)).
-define(HuangChengMailContent2, ?ServerStr(100)).
-define(HuangChengMailContent3, ?ServerStr(159)).
-define(ForBidChatMailContent, ?ServerStr(101)).
-define(ForBidChatMailContent2, ?ServerStr(144)).
-define(ForBidChatMailSendName, ?ServerStr(102)).
-define(ForBidChatMailTatile, ?ServerStr(103)).

%%-----------拍卖行-------------
-define(StMail_Sender, ?ServerStr(104)).
-define(StMail_DelItemTitle, ?ServerStr(105)).
-define(StMail_DelItemTimeOut, ?ServerStr(106)).
-define(StMail_DelItemSaler, ?ServerStr(107)).
-define(StMail_BuyItemTitle, ?ServerStr(108)).
-define(StMail_BuyItemContent, ?ServerStr(109)).
-define(StMail_SaleItemTitle, ?ServerStr(110)).
-define(StMail_SaleItemContent, ?ServerStr(111)).
%%-----------拍卖行-------------

%%---------社交系统--------------
-define(SocialSystem_NewFriend, ?ServerStr(115)).
%%---------社交系统--------------

%%--------光宇日志-------------
-define(PlayerLogMapType, ?ServerStr(116)). %%副本
-define(ServerStrPlayerAccecptTask, ?ServerStr(117)). %%接受任务
-define(ServerStrPlayerCompleteTask, ?ServerStr(118)). %%完成任务
-define(ServerStrPlayerCancelTask, ?ServerStr(119)). %%取消任务
-define(ServerStrPlayerTask, ?ServerStr(120)). %%任务
%%-------光宇日志--------------

%%---------战绩排行榜--------------
-define(KIllAwardSendName, ?ServerStr(11)).
-define(KIllAwardTitle, ?ServerStr(121)).
-define(KIllAwardText, ?ServerStr(122)).
%%---------战绩排行榜--------------

%%---------领地战--------------
-define(ManorbattleTitle, ?ServerStr(123)).
-define(ManorbattleText, ?ServerStr(124)).
-define(ManorbattleText1, ?ServerStr(125)).
%%---------下载奖励--------------
-define(DownGiftMail, ?ServerStr(126)).

-define(AppRelated, ?ServerStr(127)).

-define(OpenServerChargeAwardMailTitle, ?ServerStr(128)). %%聚宝盆
-define(OpenServerChargeAwardMailContents, ?ServerStr(129)). %%聚宝盆到期奖励
-define(OpenServerChargeAwardMailSender, ?ServerStr(130)). %%聚宝盆


-define(Zhaocai_Tittle, ?ServerStr(131)).%%招财宝
-define(Zhaocai_Sendname, ?ServerStr(132)).%%招财宝
-define(Zhaocai_Text, ?ServerStr(133)).%%招财宝


-define(LuckyMoneyWorldMessage1, ?ServerStr(134)).
-define(LuckyMoneyWorldMessage2, ?ServerStr(148)).
-define(LuckyMoneyWorldMessage3, ?ServerStr(149)).

%%杀人岛邮件
-define(Mail_KillingIsLand_Sender, ?ServerStr(5)).
-define(Mail_KillingIsLand_ScoreAward, ?ServerStr(142)).
-define(Mail_KillingIsLand_ParticipationAward, ?ServerStr(141)).
-define(Mail_KillingIsLand_Name, ?ServerStr(143)).

-endif.

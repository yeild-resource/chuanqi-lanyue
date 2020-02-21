-ifndef(tipStr_hrl).
-define(tipStr_hrl, 1).

-define(PlayerNotAroundTransport, 1).  %%您不在传送点位置或者地图人数已满
-define(PlayerBAGNOTENOUGHCANNOTMINE, 2).  %%背包已满，挖矿无法继续获取物品
-define(PlayerWithNpcDistTooLong, 3).  %%离此npc太远，请靠近
-define(PlayerBagNotEnoughNotCompose, 4).  %%背包已满，不能进行合成
-define(PlayerBagNotEnoughNotInlay, 5).  %%背包已满，不能进行镶嵌


-define(Team_OP_Result_Fail_TargetNotLeader, 6). %% 对方不是队长
-define(Team_OP_Result_Fail_HasTeamSelf, 7).  %%你已经有队
-define(Team_OP_Result_Fail_TargetHasTeam, 8).  %%对方已经有队
-define(Team_OP_Result_Fail_NeedTeamLeader, 9).  %%需要队长操作
-define(Team_OP_Result_Fail_NotOnline, 10).  %%对方不在线
-define(Team_OP_Result_Fail_ExistInvite, 11).  %%重复邀请
-define(Team_OP_Result_Fail_FullMember, 12).  %%队伍满员
-define(Team_OP_Result_Fail_RefuseCreate, 13).  %%对方拒绝组队
-define(Team_OP_Result_Fail_TeamhasDismiss, 14). %% 队伍已经解散
-define(Team_OP_Result_Fail_InviteExpired, 15). %% 此邀请已过期
-define(Team_OP_Result_Fail_NotInYourTeam, 16). %% 对方不在你的队伍中

-define(Trade_Req_Are_Busy, 17). %% 你处于忙碌，不能交易
-define(Trade_Ace_Are_Busy, 18). %% 对方处于忙碌，不能交易
-define(Trade_Distance_Far, 19). %% 距离太远，不能进行交易
-define(Trade_OP_Result_Fail_NotOnline, 20).  %%对方不在线或者距离不够
-define(Trade_OP_Result_Fail_NotFind, 21).  %%交易不存在，或者交易已过期
-define(Trade_OP_Other_Not_Lock, 22).  %%对方没有锁定物品，不能确定交易
-define(Trade_OP_Other_Reject, 23).  %%$$拒绝了你的交易请求

-define(Player_Not_In_Team_For_TeamCopy, 24).%%你没有队伍，禁止组队进入
-define(Player_Not_Team_Lead_For_TeamCopy, 25).%%请等待队长先进入副本
-define(Player_Not_Active_High_Copy, 26).%%此精英副本还没有激活
-define(Player_Level_Too_High, 27).%%你的等级太高
-define(Player_Level_Too_Low, 28).%%你的等级太低

-define(Player_Useup_CopyMap_Buy_times, 29).%%今日购买次数已用尽

-define(Equip_Luck_Upgrade_Over, 30).%%装备幸运值已经达到最大值
-define(Equip_Luck_Upgrade_MessageNoChange, 31).%%没有产生任何变化
-define(Equip_Luck_Upgrade_NoWeapon, 32).%%当前没有装备武器，无法获得祝福效果



-define(Bag_Full_When_Add_DrawLucky_Item, 33).  %%背包已满，抽奖获取物品掉落在地上
-define(Forbid_Buy_CopyBuff_When_Not_In_CopyMap, 34).  %%您不在副本中不能购买副本BUFF
-define(Forbid_Buy_CopyBuff_When_Owner_ThisBuff, 35).  %%您已经有这个副本BUFF，不能再购买
-define(Treasure_Not_Enough, 36). %%元宝不足
-define(Buy_CopyCD_Useup, 37). %%此副本可购买的CD用完，请明天再来进入此副本
-define(Already_Own_CopyBuff, 38). %%您已经有这个副本BUFF

-define(Item_Decompose_BagNotEnough, 39). %%分解物品背包不足

-define(Item_Pickup_OthersPickedIt, 40). %%很遗憾，此物品已被其它人拾走了
-define(Item_Pickup_Distance_Far, 41). %% 距离太远，不能拾取此物品
-define(Item_Pickup_BagIsFull, 42).  %%玩家背包已满，不能拾取此物品
-define(Item_Pickup_OtherPlayerOwn, 43).  %%此物品在其它玩家的保护期内，请过一会再试

-define(Buy_CopyMap_Success, 44).%%$$进入次数增加1次

-define(League_Copy_Map_Not_Opened, 45).%%帮会副本还没有开启
-define(League_Copy_Map_Not_League_Member, 46).%%您还不是帮会成员
-define(League_Copy_Map_Not_League_Leader, 47).%%您不是帮主
-define(League_Copy_Map_Already_Opened, 48).%%帮会副本已经开启
-define(League_Copy_Map_Open_Fail, 49).%%开启帮会副本失败
-define(Copy_Map_Aready_Finished, 50). %%副本正在关闭中，进入失败，请过几分钟再试
-define(League_Copy_Must_Stay_Long_Enough_To_Open, 3025). %%建立帮会%s小时之后才能开启帮会副本
-define(League_Copy_Must_Stay_Long_Enough_To_Enter, 3026). %%加入帮会%s小时之后才能进入帮会副本
-define(League_Already_A_League_Member, 3122). %%对方已经是帮会成员， 不能邀请
-define(League_Invitation_Refused, 3133). %%你拒绝了对方的入帮邀请
-define(League_Operation_Not_Permitted_In_Activity, 3134). %%在皇城争霸时间段内不能退帮、踢人、解散帮会
-define(League_Invitee_Refused, 3135). %% %s 拒绝了入帮申请
-define(League_Copy_Done, 3138). %% 挑战帮会副本成功
-define(League_Invitee_Level_Too_Low, 3140). %%对方等级达到30级才能邀请入帮
-define(League_Other_Not_Online, 10). %%对方不在线，无法邀请入帮


-define(Bag_Not_Enough_MineHouseCannotGet, 51). %%背包已满，无法提起物品
-define(Leave_Copy_Because_LeaveTeam, 52). %%您已不在队伍中，被传出组队副本
-define(Copy_Open_Tip_When_Add_Team_Member, 53). %%$$副本已开启，请尽快进入
-define(Item_IsEnough_CannotAdd, 54). %%空间戒指已经达到上限，无法继续获得
-define(Coin_IsEnough_RicherNotAdd, 55). %%游戏币数量达到上限
-define(Wheel_BagIsEnough_CannotAdd, 56). %%背包空间不足

-define(Chat_Time_Interval_Not_Enough, 57).  %%聊天太频繁，时间间隔不够
-define(Equip_Luck_Upgrade_MessageUp, 58).%%你的武器幸运值增加
-define(Equip_Luck_Upgrade_MessageDown, 59).%%你的武器被诅咒

-define(Skill_Attack_Mp_Not_Enough, 60). %%您的MP不够
-define(Skill_In_Public_CD, 61). %%技能还在公共CD中
-define(Skill_In_CD, 62). %%技能在CD中
-define(Skill_Dist_Too_Far, 63). %%超出技能攻击范围，请靠近
-define(Buy_Copy_Buff_Succeess, 64). %%天降神力，恭喜勇士攻击力增加百分之五十

-define(TipStr_Activity_Campfire_Dance, 65).%%xxx一时兴起跳起来肚皮舞，看煞旁人
-define(TipStr_Activity_Campfire_Sing, 66).%%xxx一时兴起唱起来最炫民族风，吓走了飞禽走兽
-define(TipStr_Activity_Campfire_Bitchy, 67).%%xxx忘记吃药了，又开始犯贱了

-define(TipStr_Activity_Indiana_StartPre30Ms, 68).%%【携带宝盒的白猪统领将在30分钟后出现在夺宝奇兵地图，宝盒会开出海量奖励哦！】
-define(TipStr_Activity_Indiana_StartPre10Ms, 69).%%【携带宝盒的白猪统领将在10分钟后出现在夺宝奇兵地图，宝盒会开出海量奖励哦！】
-define(TipStr_Activity_Indiana_Start, 70).%%【携带宝盒的白猪统领将已经出现在夺宝奇兵地图，赶紧进入夺宝奇兵抢夺吧！】
-define(TipStr_Activity_Indiana_Drop, 71).%%【宝盒掉落在夺宝地图999，999处！】
-define(TipStr_Activity_Indiana_Picked, 72).%%【宝盒被XXX拾取了！持续拥有10分钟后可以开启哦！】
-define(TipStr_Activity_Indiana_Open, 73).%%【XXX拥有了宝盒，夺宝奇兵活动结束！】
-define(TipStr_Activity_Indiana_NoneOpenOver, 74).%%【今天的夺宝奇兵结束了，没有人能保护宝盒10分钟！明天再来吧】

-define(TipStr_Activity_RushMission_ItemOnFloor, 75).%% 背包不足，闯天关首杀奖励已经放到地上
-define(TipStr_Activity_RushMission_ResetTimesIsOver, 76).%% 闯天关重置次数已用完
-define(TipStr_Activity_RushMission_StartTooFast, 77).%% 闯天关60秒不能再次进入，请稍等

-define(TipStr_Box_Opened, 78).%%【XXX开启了宝盒，获得了XXX奖励！】
-define(TipStr_Player_In_RushMission, 79).%%使用失败
-define(TipStr_Activity_RushMission_FirstAward, 80).%%XX越战越强，闯到第XX关

-define(TipStr_Copy_BuyBuff, 81).%%伟大的[%s]，让大家在帮会副本战斗中获得50%攻击加成效果。

-define(TipStr_Item_Use_DecPk_IsZero, 82).%%pk值已经为0，不需要消除
-define(TipStr_Item_Use_LuckyUpTo5, 83).%%玩家的武器幸运值升级到5
-define(TipStr_Item_Use_LuckyUpTo7, 84).%%玩家的武器幸运值升级到7
-define(TipStr_Copy_Completed_Notice, 85).%%通关组队副本
-define(TipStr_Copy_Unlock_High, 86).%%解锁精英副本

-define(Bag_Full_When_Open_Box_Item, 2471).  %%背包已满，打开宝箱获取物品掉落在地上
-define(TipStr_Activity_Campfire_StartPre30Ms, 88).%% 30分钟后开启篝火活动
-define(TipStr_Activity_Campfire_StartPre10Ms, 89).%% 10分钟后开启篝火活动
-define(TipStr_Activity_Campfire_StartPre5s, 90).%% 5秒钟后开启篝火活动

-define(Bag_Full_When_CompeleteTask, 91).  %%背包已满，不能提交任务
-define(Bag_Full_When_ActivityAward, 92).  %%背包已满，不能领取活动奖励

-define(TipStr_EnterCopyMap_Notice, 93).  %%使用全屏挂机打怪更轻松
-define(TipStr_CopyMap_Cannot_Use, 94).  %%副本中不能使用该物品

-define(TipStr_IndianaActivity_Cannot_UseTheSkill, 95).  %% 活动中，不能使用瞬移技能

-define(TipStr_RushMission_ResetTimesOver, 96).  %% 元宝不足，不能重置闯天关
-define(TipStr_ResetRushMission_Suc, 97).  %% 重置闯天关成功

-define(TipStr_ActivityLevelIsNotEnough_Campfire, 98).  %% 等级不足30级，不能参加篝火活动
-define(TipStr_ActivityLevelIsNotEnough_Indiana, 99).  %% 等级不足30级，不能参加夺宝奇兵活动
-define(TipStr_StoreBuy_Suc, 100).  %% 成功购买[道具名称][道具数量]个
-define(TipStr_Escort_RobTimes_IsEnough, 101).  %% 今日抢劫次数已经用完
-define(TipStr_Escort_IsTooFast, 102).  %% 5分钟请不要连续抢劫
-define(TipStr_Escort_Level_IsNotFit, 103).  %% 等级差不符合抢劫条件
-define(TipStr_Escort_Rob, 104).  %%在阳光的大道中，xxx横空出现，把xxx劫了个清光。
-define(TipStr_Escort_Rob_Beautity, 105).  %%xxx打劫了你的美女xxx
-define(TipStr_Escort_Cannot_Activity, 106).  %%护送美女中，无法参加活动
-define(TipStr_Escort_Cannot_TransferByNpc, 107).  %%护送美女中，无法从传送员进行传送
-define(TipStr_Escort_Cannot_EnterCopyMap, 108).  %%护送美女中，无法进入副本地图
-define(TipStr_RushMission_NoNeed_Reset, 109).  %%不需要重置闯天关
-define(TipStr_Trade_Bind_Cannot_Trade, 110).  %%绑定物品无法交易
-define(TipStr_Escort_Level_IsOk, 111).  %%等级不足，不能接受护送美女
-define(TipStr_Escort_TimesIsOver, 112).  %%今日不能再护送美女
-define(TipStr_StoreBuy_BagNotEnough, 113).  %%背包已满，购买失败
-define(TipStr_Indiana_TakeBox_CannotLeave, 114).  %%你携带宝箱不能离开
-define(TipStr_InDefenseMap_UseItemError, 115).  %%副本中禁止使用
-define(TipStr_GiftCode_NotFound, 116).  %%激活码错误，请检查后重新输入
-define(TipStr_GiftCode_RepeatByOther, 117).  %%此激活码已经被使用
-define(TipStr_GiftCode_Repeat, 118).  %% 你已经领取过该奖励
-define(TipStr_GiftCode_BagNotEnough, 119).  %% 您的背包空间不足，请整理背包后重试
-define(TipStr_TowerCode_GoldIsNotEnough, 120). %% 元宝扣除失败
-define(TipStr_ArenaCode_LevelNotEnough, 121). %% 等级不满35
-define(TipStr_ArenaCode_escort, 122). %% 护送美女
-define(TipStr_ItemUse_Escort, 123). %% 护送美女时，不能使用传送卷
-define(TipStr_RushMission_Escort, 124). %% 护送美女时，不能进入闯天关
-define(TipStr_Escort_Refresh_MoneyNotEnough, 125). %% 元宝不足，不能进行刷新
-define(TipStr_ItemSpaceRing_Cannot_SpaceRing, 126). %% 无法存放
-define(TipStr_Escort_Refresh_IsHighest, 127). %% 美女已经是最高品质，不能继续刷新
-define(TipStr_Escort_CannotEnter_Copy, 128). %% 护送美女时，不能进入仙魔副本
-define(TipStr_Equip_Strength_8_10, 129). %% 恭喜【%s】已将【%s】强化至【%s】级，宝刀在手，谁与争锋？
-define(TipStr_Equip_Strength_11_12, 130). %% 恭喜【%s】已将【%s】强化至【%s】级，神挡杀神，佛挡杀佛
-define(TipStr_Kill_People_5, 131). %% 谁来阻止他，勇士【玩家名】已经连续击杀5个敌人
-define(TipStr_Kill_People_8, 132). %% 【玩家名】已经无法无天了，连续击杀8个敌人

-define(Arena_Win_Time_Announce, 133). %% 竞技场连赢广播

-define(Player_ArmyNotice, 134). %% 你在%s被%s击杀：%s（时间）掉落物品：%s
-define(Player_ArmyNotOnLine, 135). %% 对方不在服务区

-define(TipStr_ArenaCode_busy, 136). %% 竞技场繁忙，重新进入
-define(TipStr_Pay_Rebate_Succ, 137). %% 充值返利成功

-define(TipStr_gem_exchange_Succ, 138). %% 兑换【XXX宝石】成功

-define(TipStr_Uc_Vip_not_Vip, 139). %% 非九游VIP不得领取
-define(TipStr_Uc_Vip_Has_Award, 140). %% 不得重复领取
-define(TipStr_Uc_Vip_Bag_Full, 141). %% 背包空间不足
-define(TipStr_Uc_Vip_not_pay, 143). %% 没有首充
-define(TipStr_Kill_Boss_Notice, 144).%%恭喜[XXX]将[XXX]成功击杀，获得大量珍贵道具

-define(CreateLeague_Succ_LeagueName, 2400).  %% 【XXX】帮会已经建立，欢迎勇士们加入
-define(CreateLeague_Fail_Player_Has_Join_League, 2401).  %% 你已加入帮会，无法创建
-define(CreateLeague_Fail_LeagueName_Len_illegal, 2402).  %% 长度不合理
-define(CreateLeague_Fail_LeagueName_Sensitive, 2403).  %% 敏感字符
-define(CreateLeague_Fail_LeagueName_Has_Exist, 2404).  %% 帮会名已经存在
-define(CreateLeague_Fail_Item_Not_Enough, 2405).  %% 袄玛号角不足
-define(CreateLeague_Fail_Coin_Not_Enough, 2406).  %% 游戏币不足

-define(LeagueInfo_Fail_Not_Found, 2407).    %% 没找到对应帮会
-define(LeagueInfoList_Fail_Not_Found, 2408).    %% 没有帮会列表

-define(JoinLeague_Fail_Player_Has_Join_League, 2409).  %% 玩家已经加入了帮会
-define(JoinLeague_Fail_League_Not_Found, 2410).   %% 帮会不存在
-define(JoinLeague_Fail_MaxMemberCount, 2411).               %% 帮会成员已满
-define(JoinLeague_Fail_MaxApplyCount, 2412).  %% 超过一天最多申请入帮次数

-define(AgreeJoin_Fail_Req_Has_Dispose, 2413).  %% 申请已被处理
-define(AgreeJoin_Fail_Player_Has_Join_League, 2414).  %% 对方已加入帮会

-define(ExitLeague_Fail_Leader, 2415).    %% 帮主不能退出帮会
-define(KickoutLeague_Fail_Player_Not_In_League, 2416). %% 被踢玩家不在帮会

-define(League_Player_Join_League, 2417). %% 欢迎[玩家名]加入本帮会，帮会变得越来越强大

-define(KickoutLeague_Player_Be_Kickout, 2418). %% [玩家名]被踢出帮会
-define(League_Player_Req_Exit_League, 2419). %% [玩家名]自动退出帮会

-define(League_Handle_Join_Player_Role_Error, 2420).   %% 你没有权限

-define(League_Appoint_Leader, 2421).     %% 【角色名】被任命为帮主
-define(League_Appoint_ViceLeader, 2422).     %% 【角色名】被任命为副帮主
-define(League_Appoint_Fail_Player_Role_Error, 2423).  %% 你没有权限
-define(League_Appoint_Already_ViceLeader, 3115). %%已经是副帮主
-define(League_Appoint_ViveLeader_AlreadyRemoved, 3116). %%已经不是副帮主了

-define(League_Change_Announcement, 2424).  %% 【%s】修改了本帮公告
-define(League_Change_Announcement_Fail_Role_Error, 2425).  %% 你没有权限

-define(JoinLeague_Fail_Apply_Handling, 2426).       %% 申请消息正在处理

-define(League_Appoint_ViceLeader_Fail_MaxViceLeaderCount, 2427).       %% 副帮主职位已满

-define(League_Remove_ViceLeader, 2428).         %% 【%s】被罢免副帮主
-define(League_Announcement_MaxLen, 2429).         %% 公告字符过长

-define(League_Player_Join_Succ, 2430).     %% 你加入了【%s】帮会
-define(League_Player_Be_RefuseJoin_League, 2431). %% 你被拒绝加入【%s】帮会
-define(League_Player_Be_Kick, 2432).    %% 你被踢出[帮会名]，不再是帮会的成员

-define(Req_Join_League_Ok, 2433).       %% 已成功申请加入帮会，请耐心等待
-define(League_Copy_Has_Open, 2434).     %% 帮会副本已经开启，大量宝物等你来拿，还在等什么？
-define(League_Max_Count, 2435).     %% 帮会已经创满
-define(League_Pk_State_Open, 2436).     %% XX帮会开启了对XX帮会的敌对关系，腥风血雨的战斗将持续2个小时
-define(League_Manor_Can_Attack, 2437).     %% 【%s】公会获得了【%s】领地的进攻资格。
-define(League_Manor_Win_Enroll, 2438).     %% 公会获得【%s】领地进攻权，战斗将于星期【%s】的【%s】点开始。
-define(League_Manor_Gain_Gold, 2439).     %% 帮主领取了【%s】元宝。
-define(League_Manor_Papre_Fight, 2440).     %% 领地战即将开始，请参加战斗的玩家做好准备！
-define(System_Set_Trade, 2441).     %% 对方拒绝交易

-define(League_Manor_EnrollWillStart, 2443).     %% 领地战报名要开始了
-define(League_Manor_EnrollWillEnd, 2444).     %% 领地战报名要结束了
-define(Unlay_Failed, 2445).  %% 背包已满不能卸下
-define(RushMissionFailed, 2446).


-define(SpaceRing_Is_Not_Trade, 2457). %%空间戒指不能交易


-define(Huang_Cheng_Zheng_Ba_10, 2458). %%开始前十分钟
-define(Huang_Cheng_Zheng_Ba_5, 2459). %%开始前五分钟
-define(Huang_Cheng_Zheng_Ba_Battle, 2460). %%开始战斗
-define(Huang_Cheng_Zheng_Ba_Win, 2461). %%最终胜利者
-define(Huang_Cheng_Zheng_Ba_Not_Exit_League, 2462). %%皇城争霸不能退出帮会
-define(Trans_Map_Forbidden, 2463). %%坐标不让传送

-define(Trans_Map_Forbidden_Huang_Cheng_Zheng_Ba, 2464). %%在皇城争霸活动中，不能进行传送

-define(GainRechargeTip, 2465). %%首冲奖励领取成功
-define(Equip_Cannot_Strength, 2466). %%城主武器不可强化

-define(BlackList_Already_Have, 2467). %%目标已在黑名单中
-define(BlackList_Limit, 2468). %%黑名单超过最大限制
-define(BlackList_Cannot_Speak, 2469). %%你已被列入黑名单，对方不能收到消息
-define(ShopPack_Cannot_Get, 2470). %%不能领取限购礼包
-define(EquipStrenthExchange_Succ, 2473). %%强化转移成功
-define(LeagueBuy_ScoreNotEngough, 2474). %%帮会商城购买道具，积分不足
-define(LeagueBuy_Succ, 2475).  %%帮会商城成功购买道具
-define(LeagueBuy_Upgrade, 2476). %%帮会商城升级
-define(BlackList_Add, 2477). %%成功加入黑名单
-define(ArmyPos_MapFail, 2478). %%打探对象不在合法地图
-define(LeageBuy_TimeFail, 2479). %%新入帮24小时内，不能使用商城
-define(LevelTooLowToChat, 142). %%低于46，不让发世界频道
-define(Coin_Not_Enough, 2481).  %%金币不足
-define(PayRelated_Succ, 2482).  %%领取充值奖励成功
-define(ExchangeItemBroadcast, 2483).  %%兑换装备公告
-define(ValentineComposeSucc, 2494).  %%巧果合成成功
-define(ValentineFlowerSucc, 2495).  %%赠予成功，魅力值获得提高
-define(ValentineFlowerFail, 2496).  %%玫瑰花不足，无法赠予
-define(PickupItemInProcted, 2498).  %%拾取的物品在保护中，不让拾取
-define(LeagueAward_NoGet, 2499).    %%新入帮会24小时才能领取帮会活动奖励
-define(EquipWingRepeat, 2500).    %%光翼只能装备一次
-define(UnquipWingError, 2501).    %%光翼不能卸载
-define(LimitItemError, 2502).      %%限时道具不能进行此类操作
-define(CopyCannotTrans, 2503).    %%特殊副本中，不能传送
-define(EquipWingMax, 2504).      %%光翼升阶至顶级
-define(MapFightTimeError, 2505).    %%对方玩家进入地图不足30秒，不能被攻击
-define(EquipWingUpgrade, 2507).    %%翅膀进阶公告
-define(EverydayGetReward, 2508).    %%成功领取每日必做奖励
-define(CampfireCding, 2509).      %%篝火动作冷却中
-define(EveryDayPayTip, 2510).    %%每日充值奖励领取成功

-define(SalesRoomErrorCdTime, 2600).    %% cd时间
-define(SalesRoomErrorItemInfoError, 2601).    %% 物品信息错误
-define(SalesRoomErrorSaleLimit, 2603).    %% 物品不能出售
-define(SalesRoomErrorNotVipPlayer, 2604).    %% 金币领取时，没有领取资格（只能是VIP玩家）
-define(SalesRoomErrorNotOwner, 2605).    %% 不是物品的归属者
-define(SalesRoomErrorBuySelfItem, 2606).    %% 不能购买自己的物品
-define(SalesRoomErrorTooMuchItem, 2607).    %% 寄售道具已达到上限，请领取过期道具或提升Vip等级(VIP )
-define(SalesRoomErrorLowPrice, 2608).    %% 输入价格不正确
-define(SalesRoomErrorTooMuchItemMax, 2609).    %% 寄售道具已达到上限(VIP10)
-define(UpgradeSkillLevelNotMatch, 2610).    %% 角色等级不足，不能学习该技能
-define(UpgradeSkillItemNotMatch, 2611).    %% 缺少【s%】技能书,不能学习该技能
-define(UpgradeSkillSuccsess, 2612).    %% 成功学习【%s】技能
-define(UpgradeSkillSkillPointsNotEnough, 3143). %%技能点不足, 不能升级技能

-define(ExploreErrorNotEnoughTimes, 2700).    %% 次数不足
-define(ExploreErrorNotEnoughResource, 2701).    %% 资源不足
-define(ExploreErrorLevelLimit, 2702).    %% 等级不足30级，不能参加挖矿
-define(ExploreErrorVip5, 2703).    %% vip5才能抽50次

-define(EquipAdvanceErrorCannot, 2800).    %% 此装备不能洗练
-define(EquipAdvanceErrorLevel, 2801).    %% 等级限制，50级以上的装备才能洗练
-define(EquipAdvanceErrorTop, 2802).    %% 装备星级已经达到顶级
-define(EquipAdvanceErrorMaterial, 2803).    %% 材料不足，材料等级必须和装备等级相同
-define(EquipAdvanceErrorUnlucky, 2804).    %% 洗练神符不足，请到商城购买
-define(EquipInheritErrorInfoWrong, 2805).    %% 装备继承信息错误
-define(EquipInheritErrorSecond, 2806).    %% 装备已经继承过，不能进行第二次继承
-define(EquipInheritErrorLevel, 2807).    %% 装备继承的等级不符
-define(EquipInheritErrorCareer, 2808).    %% 装备继承的职业不符
-define(EquipInheritErrorPlace, 2809).    %% 装备继承的部位不符
-define(EquipAdvanceErrorMore, 2810).    %% 洗练结果未保存，不能继续洗练
-define(EquipAdvanceGlobalNotify, 2811).    %% 恭喜【%s】将【%s】提升到10星级，获得超强战斗力
-define(EquipSureAdvanceNoRecord, 2812).    %% 保存洗练结果失败，没有洗练记录
-define(EquipReAdvanceNoRecord, 2813).    %% 重新洗练失败，没有上次洗练记录
-define(EquipEnvoyCopyOpen, 2814).    %% 重装使者地图已经开启，大量珍贵等你来拿
-define(EquipEnvoyCopyNotOpen, 2815).    %% 活动未开启
-define(EquipEnvoyCopy_UseItemError, 2816).    %% 重装使者副本中不能使用
-define(EquipEnvoyCopy_LevelError, 2817).    %% 50级才能进入重装使者
-define(EquipEnvoyCopy_PlayerEnter, 2818).    %% [角色名]已经进入[副本名]抢夺宝物，你还在等什么?
-define(SpecialMapCannotResponseArrow, 2819).    %% 特殊副本中不响应穿云箭
-define(EquipInsureCannotInsureBindedEquipment, 2820). %%绑定装备不能投保

-define(TipStr_Activity_RushMission_PleaseBuyChallengeTimes, 3000). %%挑战次数不够
-define(TipStr_Activity_RushMission_ChallengeTimesResetSucceeded, 3001). %%重置挑战次数成功
-define(TipStr_Activity_RushMission_ResetChallengeTimesWithoutCost, 3002). %% 闯关挑战次数已用完， 可以免费重置一次
-define(TipStr_Activity_RushMission_CannotChallengeAnymore, 3003). %% 今日挑战次数和购买挑战次数已经用完，不能再挑战闯天关
-define(TipStr_Activity_RushMission_CannotClear, 3021).                     %%每天只能扫荡一次， 不能再扫荡了
-define(TipStr_Activity_RushMission_CannotGetClearanceReward, 3022). %%不能获取通关奖励， 每打通5层可以获得通关奖励
-define(TipStr_Activity_RushMission_CannotGetToNextLevel, 3023). %% 击杀完本层所有怪才能进入下一层
-define(TipStr_Activity_RushMission_CannotClearWhenFirstMissionIsZero, 3112). %至少打过第一关， 才能进行扫荡
-define(TipStr_Activity_RushMission_CannotClearFirstMissionLessThanNowMission, 3137). %当前已是最高层不能进行扫荡
-define(TipStr_Activity_RushMission_ClearDone, 3139). %%扫荡成功

-define(TipStr_MoNiGongCheng_Map_Is_Not_Exit, 3004). %%模拟攻城地图不存在
-define(TipStr_MoNiGongCheng_Is_Not_In_Time, 3005). %%不在模拟攻城时间之内
-define(TipStr_MoNiGongCheng_Have_Team, 3006). %%有队伍不能进入模拟攻城中
-define(TipStr_MoNiGongCheng_Have_Enter, 3007). %%你已经进入过，不能再次进入
-define(TipStr_MoNiGongCheng_Finish, 3010). %%夜袭沙城活动结束

-define(TipStr_LunHuiDao_Map_Is_Not_Exit, 3011). %%轮回道地图不存在
-define(TipStr_LunHuiDao_Map_Cfg_Err, 3012). %%轮回道配制出错
-define(TipStr_LunHuiDao_Map_Is_Not_In_Time, 3013). %%不在轮回道活动时间之内
-define(TipStr_LunHuiDao_Pre_5Min, 145).  %%【轮回道副本将在5分钟后开启，请玩家做好进入准备！】
-define(TipStr_LunHuiDao_Start, 146).  %%【轮回道副本已经开启，各种BOSS已经出现，赶快进入击败！】
-define(TipStr_LunHuiDao_Pre_Second, 147).  %%【轮回道副本第一批BOSS已经全部被击败，第二批BOSS将在【%s】后出现！】
-define(TipStr_LunHuiDao_Second, 148).  %%【轮回道副本第二批BOSS已经出现，请抓紧时间！】
-define(TipStr_LunHuiDao_AllBoss_Dead, 149).  %%【轮回道副本BOSS已经全部被玩家击败！】
-define(TipStr_LunHuiDao_End, 150).  %%【轮回道副本已经结束，请等待下次的开放！】

-define(TipStr_Richer_Treasure_Not_Enough, 3014).  %%元宝不足
-define(TipStr_Richer_Times_Not_Enough, 3015).  %%次数不足，vip可获得更多次数
-define(TipStr_ActivityClose_Indiana1, 3016).  %%夺宝奇兵活动未开启
-define(TipStr_ActivityClose_Indiana2, 3018).  %%夺宝奇兵活动入口已经关闭，请明天再来
-define(TipStr_ActivityClose_Indiana3, 3019).  %%夺宝奇兵活动已经结束，请明天再来


%%%%%%%%%%%%%%秦陵地宫开始%%%%%%%%%%%%%%%%%%%%
-define(TipStr_UndergroundPalace_NotInEnterTime, 3017). %%
%%%%%%%%%%%%%%秦陵地宫结束%%%%%%%%%%%


-define(TipStr_LunHuiDao_MonsterDead, 3020). %%沙巴克守卫已全部死亡，玩家将在15秒后传出副本

-define(TipStr_Tempt, 3024). %%你已有宠物，不能再诱惑宠物

-define(TipStr_HuangCheng_Drop, 3101).%%【玉玺掉落在地图的%s，%s处！】
-define(TipStr_HuangCheng_Picked, 3102).%%【玉玺被%s拾取了！】
-define(TipStr_HuangCheng_Msg0, 3103).%%【%s】击杀【%s】，获得了第一滴血
-define(TipStr_HuangCheng_Msg3, 3104).%%【%s】正在大杀特杀
-define(TipStr_HuangCheng_Msg4, 3105).%%【%s】已经暴走
-define(TipStr_HuangCheng_Msg5, 3106).%%【%s】已经无人能挡
-define(TipStr_HuangCheng_Msg6, 3107).%%【%s】已经主宰比赛
-define(TipStr_HuangCheng_Msg7, 3108).%%【%s】]似神一般的存在
-define(TipStr_HuangCheng_Msg8, 3109).%%【%s】已经超越神一般的存在

-define(TipStr_AddTeamFailed_InBlack, 3113). %%
-define(TipStr_TradeFailed_InBlack, 3114).

-define(TipStr_TradeFailed_Bag_Error, 3117).%%背包已满，交易失败

-define(TipStr_HuangCheng_Transer_Error, 3118).%%活动中，请从活动入口进入地图
-define(TipStr_AllPlayerLeaveHuangCheng, 3119). %%沙城争霸即将已开启，请勇士们从活动入口进入沙巴克
-define(TipStr_Player_Max, 3120). %%地图人数已满
-define(TipStr_LeaguePlayer_Max, 3121). %%该地图您公会人数已达上限


%%-----------------天降横财 开始-------------------------------
-define(TipStr_IllWealth_Opening, 3123). %%正在打开宝箱，~p秒后开启宝箱
-define(TipStr_IllWealth_Being_Opened_By_Others, 3124). %% 不能打开这个宝箱，其他玩家正在开启这个宝箱
-define(TipStr_IllWealth_Box_Opened, 3126). %%宝箱已经打开， 请自行拾取
-define(TipStr_IllWealth_Open_Process_Interrupted, 3127). %%宝箱开启被打断
-define(TipStr_IllWealth_Announcement, 2497). %%活动开启标识
-define(TipStr_IllWealth_Bag_Full, 3129). %%背包已满， 不能开启宝箱
-define(TipStr_IllWealth_Cannot_Open_Other_When_Opening_One, 3130). %%正在开宝箱， 不能再开其他宝箱
-define(TipStr_IllWealth_LevelTooLow, 3131).


%%%%%%%%%%%天降横财 结束%%%%%%%%%%%%%%%

-define(TipStr_BossQuery, 3128). %%金币不足，不能查询

-define(TipStr_EnterCopy_NotSingle, 3132). %%你在队伍中，不能进入单人副本

-define(TipStr_HuangChengOnwer_online, 3136). %%伟大的沙城霸主[%s]上线了，大家欢呼吧！

-define(TipStr_UsedGrowGift, 3141).

%%副本进入条件判断
-define(TipStr_EnterCopy_TeamNotAllReady, 3145). %%有队伍成员没有准备或不在世界地图，不能进入组队副本
-define(TipStr_EnterCopy_ItemNotEnough, 3144). %%所需道具不足，不能进入副本
-define(TipStr_EnterCopy_NotInTeam, 3146). %%你不在队伍中，不能进入组队副本

-define(TipStr_BattleQuartet_NotInEnterTime,3155). %%不在征战四方活动时间之内

%% ======= 冲级达人 =======
-define(TipStr_ImpactLevel_ActivityEnd, 3220).  %% 冲级达人活动结束，不可领取奖励
-define(TipStr_BagFull_NotGetImpactLevel, 3172). %% 背包已满，无法领取冲级达人奖励
-define(TipStr_ImpactLevelIsEmpty, 3173). %% 该冲级奖励已被抢光了
-define(TipStr_ImpactLevelAwardGot, 3174). %% 已领取该冲级奖励

-define(TipStr_Item_Not_Exist, 3218). %% 系统没有该道具！
-define(TipStr_Bag_Full, 3219). %% 背包已满！背包已满！背包已满！

%% ======= 成长基金 =======
-define(TipStr_CannotBuyGrowthFund_YuanBaoLess, 3196). %% 元宝不够，不可购买成长基金
-define(TipStr_CannotBuyGrowthFund_HadBuy, 3197).      %% 你已购买过成长基金，不可重复购买
-define(TipStr_CannotBuyGrowthFund_VIPLess, 3198).     %% VIP等级未满足要求，不可购买成长基金
-define(TipStr_CannotYuanBaoGrowthFund_NotBuyFund, 3199). %% 你未购买成长基金元宝，不可领取元宝
-define(TipStr_CannotYuanBaoGrowthFund_HadGet, 3200).     %% 你已领取成长基金元宝，不可重复领取
-define(TipStr_CannotYuanBaoGrowthFund_LevelLess, 3201).  %% 未满足领取条件，不可领取元宝

%% ======= 累计充值 =======
-define(TipStr_TotalChargeAward_ActivityEnd, 3203).  %% 	累计充值活动结束，不可领取奖励
-define(TipStr_TotalChargeAward_ChargeLess, 3204).  %%   不满足累计充值领取条件，不可领取奖励
-define(TipStr_TotalChargeAward_HadGet, 3205).  %% 	你已领取累计充值奖励，不可重复领取
-define(TipStr_TotalChargeAward_BagFull, 3206).  %% 	背包已满，无法领取累计充值奖励

%% ======= 夺宝奇兵 =======
-define(TipStr_ExchangeWord_ActivityEnd, 3207).  %% 	夺宝奇兵活动结束，不可进行兑换
-define(TipStr_ExchangeWord_NotSatisfy, 3208).  %% 	不满足夺宝奇兵兑换条件
-define(TipStr_ExchangeWord_BagFull, 3209).  %% 	背包已满，不可兑换奖励
-define(TipStr_ExchangeWord_DelItemFail, 3210).  %% 	夺宝奇兵道具扣除失败，不可兑换奖励

%% ======= 全民Boss =======
-define(TipStr_QuanMinBoss_ActivityEnd, 3213).  %% 全民boss活动结束，不可进行兑换
-define(TipStr_QuanMinBoss_NotSatisfy, 3214).  %% 不满足全民boss兑换条件
-define(TipStr_QuanMinBoss_BagFull, 3215).  %% 背包已满，不可兑换全民boss奖励
-define(TipStr_QuanMinBoss_DelItemFail, 3216).  %% 全民boss道具扣除失败，不可兑换奖励

%% ======= 豪华签到 =======
-define(TipStr_LuxurySignin_HadGet, 3195).  %% 你已领取豪华签到奖励，不可重复领取
-define(TipStr_LuxurySignin_BagFull, 3217).  %% 背包已满，不可领取豪华签到奖励
-define(TipStr_LuxurySignin_NotRechange, 3194).  %% 今日还未充值， 不能领取豪华签到奖励！

%% ======= 新服七天乐 =======
-define(TipStr_SevenDaysCheer_Over, 3221).  %% 七天乐活动结束，不可领奖
-define(TipStr_SevenDaysCheer_SubNotOpen, 3222).  %% 七天乐子活动尚未开启，不可领奖
-define(TipStr_SevenDaysCheer_SubNotSatisfy, 3223).  %% 七天乐子活动不满足领取条件，不可领奖
-define(TipStr_SevenDaysCheer_HaveGet, 3224).  %% 你已领取七天乐奖励，不可重复领取
-define(TipStr_SevenDaysCheer_AchNotSatisfy, 3225).  %% 完成度不满足领取条件，不可领奖
-define(TipStr_SevenDaysCheer_AchHaveGet, 3226).  %% 你已领取七天乐完成度奖励，不可重复领取
-define(TipStr_SevenDaysCheer_SingleBagFull, 3227).  %% 背包已满，无法领取七天乐单项奖励
-define(TipStr_SevenDaysCheer_AchBagFull, 3228).  %% 背包已满，无法领取七天乐完成度奖励

%% ======= 帮会相关=======
-define(TipStr_LeagueSignIn_BagFull, 3230).  %% 背包已满，无法领取帮会签到奖励
-define(TipStr_LeagueManifestoAlter, 3233). %% %s修改了行会宣言
-define(TipStr_LeagueCannotEscortSelf, 3234). %% 现在我方无法攻击NPC了
-define(TipStr_LeagueEscortYouCannotGet, 3239). %% 会长才能领取打劫任务
-define(TipStr_LeagueEscortBeautyCannotRob, 3240). %% 该美女不能抢

%% ======= 道具合成 =======
-define(TipStr_ItemCompound_NotSatisfy, 3237).  %% 不满足道具合成条件
-define(TipStr_ItemCompound_DeductFail, 3238).  %% 道具扣除失败，无法合成

%% ======= 辉耀石熔炼 =======
-define(TipStr_Huiyaoshi_Smelt_BagFull, 3249).  %% 背包已满，不能进行熔炼

-endif.


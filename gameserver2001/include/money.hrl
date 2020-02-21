-ifndef(money_hrl).

-define(money_hrl, 1).

%%玩家最大钱数量，包括金币、绑定金币、元宝、绑定元宝
-define(Max_Money, 999999999).

%%玩家充值RMD兑换游戏元宝的比例
-define(RMB_TREASURE_RATIO, 10).

-define(Treasure_Type_Flag, 1).  %%玩家充值
-define(Treasure_Type_Flag_System, 0). %%系统赠送元宝


%%钱类型Money_Type
-define(Money_None, -1).%%不能出售
-define(Money_Coin, 0).%%	//	金币
-define(Money_BindCoin, 1).%%	//	绑定金币
-define(Money_Treasure, 2).%%	//	元宝
-define(Money_BindTreasure, 3).%%	//	绑定元宝
-define(Money_jifen, 4).%%	//	探矿的积分
-define(Money_LeagueContribution, 5). %% 帮会贡献
-define(Money_Count, 6).

%%钱变化原因Money_Change_Reason
%%商城购买道具，直接使用道具基础ID，后台统计需求 2014-09-10
-define(Money_Change_SellItem, 1). %% sell item
-define(Money_Change_Strength, 2). %% strength equip
-define(Money_Change_GM, 3). %% gm
-define(Money_Change_Compose, 4). %%compose
-define(Money_Change_NpcBuy, 5). %%商店购买物品
-define(Money_Change_Trade, 6). %%交易
-define(Money_Change_Task, 7).  %% 任务
-define(Money_Change_BuyCopyDrawLucky, 8). %%购买副本抽奖次数
-define(Money_Change_BuyCopyBuff, 9). %%购买副本BUFF
-define(Money_Change_BuyCopyCd, 10). %%购买副本CD
-define(Money_Change_MonsterDrop, 11). %%刷怪掉落
-define(Money_Change_CreateLeague, 12). %%创建帮会
-define(Money_Change_RecoverLife, 13). %%复活
-define(Money_Change_MineLucky, 14). %%探矿
-define(Money_Change_Richer, 15). %%摇钱树
-define(Money_Change_Wheel, 16). %%转盘
-define(Money_Change_UseItem, 17). %%使用道具
-define(Money_Change_CampfireDrink, 18). %%篝火饮酒
-define(Money_Change_Pay, 19). %%支付充值
-define(Money_Change_LuckyUpgrade, 20). %%提升祝福
-define(Money_Change_JingYingMap, 21). %%精英地图
-define(Money_Change_LevelActivity, 22).%%等级活动
-define(Money_Change_RushMissionReset, 23).%%闯天关重置扣除元宝
-define(Money_Change_StoreBuy, 24). %%商城购买物品
-define(Money_Change_EscortRefreshOnce, 25). %%护送美女刷新一次
-define(Money_Change_EscortRefreshAll, 26). %%护送美女一键刷新
-define(Money_Change_Escort_Award, 27). %%护送美女获取奖励
-define(Money_Change_Escort_RobAward, 28). %%护送美女获取奖励
-define(Money_Change_TowerDefenseCopy_Award, 29). %%护送美女获取奖励
-define(Money_Change_TowerDefenseCopy_RecoverNpc, 30). %%复活NPC消耗
-define(Money_Change_VipBuy, 31). %%vip 快速购买
-define(Money_Change_VipSevenDayBack, 32). %%vip七天返利
-define(Money_Change_OpenLeaguePk, 33). %%开启帮会Pk
-define(Money_Change_AgainSignIn, 34). %%补签
-define(Money_Change_EnrollManorBattle, 35). %报名领地战
-define(Money_Change_ManorBattleGaveBack, 36). %领地战报名退回
-define(Money_Change_ManorBattleGain, 37). %领地战领取
-define(Money_Change_BuyBuff, 38). %报名领地战
-define(Money_Change_Pay_Rebate, 39). %%充值返利
-define(Money_Change_Gem_exchange, 40). %%宝石兑换
-define(Money_Change_Strength_Exchange, 41). %%强化转移
-define(Money_Change_Shop_Limit, 42). %%商城限时礼包
-define(Money_Change_Army_Pos, 43). %%打探令
-define(Money_Change_Equip_Insure, 44). %%装备投保
-define(Money_Change_Seven_Star, 45). %%北斗七星
-define(Money_Change_Exchange, 46). %%兑换物品花的钱
-define(Money_Change_Valentine, 47). %%七夕、建军节活动
-define(Money_Change_Wing_Upgrade, 48). %%光翼进阶
-define(Money_Change_SaleTradeTip, 49). %% 拍卖行寄售物品保管费
-define(Money_Change_SaleTradeCost, 50). %% 拍卖行购买物品
-define(Money_Change_SaleGet, 51). %% 拍卖所得(走邮件)
-define(Money_Change_EasyExp, 52). %% 泡点房
-define(Money_Change_LuckyExploreReset, 53). %% 幸运探矿重置
-define(Money_Change_MysteryExploreReset, 54). %% 神秘探矿重置
-define(Money_Change_EquipAdvance, 55). %% 装备洗练消耗元宝
-define(Money_Change_EquipReAdvance, 56). %% 装备重新洗练消耗元宝
-define(Money_Change_EquipInherit, 57). %% 装备继承消耗的元宝
-define(Money_Change_EquipEnvoyMap, 58). %%重装使者地图消耗
-define(Money_Change_RushMission, 59). %%闯天关获得
-define(Money_Change_CancelInsurance, 60).         %%装备撤保获得
-define(Money_Change_Arena, 61).                           %%竞技场每场挑战获得绑定金币
-define(Money_Change_Offline, 62).  %%离线经验
-define(Money_Change_ServerActivity, 63).%%开服庆典
-define(Money_Change_Firstpay, 64).%%首冲赠送绑定元宝
-define(Money_Change_Campfire_EatMeat, 65). %%篝火吃肉
-define(Money_Change_BossQuery, 66). %%boss查询
-define(Money_Change_Add_GeziNum, 67). %%购买格子
-define(Money_Change_Mail, 68). %%邮件
-define(Money_Change_Invite, 69). %%邀请
-define(Money_Change_LimitBuy, 70). %%限时购买
-define(Money_Change_OpenServerAward, 71). %%开服充值返绑定元宝
-define(Money_Change_Zhaocai_Buy, 72). %%购买招财宝
-define(Money_Change_Chat, 73). %%世界频道发言%% -define( Money_Change_Equip, 0 ).%%	//	装备激活
-define(Money_Change_GrewGift, 74). %%成长礼包
-define(Money_Change_LuckyMoney, 75). %%红包
-define(Money_Change_LeagueFund, 76). %%帮会捐献
-define(Money_Change_LeagueBoss_Inspire, 77). %%帮会BOSS鼓舞
-define(Money_Change_MedalUpgrade, 78). %%勋章升级
-define(Money_Change_EquipPromote, 79). %%装备进阶
-define(Money_Change_LeagueBattleBid, 80). %% 帮会战元宝封地
-define(Money_Change_Escort, 81). %%美女护送
-define(Money_Change_EquipOpenHole, 82). %% 装备开孔
-define(Money_Change_BuyGrowthFund, 83). %% 购买成长基金
-define(Money_Change_GrowthFundGet, 84). %% 领取成长基金元宝
-define(Money_Change_SevenDaysCheerGet, 85). %% 领取新服七天乐奖励
-define(Money_Change_NpcTransfer, 86). %%NPC传送使用元宝

-endif.

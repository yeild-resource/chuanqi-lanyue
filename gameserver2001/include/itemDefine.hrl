-ifndef(itemDefine_hrl).

-define(itemDefine_hrl, 1).

-include("itemLog.hrl").

-record(item, {
  id = 0, %% 物品全服唯一ID
  itemDataId = 0, %%item data id,can get item cfg by this id
  count = 0,
  flag = 0, %%一些标志位
  stars = 0, %% 强化(即升星)
  %% 装备的随机属性约定为 [{属性ID,属性值},{属性ID,属性值},{属性ID,属性值},{属性ID,属性值},{属性ID,属性值},{属性ID,属性值},{属性ID,属性值} ] 这种形式
  equipRandAttrArray = [],%% 装备的随机属性
  fujiaRandAttrArray = [],%% 装备的附加属性
  itemArrayForSpaceRing = undefined,%% 空间戒指增加的空间
  luck = 0,
  curse = 0, %%诅咒(只有武器才有，杀人时增加)
  crit = 0,   %%致命一击(装备生成的时候，随机一个值，后续洗练？)
  promoteLevel = 0, %%装备进阶等级, 增加装备基础属性百分比
  insuranceTimes = 0,  %%投保次数
  expiretime = 0,
  processValue = 0 %%进度值
}).

-record(cdTimeUseItem, {id = 0, time = 0, totalTime = 0}).

-define(Item_Can_Total, 1).%%可以批量使用
-define(Item_Can_Not_Total, 0).%%不可以批量使用

-define(Item_Sort_Type, [{1, 5}, {2, 4}, {3, 3}, {4, 1}, {5, 2}]).
-define(Item_Sort_Type_Max, 10).

-define(Item_EquipOn, 1).
-define(Item_UnEquip, 0).


-define(Item_Type_Normal, 1).%普通道具 1
-define(Item_Type_Enchase, 2).%附加镶嵌类道具2
-define(Item_Type_Equip, 3).%装备类3
-define(Item_Type_Consume, 4).%消耗类4
-define(Item_Type_Medicine, 5).%药品类5
-define(Item_Type_Task, 6).%任务道具


-define(Item_Bag_Type_Bag, 1). %背包
-define(Item_Bag_Type_EquipOn, 2). %玩家身上
-define(Item_Bag_Type_WareHouse, 3). %仓库
-define(Item_Bag_Type_LeftSpaceRing, 4). %左手空间戒指
-define(Item_Bag_Type_RightSpaceRing, 5). %右手空间戒指
-define(Item_Bag_Type_MineWareHouse, 6). %探矿仓库

%%通知客户端物品属性的变化
-define(Item_Change_NOTICE, 1). %物品变化，及时通知
-define(Item_Change_Not_NOTICE, 0). %物品变化，不及时通知
-define(Item_Change_Type_Cnt, 1). %数量的变化
-define(Item_Change_Type_Stars, 2). %装备强化等级的变化
-define(Item_Change_Type_Luck, 3). %装备幸运值的的变化
-define(Item_Change_Type_Curse, 4). %装备诅咒值的的变化
-define(Item_Change_Type_Insurance, 5). %%装备投保次数的变化
-define(Item_Change_Type_Advance, 6). %%装备洗炼属性的变化
-define(Item_Change_Type_ProcessValue, 7). %%进度值发生变化
-define(Item_Change_Type_Fujia, 8). %%装备随机附加属性的改变
-define(Item_Change_Type_Promote, 9). %%装备进阶属性的变化


-define(Curse_Value_Max, 9). %诅咒值最大值
-define(Lucky_Value_Max, 9). %幸运值最大值

%%物品的绑定值
-define(Item_Bind_Type_UnBind, 0).
-define(Item_Bind_Type_Bind, 1).
-define(Item_Bind_Type_None, -1).

%%装备幸运值的提升类型
-define(Item_Luck_Upgrade_Normal, 1).
-define(Item_Luck_Upgrade_Super, 2).

%%物品使用的数量
-define(ITEM_USE_COUNT, 1).

%%物品使用的类型
-define(Item_Use_Type_None, 0). %%无附加效果
-define(Item_Use_Type_Buff, 1). %%Buff增加的效果
-define(Item_Use_Type_Skill, 2). %%技能书
-define(Item_Use_Type_Transfer, 3). %%传送卷轴
-define(Item_Use_Type_FuHuo, 4). %%复活令
-define(Item_Use_Type_CreateBangHui, 5). %%创建帮会所需道具
-define(Item_Use_Type_Luck, 6). %%祝福油
-define(Item_Use_Type_Decompose, 7). %%分解
-define(Item_Use_Type_Box, 9). %%箱子
-define(Item_Use_Type_Gold, 10). %%元宝
-define(Item_Use_Type_Exp, 11). %%经验丹
-define(Item_Use_Type_DecPk, 12). %%消除pk值
-define(Item_Use_Type_Arrow, 15). %%穿云箭
-define(Item_Use_Type_SpaceRing, 16). %%空间戒指
-define(Item_Use_Type_GrowGift, 17). %%成长礼包
-define(Item_Use_Type_League_Boss_Exp, 18). %%帮会BOSS, 圣兽培养
-define(Item_Use_Type_League_Boss_Inpire_Pills, 19). %%帮会BOSS, 圣兽技能培养丹
-define(Item_Use_Type_Fury, 20). %%玩家自身怒气
-define(Item_Use_Type_Prestige, 21). %%玩家声望
-define(Item_Use_Type_LeagueContribution, 22). %%帮派贡献
-define(Item_Use_Type_SkillPoints,23). %%技能点
-define(Item_Use_Type_Unbeatable, 24). %% 无敌
-define(Item_Use_Type_Treasure_Score, 25). %% 淘宝礼券(增加积分)
-define(Item_Use_Type_AddBagNum, 26). %%增加背包格子
-define(Item_Use_Type_AddWareHouse, 27). %%增加仓库格子

%%传送卷
-define(Item_Use_Type_ChS_HuiCheng, 1). %%回城卷
-define(Item_Use_Type_ChS_SuiJiHuiCheng, 2). %%随机回城卷
-define(Item_Use_Type_ChS_HangHuiCheng, 3). %%行会传送卷
-define(Item_Use_Type_TransferToAnywhere, 4). %%随便传送到哪里

%%宝石类
-define(Item_Use_Type_Stone_PhyAttack, 4). %%物理攻击
-define(Item_Use_Type_Stone_MagAttack, 5). %%魔法攻击
-define(Item_Use_Type_Stone_DowAttack, 6). %%道法攻击
-define(Item_Use_Type_Stone_MagDefence, 7). %%魔法防御
-define(Item_Use_Type_Stone_PhyDefence, 8). %%物理防御

%%技能书类 

-define(Equip_CfgPlace_Cloth, 0). %衣服， 盔甲
-define(Equip_CfgPlace_Weapon, 1). %武器
-define(Equip_CfgPlace_Necklace, 2). %项链
-define(Equip_CfgPlace_Hand, 3).% 手镯
-define(Equip_CfgPlace_Finger, 4).%戒指


-define(Equip_Part_Cloth, 0). %衣服， 盔甲
-define(Equip_Part_Weapon, 1). %武器
-define(Equip_Part_Necklace, 2). %项链
-define(Equip_Part_LeftHand, 3).%左手 手镯
-define(Equip_Part_RightHand, 4).%右手
-define(Equip_Part_LeftFinger, 5).%左手指 戒指
-define(Equip_Part_RightFinger, 6).%右手指
-define(Equip_Part_Wing, 7).%光翼
-define(Equip_Part_Helmet, 8). %%头盔
-define(Equip_Part_Belt, 9). %%腰带
-define(Equip_Part_Shoes, 10). %%鞋子
-define(Equip_Part_Medal, 11). %%勋章
-define(Equip_Part_Count, 12).
-define(Equip_Part_Stone_Num, 4). %%每个装备位置的宝石个数

-define(Equip_Part_List, [0,1,2,3,4,5,6,8,9,10]).

%%特殊戒指的分类 IsMpReplaceHp,IsBenumb,IsHideForRing,IsSuckHp
-define(Ring_Type_FuHuo, 1). %%复活戒指
-define(Ring_Type_ChuanSong, 2). %%传送戒指
-define(Ring_Type_Skill, 3). %%火球戒指
-define(Ring_Type_Space, 4). %%空间戒指
-define(Ring_Type_MpReplaceHp, 5). %%护身戒指 MpReplaceHp
-define(Ring_Type_Benumb, 6). %%麻痹戒指 Benumb
-define(Ring_Type_Hide, 7). %%隐身戒指 HideFor
-define(Ring_Type_SuckHp, 8). %%吸血戒指 SuckHp

-define(Equip_Strength_Type_Item, 1). %%强化装备只使用物品
-define(Equip_Strength_Type_Yubao, 2). %%强化装备使用物品,没有时使用元宝
-define(Equip_Strength_Max, 20). %%强化装备的最高等级

-define(Equip_Strength_Exchange_Need_star, 6). %%强化转移需要装备强化等级

-define(Ret_Type_Strength_Once, 0). %%强化一次
-define(Ret_Type_Strength, 1). %%一键强化
-define(Ret_Type_Strength_Exchange, 2). %%强化转移

-define(Zhufu_Use_money, 1).%%使用元宝祝福
-define(Zhufu_Not_Use_money, 0).%%使用祝福油祝福

-define(Zhufu_Use_ItemID, 50004).%%祝福油id

-define(Zhufu_Place_EquipOn, 1).%%被祝福的武器在身上
-define(Zhufu_Place_bag, 2).%%被祝福的武器在背包

-define(Bag_FreeGridNum, 48).
-define(Bag_MaxGridNum, 100).
-define(WareHouse_GridNum, 40). %%仓库的容量
-define(SpaceRing_GridNum, 16). %%空间戒指的容量
-define(MineWareHouse_GridNum, 200). %%探矿仓库的容量
-define(GridNum_None, -1). %%不限制物品的数量

-define(Item_SpaceRing_Num, 10). %%玩家可以获取的空间戒指的数量

%% 绑定值的定义如下所示
%% 1为绑定， 0为不绑定
-define(Drop_Item_Bind_Flag, 0). %%1为绑定， 0为不绑定
-define(WAKUANG_INTERVAL_TIME_BIND_FLAG, 0).%%挖矿掉落物品的绑定值
-define(Vip_EveryDay_Bind, 1).%%vip每日领取的奖励
-define(RushMissionFirstAward_Bind, 1).%%闯天关首杀奖励
-define(Arena_Award_Bind, 1). %% 竞技场奖励
-define(Vip_FirstPay_Award, 1). %% vip 首充值奖励


%%物品使用的限定问题
-define(Item_Use_Limit_Indiana, [{3}]).


%%天降横财特殊宝箱ID
-define(IllWealthItemDataId, 60009).
-define(IllWealthItemPickupSeconds, 10).
-define(IllWealthAllTreasure, 500).
-define(IllWealthAllCoin, 2000000).

-define(Item_Id_Transfer_Ring, 50052). %% 传送戒指物品编号
-define(Item_Id_BossGhost, 39403). %% 统领之魂物品编号

-endif. 


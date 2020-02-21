-ifndef(__EXCEL_DEFINE_HRL__).
-define(__EXCEL_DEFINE_HRL__, 1).

-define(Item_Coin_Litte, 65000). %%小量金币
-define(Item_Coin_Middle, 65001). %%中量金币
-define(Item_Coin_Large, 65002). %%大量金币

-define(Item_Coin_Litte_Bind, 65003). %%小量绑定金币
-define(Item_Coin_Middle_Bind, 65004). %%中量绑定金币
-define(Item_Coin_Large_Bind, 65005). %%大量绑定金币


-define(Item_Mine_Item, 50059). %%矿膏

-define(Item_SpaceRing, 50057). %%空间戒指

-define(Skill_Type_HuoQiu, 200). %%普通火球术
-define(Skill_Type_Strong_HuoQiu, 211). %%强化火球术

-define(Pet_KuLou_Base_Data_Id, 2000). %% 骷髅ID的起始值
-define(Pet_MythicalAnimal_Base_Data_Id, 3000). %% 神兽ID的起始值


-define(Copy_Buff_Data_Id, 110). %% 副本BUFF的ID
-define(League_Copy_Buff_Data_Id, 111). %%帮会副本的BUFF的ID

-define(Recovertoken_Item_Data_Id, 50002). %%复活令
-define(RecoverRing_Item_Data_Id, 50051).%%复活机制

-define(Activity_Indiana_DropBoxItemId, 70003).  %%夺宝奇兵活动掉落宝箱ID
-define(HuangChang_DropItemId, 9998).  %%皇城争霸掉落道具ID

-define(Activity_Campfire_MapDataId, 5033).  %%篝火活动地图
-define(Activity_Indiana_MapDataId, 3000).  %%夺宝奇兵活动地图
-define(Activity_KillingIsLand_MapDataId, 5041).  %%决战杀人岛活动地图
-define(Activity_RushMission_MapDataId, 5034).  %%闯天关的地图
-define(Activity_UnknownPalace_MapDataId, 5036). %%未知暗殿单人副本

-define(Activity_LunHuiDao_MapDataId, 3010). %%轮回道
-define(Activity_MoNiGongCheng_MapDataId, 5090). %%模拟攻城
-define(Active_EasyExp_MapDataID, -1).

-define(TowerDefenseCopy_MapDataId, 3002).  %%禁地守护地图id
-define(ArenaCopy_MapDataId, 3003).  %%竞技场地图id
-define(EquipEnvoyCopy_MapDataId1, 9001).  %%重装使者地图id
-define(EquipEnvoyCopy_MapDataId2, 9002).  %%重装使者地图id
-define(EquipEnvoyCopy_MapDataId3, 9003).  %%重装使者地图id
-define(MagicDragonTreasureCopy_MapDataId, 5038).  %%魔龙宝地地图id
-define(NiMoMapIdList, [5055,5056,5057,5058,5059,5060,5061,5062]). %% 逆魔mapID列表
-define(ChuMoMapIdList, [5081,5082,5083,5084,5085,5086,5087,5088]). %% 除魔mapID列表
-define(LeagueCopyIdList, [2000,2001]). %% 帮会副本ID列表

-define(Huangcheng_1, 7001).%%皇城地图ID
-define(Huangcheng_2, 7002).
-define(Huangcheng_3, 7003).

-define(GuardCopy_SingleMapDataId, 8100).  %%守护地图ID
-define(GuardCopy_TeamMapDataId, 8100).  %%守护地图ID

-define(NORMAL_ATTACK_ID, 100).    %%% 普通攻击技能ID
-define(GSJF_Skill_IDList, [405, 406, 407, 408, 409]).    %%% 攻杀剑法技能ID

-define(Benumb_BufferId_For_Tempt, 137).%%诱惑之光触发麻痹后，添加的buff id

%%data_activity 
-define(Data_Activity_Id_RushMission, 40). %%连续


-define(Hide_Buff_Data_Id, 531). %%隐身的buff data id

-define(Jingying_Map_DataId, 11). %% 精英地图的地图ID
-define(Jingying_Map_ItemDataId, 50060). %% 精英地图的消耗物品


-define(Tower_Data_Id_InTowerDefenseCopy, 1901).
-define(VirtualPlayer_Data_Id_InArenaCopy, 1902).
-define(VirtualMythicalAnimal_Data_Id_InArenaCopy, 1909).


%% must modify
-define(Tower_Pos_InTowerDefenseCopy, {53, 29}).

-define(VirtualPlayer_Pos_InArenaCopy, {20, 20}).


-define(DefenseZhanshi_Data_Id_InTowerDefenseCopy, 1401).
-define(DefenseDaoshi_Data_Id_InTowerDefenseCopy, 1409).
-define(DefenseFashi_Data_Id_InTowerDefenseCopy, 1417).
-define(DefensePet_Data_Id_InTowerDefenseCopy, 1425).


-define(Skill_Poisoning, 301).  %% 施毒术
-define(Buff_Poisoning_duration, 15000). %% 施毒术BUFF持续时间
-define(Skill_Magic_dun, 209).  %% 施毒术
-define(Buff_Magic_dun_duration, 120000). %% 施毒术BUFF持续时间

-define(Manor_Broadcast_TimeID, 6001).%%领地战广播，用哪个配置

-define(UpdageGift_Item, 10001).

-define(Item_Chuansong, 50052).


-endif.



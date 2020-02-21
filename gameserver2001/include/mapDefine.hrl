-ifndef(mapDefine_hrl).

-define(mapDefine_hrl, 1).
-include("excelDefine.hrl").
-define(TileMapFileFormat, ".tmf").
-define(TileMapFileVersion, 10001).

-define(Map_PosOutOfMap_Index, -1).

%%地图类型
-define(Map_Type_Normal_World, 1).%% 世界地图
-define(Map_Type_Normal_Copy, 2).  %% 普通副本地图
-define(Map_Type_High_Copy, 3).  %% 精英副本地图
-define(Map_Type_League_Copy, 4).  %% 帮会副本地图
-define(Map_Type_Manor_Battle, 5).  %% 领地战地图
-define(Map_Type_Huang_Cheng_Zheng_Ba, 7).  %%皇城争霸
-define(Map_Type_EquipEnvy_Copy, 8).  %% 重装使者副本地图
-define(Map_Type_MoNiGongCheng_Copy, 9). %%模拟攻城地图
-define(Map_Type_LunHuiDao_Copy, 10). %%轮回道
-define(Map_Type_UndergroundPalace_Copy, 11). %%秦陵地宫
-define(Map_Type_LeagueBattle_Copy, 12). %%帮会战

-define(Enter_Type_Normal, 0).
-define(Enter_Copy_Type_Single, 1).
-define(Enter_Copy_Type_Team, 2).
-define(Enter_Copy_Type_League, 3).
-define(Enter_Type_Copy_Manor, 4).%领地地图
-define(Enter_Type_Copy_Huang_Cheng_Zheng_Ba, 6). %%皇城争霸
-define(Enter_Type_Copy_MoNiGongCheng, 7). %%模拟攻城
-define(Enter_Type_Copy_LunHuiDao, 8). %%轮回道
-define(Enter_Type_Copy_UndergroundPalace, 9). %%秦陵地宫
-define(Enter_Type_Copy_Hurt, 10). %%狩猎地图

-define(NextAddKillScoreTime, 1800).%%下一次能增加战绩值的时间

%%物体类型 最大值 16#1F
%%物体类型，玩家
-define(Object_Type_Player, 1).
%%物体类型，npc
-define(Object_Type_Npc, 2).
%%物体类型，monster
-define(Object_Type_Monster, 3).
%%物件类型，传送点
-define(Object_Type_TRANSPORT, 4).
%%物件类型，地图
-define(Object_Type_Map, 5).
%%物件类型，物品
-define(Object_Type_Item, 6).
%%物体类型，系统
-define(Object_Type_System, 7).
%%物件类型，队伍
-define(Object_Type_Team, 8).
%%物件类型，交易
-define(Object_Type_Trade, 9).
%%物件类型，帮会
-define(Object_Type_League, 10).
%%物件类型，pet
-define(Object_Type_Pet, 11).

%%物件类型，陷阱
-define(Object_Type_Trap, 12).
%%物体类型，守护monster
-define(Object_Type_DefenseMonster, 13).
%% 物体类型
-define(Object_Type_VirtualPlayerMonster, 14).
%%邮件
-define(Object_Type_Mail, 15).


%% 地图区域定义
-define(Map_Region_Mine, 1).  %% 挖矿
-define(Map_Region_Peace, 2).  %% 安全区
%%-define(Map_Region_Mine_Stand, 3).  %% 挖矿玩家站立区域

%%全局物件ID
-define(Global_Object_System_ID, 1).

%% 地图战斗进程定时器
-define(Map_Fight_Buffer_Timer, 100).
-define(Map_Fight_Pk_Timer, 60000).


%% 计时器定义
-define(Map_AI_Timer, 400).    %% 地图MonsterAI更新计时器
-define(Map_AI_Spawn_Timer, (timer:seconds(1)) ).  %% 地图刷怪计时器
-define(Map_AI_Countdown_Timer, 5000). %% 倒计时5秒刷怪（魔龙宝地）

-define(Map_Monster_Move_Timer, 250).  %% 地图monster移动跟新计时器
-define(Map_Monster_Move_Frames_PerSec, 4).%% 1000 div ?Map_Monster_Move_Timer



-define(Drop_Item_Protect_Sec, 60). %%怪物掉落的物品有一分钟（待定）的保护期
-define(Map_Drop_Item_Expire_Remain_Sec, 300). %% 掉落到地图的物品在地图上保留的时间,unit: second
-define(Map_Item_Expire_Timer, 30 * 1000).  %% 30 seconds
-define(Map_Trap_Trigger_Timer, 1000).  %%  1 seconds if trap cfg table(interval) change it, please change it


%%地图Player移动跟新计时器
-define(Map_PlayerOrPet_Move_Timer, 100).     %% 应该设置为能被1000整除 由125调整到100
-define(Map_PlayerOrPet_Move_Frames_PerSec, 10).%% 1000 div ?Map_Player_Move_Timer
-define(Check_Block_Distance, 1).

%%地图生命秒回更新计时器
-define(Map_LifeRecover_Timer, 2000).
%%地图无人检测计时器
-define(Map_NoPlayer_Timer, (timer:seconds( 60 )) ).   %% unit:毫秒
%%副本无人多少时间后销毁地图 unit:seconds  玩家在副本中掉线，60秒内登陆游戏，副本仍然存在, 也许应该设大点
-define(CopyMap_NoPlayer_Destroy_Time, 180). %% 3分钟

%%地图向组队通信更新计时器
-define(Map_PlayerPosUpdate_Timer, 1000 * 5).

%%地图准备进入玩家更新计时器
-define(Map_Player_Ready_Enter_Timer, 5000).

%%地图像素格子宽度
-define(Map_Pixel_Title_Width, 64).
-define(Map_Pixel_Title_Width_SQ, ?Map_Pixel_Title_Width * ?Map_Pixel_Title_Width).

%%地图像素格子高度
-define(Map_Pixel_Title_Height, 40).

%%进程攻击距离
-define(Melee_Attack_Dist, ?Map_Pixel_Title_Width * 2).
%%进程攻击距离SQ
-define(Melee_Attack_DistSQ, ?Melee_Attack_Dist * ?Melee_Attack_Dist).

%%远程攻击距离
-define(Shoot_Attack_Dist, ?Map_Pixel_Title_Width * 5).
%%远程攻击距离SQ
-define(Shoot_Attack_DistSQ, ?Shoot_Attack_Dist * ?Shoot_Attack_Dist).

%%objectMoveState
-define(Object_MoveState_Stand, 0). %%站立
-define(Object_MoveState_Moving, 1). %%移动中

-define(Jingying_Map_ItemNum, 1). %% 精英地图的消耗物品的数量
-define(Jingying_Map_Treasure, 10). %% 精英地图的消耗元宝的数量

-define(MAP_TILE_FLAG_PHY, 1).   %%物理层


%%物件对象记录公共索引
-define(object_id_index, 2).
-define(object_event_index, 3).
-define(object_type_index, 4).
-define(object_table_index, 5).
-define(object_timer_index, 6).

%%怪物刷新模式
-define(Monster_Refresh_Mode_Interval, 1).    %% 时间间隔刷怪
-define(Monster_Refresh_Mode_Time, 2).    %% 每天定时刷新
-define(Monster_Refresh_Mode_OnlyOnce, 3).    %% 不会刷出新怪，怪物只初始化一次
-define(Monster_Refresh_Mode_FixTime, 4).    %% 按照北京时间固定刷新
-define(Monster_Refresh_Mode_WildBoss, 5).     %%时间间隔加开始结束时间刷怪
-define(Monster_Refresh_Mode_CopyBoss, 6).     %%本地图其它怪死亡后刷怪

%%地图实例
-record(mapMap, {id,
                 objType,
                 map_data_id,
                 enterType,
                 ownerID, %% ownerID can be player id or team id or league id
                 %% 1) for league copy map, if the league copy is finished,then set true, will forbid player enter it 2) 如果是其它副本，可以进入，但不扣cd
                 isFinished = false,
                 onlineplayers = 0,
                 mapPid = 0,
                 mapFightPid = 0,
                 mapAIPid = 0,
                 mapBroadcastPid,
                 mapPlayerEts,
                 mapMonsterEts,
                 mapNpcEts,
                 mapItemEts,
                 mapOtherEts,
                 mapPetEts,
                 mapFightPlayerEts,
                 mapFightMonsterEts,
                 mapFightPetEts,
                 lineNum = 1}).

%%地图View信息
-record(mapView, {map_data_id,
                  width,
                  height,
                  width9CellCount,
                  height9CellCount,
                  originX,
                  originY,
                  logicCellNumX,
                  logicCellNumY,
                  phyArraySize,
                  phyArray,
                  logicTo9cellIndexArraySize,
                  logicTo9cellIndexArray,
                  aroundCellIndexArray,
                  npcList,
                  monsterList,
                  doorList,
                  regionList}).

%%地图区域属性信息
-record(mapRegionProperty, {name, value}).

%%地图上传送门信息
-record(mapDoor, {x, y, cx, cy, mapId, mapLogicX, mapLogicY}).

%%地图上npc出生信息
-record(mapNpcSpawn, {x, y, typeId}).

%%地图上npc出生信息
-record(mapAIRefresh, {id, isdead, nextTime}).

%%地图上monster出生信息
-record(mapMonsterSpawn, {x, y, cx, cy, typeId, minCount, maxCount, mode, interval, leagueID = 0, startTime = 0, endTime = 0}).

%% spawnInfo when monster dead
-record(itemListSpawnInfo, {ownerId = 0,
                            deadMonsterPos, %% #posInfo
                            itemIdCntList = [],   %%[{dataId,cnt,bind}]
                            protectingSeconds = 0,
                            existingSeconds = 30,
                            systemStringCode = 0
}).
%% spawInfo when player dead
-record(itemListSpawnInfoPlayerDead, {
  deadPlayerPos, %% #posInfo
  itemList   %%[#item]
}).

-record(itemSpawnSingle, {itemID, itemNum, binded, posx, posy, ownerId, banGetTime, existsTime}).


%%地图区域信息
-record(mapRegion, {x, y, cx, cy, flag}).

-record(posInfo, {x=0, y=0}).

%% 地图monster产生器
-record(mapMonsterSpawner, {id, x, y, cx, cy, typeId,
                            count = 0,     %%current  count
                            minCount = 0, %% min count, when current count < minCount, will spawn count-minCount monsters
                            maxCount = 0, %% max count,(ie. initial count)
                            mode = 1,     %% spawm mode, per interval or per day
                            interval = 1000, %% unit: second, 如果mode为per day, interval是一个时间点，如每天的4点（4*60*60）
                            nextTime = 0,  %% 下次把monster刷新到maxCount个
                            leagueID = 0,
                            startTime = 0,
                            endTime = 0
}).

%% npc，怪物创建信息
-record(mapSpawn, {spawnId,%%刷怪器id
                   x, y,
                   typeId,%% data it,在配置文件中的id
                   instanceId,  %% 分配的唯一id
                   leagueID = 0, %%league 目前就怪有用
                   name = ""
}).


%% 地图玩家实例,地图移动进程管理
-record(mapPlayer, {id,
                    objType,
                    pid,
                    sendPid,
                    name,
                    leagueName,
                    career,
                    sex,
                    level,
                    pos,
                    weapon,
                    coat,
                    escortBeautyId = 0,%%护送的美女id
                    moveTargetList,
                    moveState,
                    speed,
                    speedX,
                    speedY, %% move distance per frame
                    isForbidMove = false,%% when 死亡,麻痹, set isForbidMove = true, when 复活，取消麻痹  set isForbidMove = f
                    titleId = 0,
                    vipLevel = 0,
                    gmFlag = 0,
                    varArray,
                    lastMoveTime = 0,%上次移动时间，GMT 毫秒
                    fightingCapacity = 0,
                    ucVipLevel = 0,
                    wing = 0,
                    robotModule = 0,  %% 0表示人 _:表示机器人模型ID
                    trapIdList = [],
                    gathering = 0,
                    enteredTimestamp = 0 %%上次进入这个地图的时间戳
}).

%% 战斗属性记录
-record(mapFightProperties, {hpMax = 0,
                             mpMax = 0,
                             lucky = 0,
                             curse = 0,
                             atkMin = 0,
                             atkMax = 0,
                             magicAtkMin = 0,
                             magicAtkMax = 0,
                             dowAtkMin = 0,
                             dowAtkMax = 0,
                             defMin = 0,
                             defMax = 0,
                             magicDefMin = 0,
                             magicDefMax = 0,
                             hitRate = 0,
                             missRate = 0,%%万分数，取值为0至10000
                             aspeed = 0,
                             crit = 0,
                             cancelDamagePercent = 0,  %%抵消的伤害百分数
                             harm = 0%%额外增加的伤害，以及伤害百分比
}).

%% 地图玩家实例，地图战斗进程管理,怪物和玩家共用该记录结构
-record(mapFightPlayer, {id,
                         objType,
                         pid,
                         sendPid,
                         spawnerId = 0,
                         stateFlag = 0,        %% 状态标志
                         dataId = 0,
                         deadTime = 0, %%死亡时间，unit: second
                         career = 0,
                         level = 0,
                         hp = 0,
                         mp = 0,
                         pk = 0,
                         pkState = 0,  %% 当前血量和魔法
                         fury = 0,
                         furyValue = 0,
                         leagueId = 0, %% 帮会 add by xjl,也对怪物有效果
                         passitiveSkillIdList = [],
                         buffList = [],    %% BUFF列表，
                         fightProperties = #mapFightProperties{},    %% 战斗属性总值
                         fightPropertiesBase = #mapFightProperties{},    %% 战斗属性基础值
                         fightPropertiesEquipment = #mapFightProperties{},  %% 装备增加属性
                         fightPropertiesEquipmentPercent = #mapFightProperties{},%% 装备增加属性百分比
                         fightPropertiesEnchase = #mapFightProperties{},    %% 宝石增加属性
                         fightPropertiesEnchasePercent = #mapFightProperties{},  %% 宝石增加属性百分比
                         fightPropertiesSkill = #mapFightProperties{},    %% 技能增加属性
                         fightPropertiesSkillPercent = #mapFightProperties{},  %% 技能增加属性
                         fightPropertiesBuff = #mapFightProperties{},    %% BUFF增加属性
                         fightPropertiesBuffPercent = #mapFightProperties{},  %% BUFF增加属性百分比
                         fightingCapacity = 0, %% 战斗力 add by xjl
                         fightPropertiesStar = #mapFightProperties{},  %% 北斗七星增加属性
                         fightPropertiesStarPercent = #mapFightProperties{},%% 北斗七星增加属性百分比
                         fightPropertiesTitle = #mapFightProperties{},  %% 称号增加属性
                         fightPropertiesTitlePercent = #mapFightProperties{},%% 称号增加属性百分比
                         fightPropertiesLeague = #mapFightProperties{}, %%行会技能增加属性
                         fightPropertiesLeaguePercent = #mapFightProperties{}, %%行会技能增加属性百分比
                         fightPropertiesMasteries = #mapFightProperties{},     %%天赋树增加属性
                         fightPropertiesMasteriesPercent = #mapFightProperties{}, %%天赋树增加属性百分比
                         fightPropertiesFury = #mapFightProperties{}, %%怒气属性值
                         fightPropertiesFuryPercent = #mapFightProperties{}, %%怒气属性百分比
                         %% the below fields is related to equip
                         isMpReplaceHp = false, %% put up 护身 ring, will change the field
                         isTriggerBenumb = false, %%  put up 	麻痹 ring, will change the field
                         isHideForRing = false, %% put up 	隐身 ring, will change the field
                         isSuckHp = false,   %% put up 吸血 ring, will change the field
                         isRecoverLife = false,%%put up 复活 ring, will change the field
                         nextRecoverTime = 0, %% the next recover time
                         masterId = 0,        %% if it's pet, masterId is valid,
                         nextKillTime = 0 %%下次被杀击杀方能获得战绩的时间
}).

%% 地图monster实例，地图移动进程管理
-record(mapMonster, {id,
                     objType,
                     monster_data_id,
                     spawnId,
                     level,
                     moveState,
                     pos,
                     moveTargetList = [],
                     speed,
                     speedX = 0,
                     speedY = 0,
                     isSleep = true,
                     isForbidMove = false,
                     leagueId = 0,
                     name = ""}).

-record(mapAIMonster, {id,
                       objType,
                       monster_data_id,
                       spawnId,
                       level,
                       stateFlag,
                       aiState,
                       lastDoIdleTime,
                       isDetectHide = false,
                       posBeginFollowX,
                       posBeginFollowY, %% will check
                       bornX,
                       bornY,
                       lastUsePhysicAttackTime = [],%% 怪物技能cd列表
                       speed,            %move speed
                       hpMax,
                       %attackSpeed,
                       hateList = [],%element is #hateInfo
                       backPos,
                       curTargetId = 0,
                       curHate = 0,
                       type = 0,
                       historyPosList = [],
                       leagueId = 0}).

%% 地图npc实例，地图移动进程管理
-record(mapNpc, {id,
                 objType,
                 npc_data_id,
                 spawnId,
                 pos}).

%% 地图上掉落的物品，地图移动进程管理
-record(mapItem, {id,
                  objType,
                  itemDataId,
                  pos,
                  %% some property from #item
                  count = 0,
                  flag = 0, %%一些标志位
                  stars = 0, %% 强化(即升星)
                  equipRandAttrArray = [],%% 装备的随机属性
                  fujiaRandAttrArray = [], %%装备的附加属性
                  itemArrayForSpaceRing,%% 空间戒指
                  luck = 0,
                  %% special property
                  ownerId = 0, %%所有者，如果任何人都能拾取，设置为0
                  ownerExpireTime = 0,%%所有权超期时间，如果不需要转变所有权，设置为0,超期时间到，把所有权转为任何人都能拾取
                  expireTime,  %% 超期时间，超期时间到，将从地图上移除
                  curse,%%诅咒值
                  crit,%%暴击值
                  pickingUpState = 0, %%是否正在被拾取， 天降横财使用， 默认为0， 没有人在拾取， 否则为玩家ID， 标识该玩家正在拾取
                  protectingSeconds = 0, %%玛法禁地保护时间
                  systemStringCode = 0 %%系统提示代码
}).

%% 陷阱, 火墙
-record(mapTrap, {id,
                  objType,
                  trapDataId,
                  pos,
                  dx,
                  dy,
                  ownerId = 0,
                  leagueId = 0,
                  damagetype, %%伤害类型
                  power,      %%固定伤害值
                  powerpercent, %%伤害百分数
                  triggerInterval,%%单位：秒
                  %nextTriggerTime,%%下一次触发时间,单位:秒，
                  expireTime  %% 超期时间，单位:秒， 超期时间到，将从地图上移除
}).
-record(trapTriggerMsg, {
  ownerId,
  leagueId,
  pos,
  damagetype, %%伤害类型
  power,      %%固定伤害值
  powerpercent, %%伤害百分数
  effectIds     %%影响的id list
}).

%% ownerKey is {ownerId,mapDataId}  %%ownerID can be player id or team id,
-record(copyMapOwnerInfo, {ownerKey,
                           mapId, %% 副本的id
                           returnMapDataId, returnPosX, returnPosY  %%离开副本时，要返回的位置信息
}).

-define(TransferInMap_Type_Directly, 1).
-define(TransferInMap_Type_Random, 2).%%传送到本地图的一个随机位置
-define(TransferInMap_Type_RandomInSafeRegion, 3).%%传送到本地图的安全区里面的一个随机位置
-define(TransferInMap_Type_NearBy, 4). %%传送到一个点, 如果是 阻挡点, 取最近的非阻挡点.


%-define(Recover_Life_Use_RecoverRing,1). %使用复活戒指
-define(Recover_Life_Use_RecoverToken, 2). %使用复活令
-define(Recover_Life_Spend_Treasure, 3).%花费10元宝复活
-define(Recover_Life_ComebackHome, 4).  %回城复活



-define(Recover_Life_Ret_Not_Exist_Item, 1). %%无复活物品
-define(Recover_Life_Ret_Not_Enough_Treasure, 2).%%元宝不够
%-define(Recover_Life_Ret_Delay_Time_Too_Short,3).%%延迟时间不够
-define(Recover_Life_Ret_Not_Dead, 4).%%玩家并没有死

%%%%%%%%%%%%%%%%%add by zhangchao pk start%%%%%%%
-define(Fight_Pk_Dec_Num, -1). %%每次降低的pk值

-define(Fight_Pk_Color_White, 0). %%白色
-define(Fight_Pk_Color_Org, 1). %%黄色
-define(Fight_Pk_Color_Red, 2). %%红色
-define(Fight_Pk_Color_Black, 3). %%黑色
-define(Fight_Pk_Color_BrownBuffID, 136). %%褐色的buffid

-define(Fight_Pk_Max, 500). %%pk的最大值
-define(Fight_Pk_Red, 150). %%红名的pk值
%%%%%%%%%%%%%%%%%add by zhangchao pk end%%%%%%%

%%这玩意儿就是数字化，好跟策划的配置有个参照
%%
-define(ProperityIDMin, #mapFightProperties.hpMax).%%2
-define(ProperityHPMax, #mapFightProperties.hpMax).%%2
-define(ProperityMPMax, #mapFightProperties.mpMax).%%3
-define(ProperityLucky, #mapFightProperties.lucky).%%4
-define(Properitycurse, #mapFightProperties.curse).%%5
-define(ProperityatkMin, #mapFightProperties.atkMin).%%6
-define(ProperityatkMax, #mapFightProperties.atkMax).%%7
-define(ProperitymagicAtkMin, #mapFightProperties.magicAtkMin).%%8
-define(ProperitymagicAtkMax, #mapFightProperties.magicAtkMax).%%9
-define(ProperitydowAtkMin, #mapFightProperties.dowAtkMin).%%10
-define(ProperitydowAtkMax, #mapFightProperties.dowAtkMax).%%11
-define(ProperitydefMin, #mapFightProperties.defMin).%%12
-define(ProperitydefMax, #mapFightProperties.defMax).%%13
-define(ProperitymagicDefMin, #mapFightProperties.magicDefMin).%%14
-define(ProperitymagicDefMax, #mapFightProperties.magicDefMax).%%15
-define(ProperityhitRate, #mapFightProperties.hitRate).%%16
-define(ProperitymissRate, #mapFightProperties.missRate).%%17
-define(ProperityIDMax, #mapFightProperties.missRate).%%17


-define(EquipAdvancePropIdMin, 0).    %% 洗练属性的最小值
-define(EquipAdvancePropIdPA, 1).    %% 物理攻击
-define(EquipAdvancePropIdDow, 2).    %% 道术攻击
-define(EquipAdvancePropIdMA, 3).    %% 魔法攻击
-define(EquipAdvancePropIdPD, 4).    %% 物理防御
-define(EquipAdvancePropIdMD, 5).    %% 魔法防御
-define(EquipAdvancePropIdHP, 6).    %% HP
-define(EquipAdvancePropIdMP, 7).    %% MP
-define(EquipAdvancePropIdHit, 8).    %% 命中
-define(EquipAdvancePropIdMiss, 9).    %% 闪避
-define(EquipAdvancePropIdLuck, 10).    %% 幸运
-define(EquipAdvancePropIdCurse, 11).    %% 诅咒
-define(EquipAdvancePropIdCrit, 12).    %% 暴击
-define(EquipAdvancePropIdMax, 13).  %% 洗练属性的最大值

-define(EquipInheritPropIdPA, 14).  %% 继承的物理攻击
-define(EquipInheritPropIdDow, 15).  %% 继承的道术攻击
-define(EquipInheritPropIdMA, 16).  %% 继承的魔法攻击
-define(EquipInheritPropIdPD, 17).  %% 继承的物理防御
-define(EquipInheritPropIdMD, 18).  %% 继承的魔法防御
-define(EquipInheritPropIdHP, 19).  %% 继承的HP
-define(EquipInheritPropIdMP, 20).  %% 继承的MP
-define(EquipInheritPropIdHit, 21).  %% 继承的命中
-define(EquipInheritPropIdMiss, 22).  %% 继承的闪避

-define(EquipAdvancePropIdAttackSpeed, 23).    %% 攻速

-define(HurtMapList, [8300, 8301, 8302, 8400, 8401, 8402]).%狩猎地图

-define(PrisionMapDataId, 5089).

-endif. % -ifdef(mapDefine_hrl).

-ifndef(__GLOBALDEFINE_HRL__).
-define(__GLOBALDEFINE_HRL__, 1).
%%全局定义


%%运营平台类型定义

%%定时器相关
-define(GLOBAL_TIMER, global_timer).
-define(GLOBAL_TIMER_HANDLER, global_timer_handler).
-define(ONE_DAY_MSECONDS, 86400000).
-define(ONE_DAY_SECONDS, 86400).
-define(ONE_MONTH_SECONDS, 2592000).
-define(ONE_WEEK_SECONDS, 86400 * 7).

%% 消息头长度(2字节总长度+2字节协议号长度)
-define(HEADER_LENGTH, 4).


%%错误码的record定义
-record(result, {
  code = 0,  %%错误码必须是两个字节
  args = []  %%参数表数字是32位，或者 字符串；如[124, "sd"]
}).

-define(Save_Player_Data_Interval_Secs, 300). % 5 minutes
%% timer 定义 
-define(PlayerCheckTimer, 60000). %unit ms  : 1 minutes
-define(SaveGlobalDataTimer, 300000). %unit ms  : 5 minutes


-define(UpdateKickOutTableTimer, 30000).
-define(CountOnlinePlayerTimer, 300000). % 5 minutes

-define(ClearZombPlayerProcessTimer, 600000). % 10 minutes
-define(CheckLogTimer, 300000). % 5 minutes
%-define( CheckLogTimer,500). % 5 minutes

-define(DelaySendTimer, 100). %%延迟发送


%% named ets
-define(PlayerStateTableAtom, 'playerStateTableAtom').
-define(MapViewTableAtom, 'mapViewTableAtom').
-define(AccountStateTableAtom, 'accountStateTableAtom').
-define(MineBroadCastTableAtom, 'mineBroadCastTableAtom').

-define(ReadyLoginUserTableAtom, 'readyLoginUserTableAtom').
-define(MonsterCfgTableAtom, 'monsterCfgTableAtom').
-define(NpcCfgTableAtom, 'npcCfgTableAtom').
-define(MapCfgTableAtom, 'mapCfgTableAtom').
-define(ObjectCfgTableAtom, 'objectCfgTableAtom').
-define(GlobalMainAtom, 'globalMainAtom').
-define(GlobalMapAIRefresh, 'mapAIRefresh').
-define(GlobalMapAIRelated, 'GlobalMapAIRelated').
-define(GlobalFightPart, 'GlobalFightPart').
-define(GlobalMapTime, 'globalMapTime').
-define(GlobalPlatformVip, 'globalPlatformVip').
-define(GlobalOffLineHangUp, 'GlobalOffLineHangUp').
-define(GlobalIllWealthGatherTable, globalIllWealthGatherTable).
-define(GlobalKillerName, 'GlobalKillerName').

-define(MapProtectTime, 20).

-define(TeamTableAtom, 'teamTableAtom').
-define(TeamPlayerInfoTableAtom, 'teamPlayerInfoTableAtom').

-define(LeagueStateTableAtom, 'LeagueStateTableAtom').
-define(LeaguePlayerStateTableAtom, 'LeaguePlayerStateTableAtom').
-define(LeagueTimeoutTableAtom, 'LeagueTimeoutTableAtom').
-define(LeaguePkStateTableAtom, 'LeaguePkStateTableAtom').
-define(LeagueInvitationTableAtom, 'LeagueInvitationTableAtom').

-define(TradeTableAtom, 'TradeTableAtom').

-define(CopyMapOwnerTableAtom, 'copyMapOwnerTableAtom').

-define(MapTableAtom, 'mapTableAtom').


-define(HuangChengTableAtom, 'huangChengEts').

-define(HuangChengLeagueTableAtom, 'huangChengleagueEts').

-define(HuangChengHuangGongPeopleTableAtom, 'huangChengHuangGongPeopleEts'). %% 记录皇宫各行会人数(k:leagueId v:num)
-define(HuangChengPersonIntegralTableAtom, 'huangChengPersonIntegralEts'). %% 记录沙城个人积分(k:playerId v:integral)

-define(MailTableAtom, 'mailEts').
-define(PlayerMailTableAtom, 'playerMailEts').

-define(MapTableArrow, 'mapTableArrow').

-define(ZhaocaiTable, 'zhaocaiTable').
-record(zhaocai, {playerId, buyList, awardList, num}).

-define(ZhaocaiWebTable, 'zhaocaiWebTable').
-record(zhaocaiWeb, {id, beginTime, endTime, content}).

-record(offlineMessage, {playerId, module , function, args, extra, expire = erlang:system_time(seconds) + 86400 * 7 }).

%% 角色效果
-define(Role_Effect_Miss, 1).           %% 闪避
-define(Role_Effect_Damage, 2).         %% 受到伤害 减血
%-define( Role_Effect_Injure, 3).         %% 受伤动作
-define(Role_Effect_Add_HP, 4).  %% 回血效果
-define(Role_Effect_Dead, 5).   %% 死亡效果
-define(Role_Effect_SkillTransferComplete, 6). %%传送完全效果
-define(Role_Effect_RecoverLife, 7). %%传送完全效果
-define(Role_Effect_RecoverLife_Ring, 8). %%复活戒指复活
-define(Role_Effect_Immobilized, 9). %%禁锢, 不准移动
-define(Role_Effect_Stunned, 10). %%眩晕, 不能移动, 也不能释放技能


%% 角色状态
-define(Role_State_Flag_Mine, 0).             %% 挖矿
-define(Role_State_Flag_Benumb, 1).            %% 麻痹
-define(Role_State_Flag_Unbeatable, 2).         %% 无敌状态
-define(Role_State_Flag_IsVip, 3).       %% 是否为vip
-define(Role_State_Flag_Poison_Green, 4).       %% 绿毒状态
-define(Role_State_Flag_Team_Master, 5).        %% 队长
-define(Role_State_Flag_Brown, 6).              %% 主动攻击时颜色变化
-define(Role_State_Flag_Dead, 7).               %% 死亡
-define(Role_State_Flag_Invisible, 8).          %% 隐身
%% 9, 10 is used for pk color
-define(Role_State_Flag_Magic_Shield, 11).       %% 魔法盾覆盖在自己身上
-define(Role_State_Flag_IndianaTakeBox, 12).       %% 夺宝奇兵拿到宝箱
-define(Role_State_Flag_Escort, 13).       %%  正在护送美女
-define(Role_State_Flag_HuangCheng, 14).       %%  皇城争霸拿到玉玺

-define(Role_State_Flag_Immobilized, 15). %%被禁锢, 不可移动, 但是还是可以施法和普通攻击
-define(Role_State_Flag_Stunned, 16). %%被眩晕, 玩家不能释放任何技能, 也不能移动
-define(Role_State_Flag_StrengthAll15, 17). %%一身装备强化的不要不要的
-define(Role_State_Flag_StrengthAll20, 18). %%一声装备强化的屌炸天了

%%玩家死亡
-define(Role_Dead_RecoverLife_Time, 10000). %%玩家原地复活时候的延时
-define(Role_Dead_RecoverLife_Time_Key, roleDeadRecoverLifeTime). %%玩家原地复活时候的延时的宏定义


-define(RoleHandle_State_Login, 1).
-define(RoleHandle_State_InGame, 2).
-define(RoleHandle_State_InMap, 3).
-define(RoleHandle_State_SwitchToLogin, 4).
-define(RoleHandle_State_InQueue, 5).  %%排队状态
-define(RoleHandle_State_Offline, 6).  %%断线重连状态

-define(Shortcut_Type_Skill, 1).
-define(Shortcut_Type_Item, 2).


%% 采集被中断的类型
-define(Interrupt_Type_Move, 1).  %% 移动
-define(Interrupt_Type_Magic, 2).  %% 施法
-define(Interrupt_Type_Hit, 3).  %% 攻击
-define(Interrupt_Type_BeHit, 4).  %% 被攻击
-define(Interrupt_Type_Die, 5).  %% 死亡

%%全局的世界变量
-record(globalMain, {id, varArray}).
-define(GlobalMainID, 1). %% 全局变量的
-define(GlobalLimitBuy, 2). %% 限时道具的

%%祝福油单价元宝数量
-define(Lucky_Upgrade_Treasure, 10).


%% 由于服务器与客户端银角色移动的更新timer的时间长短不一样，允许的最大误差应该为服务器一帧角色移动的距离，现暂时设置为1个单位的逻辑距离
%% maybe need adjust the Deviation by speed
-define(Permit_Skill_Distance_Deviation_Max, 1).
-define(Permit_Transfer_Distance_Deviation_Max, 1).
%%客户端与服务端位置最大误差值,250/秒，允许4秒的误差  logical : 8*4
%%改为1秒（卡的人，你们就苦逼一下吧） 
-define(Permit_Move_Distance_Deviation_Max, 8).

%% 战斗属性的最大值
-define(Fight_Prop_Value_Max, 99999999).
%% 战斗属性的最小值
-define(Fight_Prop_Value_Min, 0).

%% 复活花费的元宝数量
-define(Recover_Life_Spend_Treasure_Num, 30).

-endif.

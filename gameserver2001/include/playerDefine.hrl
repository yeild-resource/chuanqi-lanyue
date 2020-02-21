-ifndef(playerDefine_hrl).
-define(playerDefine_hrl, 1).
%% 下线原因
-define(LOGOUT_NORMAL, 1).
-define(LOGOUT_KICK, 2).

%% 上下线
-define(Offline, 0).
-define(Online, 1).

%% 玩家出生地图
-define(PlayerBornMapDataId, 10).

-record(account_state, {
  id = 0,        %% user id, ie. account id
  pid = none     %% 玩家进程
}).


%%玩家职业类型
-define(Career_Min, 1).            %%
-define(Career_ZhanShi, 1).        %%战士
-define(Career_DaoShi, 2).         %%道士
-define(Career_FaShi, 3).          %%法师
-define(Career_Max, 3).            %%
-define(Level_Max, 70).           %%玩家等级最大值

-record(playerAttrMax, {maxFighting = 0,
                        luck = 0,
                        curse = 0,
                        crit = 0,
                        attackApeed = 0,
                        pk = 0,
                        bagNum = 0,
                        gold = 0,
                        coin = 0,
                        friend = 0,
                        enemy = 0,
                        kill = 1,
                        beKill = 1,
                        strength = 1,
                        combine = 1,
                        xilian = 1}).

-record(player_state, {
  id = 0,        %% 玩家ID
  socket = none,     %% 玩家socket
  pid = none,     %% 玩家进程
  sendPid = none,     %% player send msg process id
  accountId = none,      %% account id
  %% 增加一些很少改变的字段，方便别的进程访问
  name = "",%%玩家的名字
  level = 1,%%玩家的等级
  career = ?Career_ZhanShi,%%玩家的职业
  sex = 0, %%玩家的性别
  teamSet = 0,  %%自由组队
  createTime = 0,    %% 角色创建时间
  hp = 0,
  hpMax = 0,
  fightingCapacity = 0,
  vipLevel = 0,
  offlineKey = "", %%离线key
  mapDataId = 0,
  leagueId = 0,
  memberNum = 0
}).


-record(player, {id,    %% 角色ID
  userId,    %% 用户ID
  name,    %% 角色名称
  career,    %% 职业
  sex,    %% 性别
  level,    %% 等级
  mapDataId,
  mapId = 0,
  x = 0,
  y = 0,%% 位置，包括地图ID和坐标
  equipDataArray,  %% 装备数据
  warehouseArray,%%仓库
  minehouseArray,%%探矿仓库
  enchaseDataArray, %%镶嵌
  varArray,  %% 玩家变量
  exp = 0,    %% 经验
  coin = 0,    %% 游戏币
  bindCoin = 0,  %% 绑定游戏币
  treasure = 0,  %% 元宝
  bindTreasure = 0,  %% 绑定元宝
  totaltreasure = 0,  %% 累计元宝
  reputation = 0,  %% 声望值
  spirit = 0,  %% 元气值
  holy = 0,    %% 神圣值
  cdUseItem = [],  %% 物品使用的cd冷却时间
  skillList = [],
  passitiveSkillIdList = [], %% save it in player process and mapFight process
  pet = {},  %% #pet info
  fightingCapacity = 0, %% 战斗力
  teamSet = 0,  %%自由组队
  richerTimes = 10, %%摇钱树的次数
  registerTime = 0, %%角色创建的时间
  wheelTimes = 0, %%转盘的次数
  vipEveryDay = 0, %%vip每日领奖

  createTime = 0,
  lastOnlineTime = 0,
  lastOfflineTime = 0,
  loginIp,
  isOnline,
  leagueId = 0,
  applyleagueTimes = 0,
  platSendItemBits = <<>>,
  forbidChatFlag = 0,
  forbidChatEndTime = 0,
  gmFlag = 0,
  platformID = 0,
  channelId = 0,
  shaChengGetAwardFlag = 0,
  huangChengGetAwardFlag = 0,
  changePetId = 0,
  activeIdList = [],
  lastUpgradeTime = 0,
  lastUpgradeCostTime = 0,
  killScore = 0,%%战绩值,
  limitbuytime = 0,
  limitbuydata = [],
  achievement = [],
  attrMax = #playerAttrMax{}
}).

%not save to db
-record(playerMapDynamicInfo, {
  mapPID = 0,
  mapFightPid = 0,
  mapAIPid = 0,
  mapPlayerEts = undefined,
  mapMonsterEts = undefined,
  mapNpcEts = undefined,
  mapItemEts = undefined,
  mapOtherEts = undefined,
  mapPetEts = undefined,
  mapFightPlayerEts = undefined,
  mapFightMonsterEts = undefined,
  mapFightPetEts = undefined,
  leagueName = "",
  lineNum = 1
}).

%% user table
-define(MaxOnlineUsers, 1000).
-define(MaxUserPlayerCount, 2).

-define(ReadyLoginUserExpireTime, 30).
-record(readyLoginUser, {accountID, account, platId, channelId = 0, sign, expireTime, gyyxLf}).

%%玩家上一次的坐标位置
-define(Player_Pre_Position, playerPrePosition).  %%

%% 踢玩家下线类型
-define(PlayerKick_Type_Unknown, 0).  %% 未知
-define(PlayerKick_Type_LoginRepeat, 1).  %% 重复登录
-define(PlayerKick_Type_InvalidOper, 2).  %% 非法操作，针对外挂
-define(PlayerKick_Type_GM, 3).    %% GM命令
-define(PlayerKick_Type_Platform, 4).  %% 后台
-define(PlayerKick_Type_Other, 5).  %% 其他
-define(PlayerKick_Type_OutGame, 6).  %% 玩家主动退出游戏
-define(PlayerKick_Type_Cross, 7).  %% 跨服战跳服

-define(PlayerProc_Status, playerProc_Status). %%process dictionary key
-define(PlayerProc_Status_None, 0).
-define(PlayerProc_Status_Login, 1).
-define(PlayerProc_Status_InGame, 2).
-define(PlayerProc_Status_LogOut, 3).
%-define(PlayerProc_Status_SwitchToRoleDlg,4).

-define(PlayerProc_killMultipleMonsterExp, playerProc_killMultipleMonsterExp).
-define(PlayerProc_killMultipleMonsterCount, playerProc_killMultipleMonsterCount).

%%玩家性别
-define(Sex_Female, 0).            %% 女
-define(Sex_Male, 1).              %% 男

%% 玩家属性对应的宏定义值
-define(Player_Prop_Id, 0).  %% id
-define(Player_Prop_Name, 1).  %% name
-define(Player_Prop_Level, 2).  %% level
-define(Player_Prop_Career, 3). %% career
-define(Player_Prop_Sex, 4).  %% Sex
-define(Player_Prop_Exp, 5).  %% Exp
-define(Player_Prop_Hp, 6).  %% Hp
-define(Player_Prop_Mp, 7).  %% Mp
-define(Player_Prop_BagGridNum, 8).  %% BagGridNum
-define(Player_Prop_State, 9).  %% stateFlag
-define(Player_Prop_PK, 10).  %% pk
-define(Player_Prop_Coin, 11).  %% coin
-define(Player_Prop_BindCoin, 12).  %% bind coin
-define(Player_Prop_Treasure, 13).  %% treasure
-define(Player_Prop_BindTreasure, 14).  %% bind treasure
-define(Player_Prop_PkState, 15).  %% pkState
-define(Player_Prop_HpMax, 16).  %% HpMax
-define(Player_Prop_MpMax, 17).  %% MpMax
-define(Player_Prop_VipLevel, 18).  %% vipLevel
-define(Player_Prop_TotalTreasure, 19).  %% total treasure
-define(Player_Prop_Speed, 20). %% speed
-define(Player_Prop_titleId, 21). %% titleId
-define(Player_Prop_leagueId, 22). %% leagueId
-define(Player_Prop_fightingCapacity, 23). %% FightingCapacity
-define(Player_Prop_Wing, 24). %% 翅膀
-define(Player_Prop_CrossSide, 25). %% 跨服战分边
-define(Player_Prop_Curse, 26). %% 武器诅咒值
-define(Player_Prop_IsCrit, 27). %%是否暴击
-define(Player_Prop_WarseHouseGridNum, 28).  %% WarseHouseGridNum
-define(Player_Prop_Aspeed, 29). %% 29攻速
-define(Player_Prop_Medal, 30). %%勋章
-define(Player_Prop_Reputation, 31). %%声望
-define(Player_Prop_StrengthAll, 31). %%一身强化属性

%% 玩家PK模式
%% 0:和平模式；1：组队模式；2：帮会模式；3：善恶模式；4：全体模式
-define(Player_pkMode_Peace, 0).
-define(Player_pkMode_Team, 1).
-define(Player_pkMode_Guild, 2).
-define(Player_pkMode_Punish, 3).
-define(Player_pkMode_All, 4).


%% continue
-record(playerOnlineDBData, {playerBase, bagGridNum, bagDataArray, shortcutList, acceptTaskList, repeatCompletedTaskList, singleCompletedTaskList}).%%玩家上线初始化，从DB拿到的数据

%%玩家的物品CD信息
-record(playerItemCDInfo, {cdTypeID, cd_time, all_time}).

%%玩家的每日使用物品次数CD
-record(playerItem_DailyCountInfo, {cdTypeID, curCount, maxCount, cd_time}).


-define(Min_CreatePlayerName_Len, 2).%%角色创建名字最小字符
-define(Max_CreatePlayerName_Len, 7).%%角色创建名字最大字符

-define(Kill_People_Num_5, 5).%% 180秒杀人数量5
-define(Kill_People_Num_8, 8).%% 180秒杀人数量8

-define(Kill_People_Num, killPeopleNum). %% 180秒内杀人数量
-define(Kill_PeopleTimeSeconds, 180000). %% 杀人的180秒,毫秒计时

-record(player_attachinfo, {playerid, liveNessValue, liveNessList, drewLnAwardList}).
-record(limitBuyInfo, {id, starttime, dataList}).
-endif.

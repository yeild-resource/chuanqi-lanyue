-ifndef(__GAMEDATADB_HRL__).
-define(__GAMEDATADB_HRL__, 1).

%% player table


%% 角色保存数据库字段
-record(player_gamedata, {id,
  userId,
  name,
  career,
  sex,
  level,
  mapDataId,
  mapId,
  x,
  y,
  equipDataArray,
  enchaseDataArray,
  bagGridNum,
  bagDataArray,
  warehouseArray,
  minehouseArray,
  varArray,
  shortcutList,
  acceptTaskList,
  repeatCompletedTaskList,
  singleCompletedTaskList,
  skill_list = [],
  passitiveSkillIdList = [],
  pet = {},
  buffer_list = [],
  friendIdList = [],
  hp = 0, mp = 0,
  exp = 0,
  coin = 0,%金币
  bindCoin = 0,
  treasure = 0, %元宝
  bindTreasure,
  totaltreasure = 0,  %% 累计元宝
  pk = 0,%pk值
  pkState = 0,%pk值
  reputation = 0,%声望值
  spirit = 0,%元气值
  holy = 0,%神圣值
  cdUseItem = [],
  fightingCapacity = 0, %战斗力
  teamSet = 0,  %%自由组队
  copyCDInfoList = [],
  activedHighCopyList = [],  %%已激活的精英副本的dataId list
  nextResetTimePerday = 0,
  isDelete,
  richerTimes = 10,
  registerTime = 0,
  wheelTimes = 0,
  vipEveryDay = 0,

  createTime = 0,
  lastOnlineTime = 0,
  lastOfflineTime = 0,
  loginIp,
  isOnline,
  leagueId = 0,
  applyleagueTimes = 0,
  platSendItemBits,
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
  killScore = 0,
  nextKillTime = 0,
  limitbuytime = 0,
  limitbuydata = [],
  achievement = [],
  attrMax
}).

%% 帮会db数据
-record(league_data, {
  leagueId,
  name,
  level,
  maxCount,
  memberlist,
  duplicateId,
  announcement,
  manifesto,
  enteredCopyMapNum,
  leagueScore,
  exp,
  fund,
  rank,
  escortTimes,
  escortState,
  robTimes,
  robbingList,
  robbedList
  }).



-record(playerBaseInfo, {
  id,
  name,
  level,
  career,
  sex
}).

-record(worldvar, {
  worldvar
}).

-endif.

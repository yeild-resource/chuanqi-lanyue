%%%%%秦陵地宫地图ID


-define(UNDERGROUND_PALACE_ACTIVITY_ID, 1001).
-define(UNDERGROUND_PALACE_MAP_ID, 5039).

%% -define(UNDERGROUND_PALACE_PREPARE_AND_START_AND_END_TIME, [[{10,30,0},{11,35,0},{11,10,0}], [{16,0, 0}, {16,5,00}, {16,30,00}]]).




-define(UndergroundPalaceSecondsToStartTimerRef, undergroundPalaceSecondsToStartTimerRef).

-define(UndergroundPalaceLayer, undergroundPalaceLayer).

-define(UndergroundPalaceBossState, undergroundPalaceBossState).
-define(UndergroundPalaceBossDead, bossDead).
-define(UndergroundPalaceBossExisted, bossExisted).

-define(UndergroundPalacePlayerIdList, undergroundPalacePlayerIdList).

-define(UndergroundPalaceLayerIntervalSeconds, 300). %%测试用20秒， 实际用180秒

-define(UndergroundMaxLayer, 9). %%最多打9层

-define(DamageBroadcastIntervalSeonds, 10). %% 10秒广播1次

-define(UndergroundPalaceDataList, undergroundPalaceDataList).

-define(UndergroundPalaceStatisticsServer, undergroundPalaceStatisticsServer).
-define(UndergroundPalaceStatisticsTable, undergroundPalaceStatisticsTable).

-define(UndergroundStatisticsTable, undergroundStatisticsTable).
-record(undergroundPalaceStatistics, {
  playerId = 0, %% 玩家ID
  mapId = 0, %%地图ID
  damage = 0, %%伤害值
  layer = 0 %%玩家打到的层数
}).


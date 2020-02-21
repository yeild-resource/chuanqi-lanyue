-define(BossState_NotRefresh, 0).
-define(BossState_Refreshed, 1).
-define(BossState_Killed, 2).

-define(HistoryKeepNum, 3).

-record(bossKill, {killPlayerID = 0, killPlayerName = "", killTime = 0}).

-record(bosskillInfo, {key, lineNum, mapDataID, monsterDataID, nextRefreshTime, bossState = ?BossState_NotRefresh, bosskillList = [], mapSpawn}).

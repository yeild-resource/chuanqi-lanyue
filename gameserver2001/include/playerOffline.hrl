-record(playerOffline, {userID, key, playerPid, coreIndex, playerID, expireTime}).
-define(KeepOfflineTime, 180).

-define(Offline_Success, 0).
-define(Offline_NotExists, -1).
-define(Offline_Expire, -2).
-define(Offline_NormalLand, -3).
-define(Offline_KeyError, -4).
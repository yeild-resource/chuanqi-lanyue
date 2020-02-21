-define(DBVersion, 002).
-define(PlayerBaseID, 1000).



-record(dbInfo, {name, value}).

-define(GlobalMainID, 1).
-record(globalMain, {id, globalUserSocket, globalLoginUserTable}).

%%登录服务器信息
-record(loginServerInfo, {index, loginServerID}).

%%全局已登录用户
-record(globalLoginUser, {userID, account, platId, gsid, socket, userPID, sign, expireTime, loginTime, logGSIP = "", platformSpecific}).

%%全局白名单
-record(whiteUser, {userID}).

%% user table
-record(userDBRecord, {id, name, password}).


-record(uniqueId, {item, uid}).
-record(uniqueIdMem, {item, uid}).


%% -define( Tables, [uniqueId, record_info(fields,uniqueId),
%%  				  userDBRecord, 	record_info(fields,userDBRecord)
%%  				 ] ).

-define(MemTables, [uniqueIdMem, record_info(fields, uniqueIdMem),
                    globalMain, record_info(fields, globalMain)
]).
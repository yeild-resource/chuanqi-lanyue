-ifndef(gameServerDefine_hrl).

%%s_isNew 1 新服
%%s_isNew 0  正常服
%%s_isNew 2 推荐服
-record(gameServerRecord, {id, name, ip, port, status, desc, sign, state, socket, onlinePlayers, showStatus, isNew = 0, regionName = "",
                           allowRechage = 1, startTime = 0, order = 0}).

%% 服务器列表中游戏服务器状态
-define(GameServer_State_Uncheck, 0).
-define(GameServer_State_Running, 1).
-define(GameServer_State_Closed, 2).

%% 玩家IP限制的状态
-define(UserIp_Limit_Accept, 0). %% 内部测试IP
-define(UserIp_Limit_Forbidden, 1). %% 屏蔽IP

%% 服务器列表中游戏服务器状态,运营设置的状态
-define(GameServer_Status_Normal, 0).    %%正常
-define(GameServer_Status_Hot, 1).    %%火爆
-define(GameServer_Status_Full, 10).    %%爆满
-define(GameServer_Status_Maintain, 100).    %%维护
-define(GameServer_Status_Closed, 1000).    %%关闭
-define(GameServer_Status_SpecVisable, 10000).  %%测试人员可见

%% 服务器在线人数状态显示
-define(GameServer_Online_Status_Full_Max, 1300).  %%爆满最大值

%% 服务器注册返回码 
-define(GameServer_Register_Code_Succ, 0).    %%成功
-define(GameServer_Register_Code_InvalidSign, 1).  %%错误的注册码
-define(GameServer_Register_Code_NotExist, 2).  %%不存在服务器
-define(GameServer_Register_Code_Repeat, 3).  %%重复注册


-endif. % -ifdef(gameServerDefine_hrl).

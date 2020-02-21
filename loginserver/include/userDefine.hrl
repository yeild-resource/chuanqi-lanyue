-ifndef(userDefine_hrl).

%% 过期时间, 用户登录LS到登录GS之间的时间间隔
-define(User_Login_Expire_Time, 300).
-define(User_Sign_Expire_Time, 30).

%% user states
-define(UserState_WaitLogin, 1).
-define(UserState_WaitRequestGameServerList, 2).
-define(UserState_WaitRequestPlayerInfo, 3).
-define(UserState_WaitSelGameServer, 4).
-define(UserState_ReadyLogin, 5).
-define(UserState_WaitClose, 6).

%% one user record , 
-record(userSocketRecord, {socket, state, userName, userID, ip, platId, channelId = 0}).
-record(userDBLoginResult, {resultCode, account, userID, platId}).
-record(userInfo, {server_id, user_id, name, level, carrer, sex}).

%% verify code
-define(Verify_Result_Ok, 0).          %% 验证成功

%% 登录验证返回码
-define(Login_LS_Result_Succ, 0).          %%验证成功，可以登录游戏服务器
-define(Login_LS_Result_Fail_UserNameOrPassword, -1).      %%验证失败，用户名密码错误
-define(Login_LS_Result_Fail_OtherLogin, -2).        %%验证失败，重复登录
-define(Login_LS_Result_Fail_Kickout, -3).        %%被踢下线
-define(Login_LS_Result_Fail_Freeze, -4).        %%该账户已经被冻结，禁止登录
-define(Login_LS_Result_Fail_Connect, -5).        %%尚未连接登录服务器
-define(Login_LS_Result_Fail_Empty, -6).        %%用户名密码不能为空
-define(Login_LS_Result_Fail_DbError, -7).        %%验证失败，写数据库失败
-define(Login_LS_Result_Fail_Unknown, -8).        %%验证失败，未知错误
-define(Login_LS_Result_Fail_Exception, -9).        %%验证失败，异常错误
-define(Login_LS_Result_Fail_Unsupport, -10).        %%验证失败，登录服务器不支持该平台验证
-define(Login_LS_Result_Fail_Timeout, -11).        %%验证失败，验证超时
-define(Login_LS_Result_Fail_Disconnect, -12).        %%验证失败，网络断开
-define(Login_LS_Result_Fail_Forbidden, -13).        %%验证失败，帐号被封
-define(Login_LS_Result_Fail_ForbiddenDevice, -14).         %%验证失败，设备被封
-define(Login_LS_Result_Fail_IPTooManyUser, -15).        %%这个IP登陆的账号太多

%% 请求选择服务器返回码
-define(SelectGS_Code_Succ, 0).          %% 成功，可以登录游戏服务器
-define(SelectGS_Code_Maintain, 1).          %% 服务器正在维护
-define(SelectGS_Code_NotExist, 2).          %% 服务器不存在
-define(SelectGS_Code_Closed, 3).          %% 服务器已关闭

-endif. % -ifdef(userDefine_hrl).

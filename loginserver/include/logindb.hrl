%% name : logindb.hrl
%% desc : modified by yueliangyou [2013-07-05]
%% desc : 该文件用于定义与数据库表结构对应的记录
%% desc : 记录成员名称和数据库字段名称一一对应

%% account 用户账户表
-record(account, {ac_id, ac_platform, ac_account, ac_apple_account = "", ac_lastLogintime, ac_createTime, player = [], deviceIMEI, screenSize, channelId = 0}).

%% server 服务器配置表
-record(server, {s_id, s_name, s_ip, s_port, s_status, s_desc, s_sign, s_isNew, s_regionName, allowRechage, order}).

%% 封停账户表 
-record(forbidden, {fo_platform, fo_account, fo_flag, fo_reason, fo_timeBegin, fo_timeEnd, fo_desc}).

%% 限制IP列表
-record(limitIps, {ip, name, status}).


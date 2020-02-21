%% 服务器列表
-define(CMD_WS2LS_GameServerList_Request, 1001).
-record(pk_WS2LS_GameServerList_Request, {
}).

%% 改变服务器状态
-define(CMD_WS2LS_Change_Server_State_Request, 1002).
-record(pk_WS2LS_Change_Server_State_Request, {
  serverid,
  state,%%0未检查，1运行中，2关闭,
  ip,
  description
}).

%% 添加服务器
-define(CMD_WS2LS_Add_Server_Request, 1003).
-record(pk_WS2LS_Add_Server_Request, {
  serverid,
  name,
  ip,
  port,
  status,
  desc,
  sign,
  regionName
}).

%% 删除服务器
-define(CMD_WS2LS_Del_Server_Request, 1004).
-record(pk_WS2LS_Del_Server_Request, {
  serverid
}).

%% 踢玩家下线
-define(CMD_WS2LS_Kick_Player_Off_Request, 1005).
-record(pk_WS2LS_Kick_Player_Off_Request, {
  serverid,
  role_name
}).

%% GM命令
-define(CMD_WS2LS_GM_CMD_Request, 1006).
-record(pk_WS2LS_GM_CMD_Request, {
  serverid,%%0全服，其他：某服务器
  op%%“Type；BitId；Name；GMstr,Level_min；Level_max_S；Expirationdate_S”（拼成这样一个字符串）
  %%Type；1(所有人),0(单人)
  %%BitId；%%整数，需要我们自己定，没一个对应一个GM命令
  %%Name；玩家名字
  %%GMstr,gm命令，格式和程序中使用GM命令一样，如：#addexp 9999
  %%Level_min；要求最低等级
  %%Level_max_S；要求最高等级
  %%Expirationdate_S,过期时间
}).

%% 公告
-define(CMD_WS2LS_Announcement_Request, 1007).
-record(pk_WS2LS_Announcement_Request, {
  serverid,
  msg
}).

%% 后台控制活动的开启或关闭
-define(CMD_WS2LS_control_activity_Request, 1008).
-record(pk_WS2LS_control_activity_Request, {
  serverid,%%0全服，其他：某服务器
  op%%gm命令，格式和程序中使用GM命令一样，如：#add_exp 9999
}).

%% 恢复角色
-define(CMD_WS2LS_recover_role_Request, 1009).
-record(pk_WS2LS_recover_role_Request, {
  serverid,
  op%%“userID；PlayerId”（拼成这样一个字符串）
}).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 充值
-define(CMD_WS2LS_PayInfo_Request, 2001).
-record(pk_WS2LS_PayInfo_Request, {
  serverid,
  op%%"GameId,OrderId,PayWay,PlatformId,PlayerId,Amount"（拼成这样一个字符串）（以";"隔开）
}).
%% -record(pk_WS2LS_PayInfo_Request, {
%% 	orderId,
%% 	gameId,
%% 	serverId,
%% 	platformId,
%% 	accountId,
%% 	payWay,
%% 	amount
%% 	}).

%% 设置游戏管理员GM
-define(CMD_WS2LS_SET_GM_Request, 2008).
-record(pk_WS2LS_GM_Request, {
  server_id,
  role_name
}).

%% 取消游戏管理员GM
-define(CMD_WS2LS_CANCEl_GM_Request, 2009).
-record(pk_WS2LS_CANCEL_GM_Request, {
  server_id,
  role_name
}).

%% 禁止角色登陆
%% -define(CMD_WS2LS_FORBID_ROLE_Request,2010).
%% -record(pk_WS2LS_FORBID_ROLE_Request, {
%% 	server_id,
%% 	role_name,
%% 	time,
%% 	flag
%% 	}).

%% 玩家设备封禁
-define(CMD_WS2LS_FORBID_DEVICE_Request, 2011).
-record(pk_WS2LS_FORBID_DEVICE_Request, {
  uuid,
  flag%%1封禁，0解封
}).

%% 禁言
-define(CMD_WS2LS_FORBID_CHAT_Request, 2012).
-record(pk_WS2LS_FORBID_CHAT_Request, {
  server_id,
  role_name,
  time,%%时间，封禁多少秒
  flag%%1封禁，0解封
}).

%% 禁止帐号登陆
-define(CMD_WS2LS_FORBID_ACCOUNT_Request, 2013).
-record(pk_WS2LS_FORBID_ACCOUNT_Request, {
  platFormId,
  account,
  flag,%%1封禁，0解封
  delayTime%%时间，封禁多少秒
}).

-define(CMD_WS2LS_Set_Rechage_State, 2014).
-record(pk_WS2LS_Set_Rechage_State, {
  server_id,%%0全服，其他：某服务器
  set_value%%1设置禁止充值，0取消禁止充值
}).

-define(CMD_WS2LS_Send_System_Mail, 2015).
-record(pk_WS2LS_Send_System_Mail, {
  server_id,%%0全服，其他：某服务器
  flag,%%1所有人，0单人
  low_level,%%最低等级
  high_level,%%最高等级
  mailTitle,%%标题
  mailContent,%%内容
  receiveName,%%收件人名字
  receivePlayerID,%%收件人ID
  itemList%%数组,数据结构为{itemDataId,itemCnt,flag}
}).

-define(CMD_WS2LS_Change_Player_Name, 2016).
-record(pk_WS2LS_Change_Player_Name, {
  server_id,
  oldName,
  newName
}).

-define(CMD_WS2LS_Change_League_Name, 2017).
-record(pk_WS2LS_Change_League_Name, {
  server_id,
  oldName,
  newName
}).

-define(CMD_WS2LS_Manual_Monster, 2018).
-record(pk_WS2LS_Manual_Monster, {
  server_id,%%0全服，其他：某服务器
  monsterId,%%怪物ID
  monsterNum,%%怪物数量
  mapId,%%地图id
  x,%%X坐标
  y%%Y坐标
}).
-define(CMD_WS2LS_Pay_Related, 2019).%%充值相关操作
-record(pk_WS2LS_Pay_Related, {
  server_id,
  type,%%1单笔充值2每日充值3累计充值
  beginTime,
  endTime,
  desc,
  content
}).

-define(CMD_WS2LS_ReOrderServer, 2020).%%改变服务器的order，order越小，服务器排名越靠前
-record(pk_WS2LS_ReOrderServer, {
  server_id,
  newOrder
}).

-define(CMD_WS2LS_Cross_Zone, 2021).%%暂时不管，跨服战功能还没有
-record(pk_WS2LS_Cross_Zone, {
  data
}).

%% 设置当前服务器新建玩家角色是否可以领取首充礼包（state: 1 可以领取，0 不可以领取）
-define(CMD_WS2LS_SetFirstPay_State, 2022).
-record(pk_WS2LS_SetFirstPay_State, {
  server_id,
  state%%state: 1 可以领取，0 不可以领取
}).

-define(CMD_WS2LS_Set_Limit_Ips, 2023).
-record(pk_WS2LS_Set_Limit_Ips, {
  ip,
  name,
  status, %%0:内部测试IP, 1:屏蔽IP
  flag %%1:增加，0:删除
}).

-define(CMD_WS2LS_Update_Limit_Ips_Status, 2024).
-record(pk_WS2LS_Update_Limit_Ips_Status, {
  ip,
  status
}).

%%转帐号
%%设置指定帐号下指定角色的新帐号id
-define(CMD_WS2LS_SWITCH_USERID, 2025).
-record(pk_WS2LS_SWITCH_USERID,
{
  desAccountId,
  srcAccountId,
  srcPlayerId,
  serverId
}
).

%%增加vip积分
-define(CMD_WS2LS_ADD_VIP, 2026).
-record(pk_WS2LS_ADD_VIP,
{
  server_id,
  player_id,
  score
}
).

%%发送玩家邮件
-define(CMD_WS2LS_Send_PlayerMail, 2027).
-record(pk_WS2LS_Send_PlayerMail, {
  server_id,%%0全服，其他：某服务器
  flag,%%1所有人，0单人
  mailTitle,%%标题
  mailContent,%%内容
  receivePlayerList,%%收件人名字数组{recivePlayerID,recivePlayerName}
  itemList%%数组,数据结构为{itemDataId,itemCnt,flag}
}).

%%发送公告
-define(CMD_WS2LS_Send_BroadCast, 2028).
-record(pk_WS2LS_Send_BroadCast, {
  server_id,%%0全服，其他：某服务器
  spacetime,%%间隔时间
  times,%%发送次数
  msgtype,%%所谓的位置
  content%%内容
}).

%%白名单操作
-define(CMD_WS2LS_Send_WhiteUser, 2029).
-record(pk_WS2LS_Send_WhiteUser, {
  userIdList,%%白名单账号Useridlist
  flag%%1添加，0删除
}).

%%充值返利
-define(CMD_WS2LS_Rebate_Active, 2030).
-record(pk_WS2LS_Rebate_Active, {
  serverid,%%服务器ID
  begintime,%%开始时间
  endtime,%%开始时间
  rebateride%%返利倍数
}).

%%招财宝
-define(CMD_WS2LS_Zhaocai_Active, 2031).
-record(pk_WS2LS_Zhaocai_Activity, {
  server_id,
  type,%%1开启活动
  beginTime,
  endTime,
  content
}).

%%聚宝盆开启和结束时间
-define(CMD_WS2LS_Charge_Award, 2032).
-record(pk_WS2LS_Charge_Award, {
  serverid, %%服务器ID
  begintime, %%开始时间
  endtime %% 结束时间
}).

%%活动公告
-define(CMD_WS2LS_Send_Notice, 2033).
-record(pk_WS2LS_Send_Notice, {
  serverid, %%服务器ID
  begintime, %%开始时间
  endtime,  %%结束时间
  content   %%内容
}).
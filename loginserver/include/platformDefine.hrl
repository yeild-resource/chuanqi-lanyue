-ifndef(platformDefine_hrl).

-record(platformTable, {platformID, isSupport, ip, port}).


%% 与皮皮平台消息命令定义
-define(CMD_PLATFORM_PP_VERIFY, 16#AA000022).
-define(CMD_PLATFORM_PP_VERIFY_RET, 16#AA00F022).

%% 与皮皮平台验证消息请求
%% commmand = 0xAA000022
-record(pk_LS2PlatformPP_Verify, {
  len,
  commmand,
  token_key
}).

%%与皮皮平台验证结果返回消息
%% commmand = 0xAA00F022 status = 0 成功，失败为其他值
-record(pk_LS2PlatformPP_Verify_Ret, {
  len,
  commmand,
  status,
  username
}).

%%----------------------------------------------------------------------
%%-------以下是553平台--------------------------------------------------
%%----------------------------------------------------------------------

%%各个平台定义标识符
-define(PLATFORM_TEST, 100).  %% PC
-define(PLATFORM_UC, 101).  %% UC九游
-define(PLATFORM_V5, 102).  %% 微讯
-define(PLATFORM_91, 103).  %% 91
%% modify by xjl
-define(PLATFORM_peasecod, 104).  %% 豌豆荚
-define(PLATFORM_millet, 105).  %% 小米
-define(PLATFORM_360, 106).  %% 360
-define(PLATFORM_anzhi, 107).  %% 安智市场
-define(PLATFORM_baidu, 108).  %% 百度多酷
-define(PLATFORM_dangle, 109).  %% 当乐游戏

-define(PLATFORM_lenovo, 110).  %% 联想乐商店
-define(PLATFORM_Gionee, 111).  %% 金立游戏
-define(PLATFORM_AppChina, 112).  %% 应用汇
-define(PLATFORM_OPPO, 113).  %% OPPO
-define(PLATFORM_Kingsoft, 114).  %% 金山
-define(PLATFORM_QQ, 115).  %% 应用宝
-define(PLATFORM_37, 116).  %% 37
-define(PLATFORM_201, 201).  %% 201
-define(PLATFORM_91ios, 203).  %% 91ios
-define(PLATFORM_dangleios, 209).  %% 当乐游戏 ios
-define(PLATFORM_tbtios, 217).  %% 同步推ios
-define(PLATFORM_ppios, 218).  %% PPios
-define(PLATFORM_itoolios, 219).  %% itools ios
-define(PLATFORM_aisi, 220).  %% 爱思平台
-define(PlatformID_IOS_KY, 221).  %% 快用IOS
-define(PLATFORM_vtc, 223).  %% vtc
-define(PLATFORM_hmios, 224).  %% 海马平台
-define(PLATFORM_weiyou, 225).  %% 威游平台
-define(PLATFORM_xy, 222).  %% XY平台
-define(PLATFORM_shuizhu, 124).  %% 水煮平台 8868
-define(PLATFORM_vtcid, 123).  %% 越南平台
-define(PLATFORM_aibei, 226).  %% 爱贝平台
-define(PLATFORM_sogou, 126).  %% 搜狗平台
-define(PLATFORM_nduo, 127).  %% N多平台
-define(PLATFORM_yiyou, 128).  %% 宜游平台
-define(PLATFORM_shoumeng, 129).  %% 手盟平台
-define(PLATFORM_V5_2B, 130).  %% 微讯
-define(PLATFORM_KX, 131).  %% 开心 android
-define(PLATFORM_GUANGYU_ANDROID, 136). %%光宇游戏 android 和 越狱iOS
-define(PLATFORM_IOS_KX, 231).  %% 开心 Ios

-define(PLATFORM_huawei, 132).  %% 华为
-define(PLATFORM_weiuu, 133).  %% 微游汇Ios
-define(PLATFORM_GUANGYU, 232). %%光宇游戏, GameCenter正版
-define(PLATFORM_weiuu_iso, 2333333).  %% 微游汇 Ios
-define(PLATFORM_GUANGYU_IOS, 233). %%光宇游戏， 越狱IOS
-define(PLATFORM_IOS_ASYX, 234). %%爱上游戏
-define(PLATFORM_mumayi, 134).  %% 木蚂蚁
-define(PLATFORM_jifeng, 135).  %% 机峰
-define(PLATFORM_DY, 137).  %% 多元互动
-define(PLATFORM_IOS_DY, 235). %% 多元互动IOS
-define(PLATFORM_IOS_DY_Y, 236). %% 多元互动IOS越狱
-define(PLATFORM_VIVO, 138). %% VIVO
-define(PLATFORM_CoolPad, 139). %% 酷派
-define(PLATFORM_MeiZu, 140). %% 魅族
-define(PLATFORM_Haomeng, 141). %%好盟
-define(PLATFORM_TT, 142). %% TT 广州宜游科技
-define(PLATFORM_CC, 144). %% 虫虫
-define(PLATFORM_GuoPan, 145). %% 果盘
-define(PLATFORM_ShuoWan, 146). %% 说玩
-define(PLATFORM_LeYou, 147). %% 乐游
-define(PLATFORM_PengYouWan, 148). %% 朋友玩
-define(PLATFORM_SIFU_996, 198). %% sf, 非正规渠道
-define(PLATFORM_SIFU_YUFENG, 199). %% sf 云峰
-define(PLATFORM_SIFU_996_FangYou, 197). %% sf 方游
-define(PLATFORM_SIFU_195, 195). %% sf C游
-define(PLATFORM_SIFU_JINZHU, 1000). %% 金猪 下限  1001 爱趣
-define(PLATFORM_SIFU_JINZHU_MAX, 1100). %% 金猪 上限
-define(PLATFORM_SIFU_195_1, 194).
-define(PLATFORM_SIFU_DAMAI, 193). %% sf 大麦

-define(PLATFORM_FAST_LOGIN, 250). %% 快速登录

-define(PLATFORM_AiYouXi, 151). %% 爱游戏


%% 553平台
-define(KEY_PLATFORM_553_VERIFY, "shfihdqhwkhuskdgnlkjioajiwbjdnasce").
-define(KEY_PLATFORM_553_ANDROID_VERIFY, "weuhfwalkwjejahdauhdoqhdohqwoh").
-define(KEY_PLATFORM_553_RECHARGE, "as;djfw75d4fsdkfsd6^&w8a7a;4e52").
-define(KEY_PLATFORM_553_COMMAND, "daslkw75d4p;^fsadh6^&w8a7a;4d82").
-define(KEY_PLATFORM_APPS_VERIFY, "shfihdqhwkhuskdgnlkjioajiwbjdnasce").
%% 360 平台
-define(APP_ID_360, "200455331").
-define(APP_KEY_360, "ad5f4dd4a99318fa02d805878e3aa802").
-define(APP_PRIVATE_KEY_360, "925bea7aee1030525642e6af934b551e").
-define(APP_SECRET_360, "69b1fe3610f6e316fcfad2341a3f1b2d").

%%UC
-define(UC_Test_apiKey, "ec059da8faf505b821b69a9ef80bd2f7").
-define(UC_Test_CPID, 68386).
-define(UC_Test_GameID, 727725).
-define(UC_Test_ServerID, 0).
-define(UC_Test_ChannelID, "2").

-define(UC_Officially_apiKey, "ec059da8faf505b821b69a9ef80bd2f7").
-define(UC_Officially_CPID, 68386).
-define(UC_Officially_GameID, 727725).
-define(UC_Officially_ServerID, 0).
-define(UC_Officially_ChannelID, "2").

%% DY
-define(DY_Officially_apiKey, "9e937c360bd80738dcc30434e5ebdce2").
-define(DY_APPID, 39).
-define(DY_Officially_GameID, "xytl").

%%V5
-define(V5_APP_ID, 10060).
-define(V5_APP_KEY, "c13f40b61e5e9eae1e12f1dcc29e2041").

%% 91平台
-define(APP_ID_91, "109132").
-define(APP_KEY_91, "f938a4baa3027903b077f418d112c83321f786a0d500d557").
-define(APP_ID_91_android, "113233").
-define(APP_KEY_91_android, "3b27b3543c44e9ee7af6cfacbc35a05ab7e8eb06314e97b0").

%% 多酷
-define(DK_APP_ID, "3994").
-define(DK_APP_KEY, "bd94b806fa12ae43a33a2416fad8800a").
-define(DK_APP_Secret, "1f62ea4372f95fcb70288cbadbe55f2e").

%% 当乐
-define(DL_APP_ID, "5840").
-define(DL_APP_KEY, "LGIN7YND").

%% 小米
-define(MI_APP_ID, "2882303761517471450").
-define(MI_APP_KEY, "5911747190450").
-define(MI_APP_Secret, "L0v78UMHJZzS8VEVOFI3pA==").

%% 360
-define(QH_APP_ID, "203039741").
-define(QH_APP_KEY, "c9b11a54bf2a7bc2f62c7db01266afcd").
-define(QH_APP_Secret, "d66f535cf43f9b239d66f92e8508281e").

%% 豌豆荚
-define(Peasecod_APP_ID, "100041288").
-define(Peasecod_APP_KEY, "5c75c96941ac1c2fa7913c0df03a4824").

%% 应用汇
-define(AppChina_APP_ID, "10173").
-define(AppChina_APP_KEY, "22976k6HE1NO99tr").

%% 金立
-define(Gionee_APP_KEY, "293A3AD848194415B7E74164B5BB8D99").
-define(Gionee_APP_Secret, "9C58C024B33C419AADA0B37CE7CC5910").

%% 安智
-define(Anzhi_APP_KEY, "1399188843lXpPeP3oNI32fPNOfV3T").
-define(Anzhi_APP_Secret, "HaeBY04Owp5wNL7Lr0n0rv8D").

%% 37
-define(APP_ID_37, "A496").
-define(APP_KEY_37, "97cd426028d880c2e30b5b59c6029f5c").

%% 应用宝
-define(APP_ID_QQ, "1101360644").
-define(APP_KEY_QQ, "SxlUf1KbVeLeQaO8").

%% OPPO
-define(APP_ID_OPPO, "6682").
-define(APP_KEY_OPPO, "6u0YI0weO7sw8sOSscks8O08k").
-define(APP_Secret_OPPO, "c12D9c9b0ed49Aea51182d621C3297c5").

%% 金山
-define(APP_ID_Kingsoft, "200083").
-define(APP_KEY_Kingsoft, "x52937m332dqv6").

%%91 ios

-define(APP_ID_91_ios, "115809").
-define(APP_KEY_91_ios, "49968638b3ff09c47e1153eb33f51b158d85056fe9bdb956").

%%itools 

-define(APP_ID_itools_ios, "373").

%%当乐ios
-define(DL_APP_ID_Ios, 2066).
-define(DL_APP_KEY_Ios, "hw2smLrJ").

%%快用ios
-define(KY_APP_KEY_Ios, "f6101e536de7d6e1d416a0c8951d5a90").

%% 威游
-define(APP_KEY_WEIYOU, "53e1e672ad5d52").
-define(SERVER_CODE_WEIYOU, "tianzun").

%% xy
-define(APP_ID_XY, "100001189").
-define(APP_KEY_XY, "LjcaxKCylM634y3DJG0eKkbKs17Snjom").

%% 水煮
-define(APP_KEY_SHUIZHU, "WXTZ8096AUEHKBNEYL874UDGVERXCQOP").
-define(APP_CPID_SHUIZHU, 2216).
-define(APP_SERVERID_SHUIZHU, 0).
-define(APP_GAMEID_SHUIZHU, 92).
-define(APP_CHANNELID_SHUIZHU, 0).

%% 爱贝平台
-define(APP_ID_AIBEI, 3000909223).
-define(APP_KEY_AIBEI, "MUI2NjM5RjlDOTFGRjE0NTgwRDQ5NDM1MzM0ODA5NzRGQ0FDNDYzRU1UUTNOVFExT0RRNE9EVTVNemd4TVRjM056RXJNamt5TnprNE1ERXhNREl5TmpZd01USTFOalF6TmpBeU9EUTVPVGs1TWpBMk56YzNNVFE1").

%% 开心平台
-define(APP_GAME_ID_KX, 5546).
-define(APP_LOGIN_TYPE_KX, 2).
-define(APP_SERVER_ID_KX, 991). %% 测试
-define(APP_KEY_KX, "nYp8WqN0AVEksQAYkeqn").

%%光宇游戏平台
-define(APP_CLIENT_ID_GUANGYU, "GYAhWsUXLvUST").
-define(APP_CLIENT_KEY_GUANGYU, "862fe3979421220442a8208244eb21b3").
-define(APP_SERVER_KEY_GUANGYU, "9d5e66c1b8835c3eb10a909e1ecfbbdc").


%%华为
-define(APP_NSP_SVC, "OpenUP.User.getInfo").

%% 联想
-define(APP_Lenovo_Realm, "1605190794828.app.ln").

%% 酷派
-define(APP_CoolPad_AppId, "5000003768").
-define(APP_CoolPad_AppKey, "6a224c3f68aa4cecb369e4539c4ee6c6").
-define(APP_CoolPad_Secret, "MIICXgIBAAKBgQCqJA6WPLw1XfboOCzBoUUi8AIk6zZp1JL4Kkdk9liCrdPVqwXa1oKE2BduSOBvl1nh1eK/2p5bVjacj/bATNT0+3dN+q3U4XAu7fz2QTsnRv7hv66ed0WeO0aZaqgr1umWpZsbZn2DVVg5ljYqnlC3EIKPkbSjfKtGRqcBwaSEsQIDAQABAoGARF+jIQsdU5EEZYQVsGa/4u9y3SVNQ7Bys5pCALfjD/kNNUO6YZxs7TfuCprs3suDCneq3RDdLLVz0u0j61m1BmhHAuPjUwCcJpNSyuxxHsc35zCJenSumRAZaevK3Ae76u/IyjZOclwGlrTt0JZG8H35rAWp16WIIPi4RETl4nUCQQD3r73HAnZ4sGD8QfzI8hL8/VDgTpeuxLOpR/+hEnHZhVb40BCJOLppbSofbIr6CT0yxZOmlzbATt+GNACQAPMLAkEAr9oANVHbWlKxnXZx5oL/5JRMLQXkN3zngun28YlxJCCAm8uTu6jga5pRTaqNjTVIOeJATmXlMbR4jQR8iow8swJBAKhSBN0OXmZsLqyfR2NjpuXIXELjBg+d2x5KMH1MpJQXGmCiPOqT45Krvfl28Qc0aiNrw4htsKaFsz9nbY5vJrsCQQCkH4S+Pu3I+REIc3mOuIj332jRRIRhPVQdnRt7Btnv693cij4RkWYTR23GXP3L4wTL8VwvT25/233/r0ZFUOl9AkEAqhLq2VwWiQVS3GyFolU9ZqhEbk7QBUevN1+SUboKQM4hKDmz3rhUsi+snZqYX+xKBEGgeJuLm546w4X04a5U1A==").

%% 魅族
-define(APP_MeiZu_AppId, "3094252").
-define(APP_MeiZu_Secret, "KhEfdsSFKuglmYalnXmdIcXGjCWAeeJo").

%% 果盘
-define(APP_GuoPan_AppId, "104847").
-define(APP_GuoPan_ServerSecretKey, "4OQR8Q1X9KWLG16LJGN9JGJRIHURIC6UM0C4B729EJV9GCBALGOIURF4FTILG5QP").

%% 说玩
-define(APP_ShuoWan_AppKey, "ed38f50d15ad5b9cb00b98afb04236ea").

%% 爱游戏
-define(APP_AiYouXi_ClientId, "5114243").
-define(APP_AiYouXi_ClientSecret, "ebe9b7b53ae4d7439ccc992cd6b8f602").

%% 996 1
-define(PLATFORM_SIFU_996_FangYou_Gid, "GID146777784794").
-define(PLATFORM_SIFU_996_FangYou_Access_Token, "FlNzE2YTJjMjMyN2FjZmUwMzZhMjYyOTlkMWQ1NDA5MzJi").

%% 996 2
-define(PLATFORM_SIFU_195_AppId, "10116").
-define(PLATFORM_SIFU_195_AppKey, "2aa9abb70aa471269a3805ee8807cb66").

%% 大麦
-define(PLATFORM_SIFU_DAMA, 62034).

%% 海马
-define(APP_HM_AppId, "").

%% 与553平台消息长度定义
-define(CMD_PLATFORM_553_HEADER_SIZE, 8).
-define(CMD_PLATFORM_553_MAX_SIZE, 1024).
%% 公告消息的最大长度，200个汉字以内
-define(CMD_PLATFORM_553_ANNOUNCE_MAX_SIZE, 212).

%% 与553平台消息命令定义
-define(CMD_PLATFORM_553_RECHARGE, 16#0000AA01).
-define(CMD_PLATFORM_553_RECHARGE_RET, 16#0000FF01).
-define(CMD_PLATFORM_553_ACTIVE_CODE, 16#0000AA10).
-define(CMD_PLATFORM_553_ACTIVE_CODE_RET, 16#0000FF10).
-define(CMD_PLATFORM_553_ANNOUNCE, 16#0000AA20).
-define(CMD_PLATFORM_553_COMMAND, 16#0000AA30).
-define(CMD_PLATFORM_553_COMMAND_RET, 16#0000FF30).
-define(CMD_PLATFORM_553_ADD_GSCONFIG, 16#0000AA40).
-define(CMD_PLATFORM_553_ADD_GSCONFIG_RET, 16#0000FF40).
-define(CMD_PLATFORM_553_SUB_GSCONFIG, 16#0000AA50).
-define(CMD_PLATFORM_553_SUB_GSCONFIG_RET, 16#0000FF50).

-define(PLATFORM_RCODE_ACTIVE_CODE_OK, 0).
-define(PLATFORM_RCODE_ACTIVE_CODE_NOGS, -1).
-define(PLATFORM_RCODE_ACTIVE_CODE_NOPLAYER, -2).
-define(PLATFORM_RCODE_ACTIVE_CODE_MAIL_FAILED, -3).

-define(PLATFORM_RCODE_COMMAND_OK, 0).
-define(PLATFORM_RCODE_COMMAND_NOGS, -1).
-define(PLATFORM_RCODE_COMMAND_NOPLAYER, -2).
-define(PLATFORM_RCODE_COMMAND_FAILED, -3).
-define(PLATFORM_RCODE_COMMAND_ERROR_PARAMS, -4).

-define(PLATFORM_RCODE_RECHARGE_OK, 0).
-define(PLATFORM_RCODE_RECHARGE_NOGS, -1).
-define(PLATFORM_RCODE_RECHARGE_NOPLAYER, -2).
-define(PLATFORM_RCODE_RECHARGE_FAILED, -3).  %% 操作失败

-define(PLATFORM_SENDITEM_COUNT, 2).  %% 最多支持给玩家发放物品的数量

%% 指令定义
-define(PLATFORM_COMMAND_SENDITEM, 1).    %% 给玩家发送物品
-define(PLATFORM_COMMAND_BAZZAR, 2).    %% 通知商城重新加载数据
-define(PLATFORM_COMMAND_SENDITEM_EX, 3).  %% 给玩家发放物品扩展
-define(PLATFORM_COMMAND_ADD_GM_USER, 4).  %% 设置某角色为gm用户
-define(PLATFORM_COMMAND_ADD_WHITE_USER, 5).  %% 设置白名单
-define(PLATFORM_COMMAND_ADD_FORBIDDEN_USER_LOGIN, 6).  %% 禁止帐户登陆
-define(PLATFORM_COMMAND_KILLOUT_USER, 7).  %% 踢角色下线
-define(PLATFORM_COMMAND_FORBIDDEN_USER_CHAT, 8).  %% 禁止角色聊天
-define(PLATFORM_COMMAND_FORBIDDEN_ACCOUNT, 9).  %% 限定帐号
-define(PLATFORM_COMMAND_SWITCH_USERID, 11).  %% 将某帐号下某角色的userid转换到某帐号下



-define(PlatForm_ErrorCode_Succ, 0). %%成功
-define(PlatForm_ErrorCode_Server_Is_Not_Exit, 1). %%服务器不存在
-define(PlatForm_ErrorCode_Player_Is_Not_Exit, 2). %%玩家不存在
-define(PlatForm_ErrorCode_UnKnown, 3). %%未知错误
-define(PlatForm_ErrorCode_Player_Is_Not_Online, 4). %%玩家不在线

%%与553平台通知游戏处理充值消息
%% commmand = 0x0000AA01 
-record(pk_LS2Platform553_Recharge, {
  len,
  commmand,
  orderid,
  platform,
  lsid,
  gsid,
  account,
  userid,
  playerid,
  ammount,
  time,
  sign
}).

%%与553平台通知游戏处理充值返回消息
%% commmand = 0x0000FF01 retcode = 0 成功，失败为其他值
-record(pk_LS2Platform553_Recharge_Ret, {
  len,
  commmand,
  orderid,
  platform,
  retcode
}).

%%与553平台通知游戏处理激活码消息
%% commmand = 0x0000AA10 
-record(pk_LS2Platform553_Active_Code, {
  len,
  commmand,
  activecode,
  gsid,
  player,
  type
}).

%%与553平台通知游戏处理激活码返回消息
%% commmand = 0x0000FF10 retcode = 0 成功，失败为其他值
-record(pk_LS2Platform553_Active_Code_Ret, {
  len,
  commmand,
  activecode,
  retcode
}).

%%与553平台通知游戏处理公告消息
%% commmand = 0x0000AA20 
-record(pk_LS2Platform553_Announce, {
  len,
  commmand,
  gsid,
  announceinfo
}).

%%与553平台通知游戏处理GM命令消息
%% commmand = 0x0000AA30 
-record(pk_LS2Platform553_Command, {
  len,
  commmand,
  gsid,
  num,
  cmd,
  params,
  time,
  sign
}).

%%与553平台通知游戏处理GM命令返回消息
%% commmand = 0x0000FF30 retcode = 0 成功，失败为其他值
-record(pk_LS2Platform553_Command_Ret, {
  len,
  commmand,
  num,
  cmd,
  retcode
}).

-endif. % -ifdef(platformDefine_hrl).

-record(pk_LS2Platform553_Add_GsConfig, {
  len,
  commmand,
  serverid,
  name,
  isnew,
  begintime,
  recommend,
  hot
}).

-record(pk_LS2Platform553_Add_GsConfig_Ret, {
  len,
  commmand,
  serverid,
  ret
}).

-record(pk_LS2Platform553_Sub_GsConfig, {
  len,
  commmand,
  serverid
}).
-record(pk_LS2Platform553_Sub_GsConfig_Ret, {
  len,
  commmand,
  serverid,
  ret
}).

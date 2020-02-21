-ifndef(__ERROR_CODE_HRL__).
-define(__ERROR_CODE_HRL__, 1).
%% player login return code 
-define(rCode_Login_Succ, 0).    %%login success
-define(rCode_Login_InvalidVersion, 1).  %% 客户端版本错误
-define(rCode_Login_InvalidAccount, 2).  %% 玩家的账号无效
-define(rCode_Login_Expired, 3).  %% 账号超时
-define(rCode_Login_InvalidSign, 4).  %% 签名错误
-define(rCode_Login_Exception, 5).  %% 异常
-define(rCode_Login_Forbid, 6).  %% 此用名被禁登录
-define(rCode_Login_Exceedmaxcount, 7).  %% 服务器满员

%% create role
-define(rCode_CreatePlayer_Succ, 0).  %% 
-define(rCode_CreatePlayer_Full, 1).  %% 不能再创建新的角色
-define(rCode_CreatePlayer_Name_Invalid, 2).    %% 角色名无效
-define(rCode_CreatePlayer_Name_Exist, 3).    %% 此角色名已存在
-define(rCode_CreatePlayer_Exception, 4).    %% 异常

%% å°å¾è¿å¥éè¯¯åå è¿åå¼
-define(rCode_EnterMap_Invalid_Call, -1).%%æ æçæä½
-define(EnterMap_Fail_Exist_Player, -2).%%å·²ç»å¨å°å¾é
-define(EnterMap_Fail_Exist_Ready_Player, -3).%%å·²ç»å¨ç­å¾ç©å®¶è¿å¥
-define(EnterMap_Fail_CD, -4).%%è¿å¥å¯æ¬CDä¸æ»¡è¶³
-define(EnterMap_Fail_Distance, -5).%%è·ç¦»å¯æ¬å¥å£ä¸æ»¡è¶³
-define(EnterMap_Fail_FightState, -6).%%ææç¶æä¸è½è¿å¥å¯æ¬
-define(EnterMap_Fail_NotTeamLeader, -7).%%ä¸æ¯éé¿ï¼ä¸è½åå»ºå¯æ¬
-define(EnterMap_Fail_PlayerLevel, -8).%%ç­çº§ä¸æ»¡è¶³
-define(EnterMap_Fail_HasTeam, -9).%%å·²ç»å¨éä¼é
-define(EnterMap_Fail_ResetFail_HasPlayer, -10).%%å¯æ¬ä¸­è¿æç©å®¶ï¼éç½®å¤±è´¥
-define(EnterMap_Fail_ResetSucc, -11).%%å¯æ¬éç½®æå
-define(EnterMap_Fail_ResetNomap, -12).%%å¯æ¬éç½®å·²ç»å®æ
-define(EnterMap_Fail_ForceTransOut, 13).%%ç§åå°è¢«ä¼ éåºå¯æ¬
-define(EnterMap_Fail_In_Convoy, 14).%%æ­£å¨æ¤éä¸­ä¸è½è¿å¥å¯æ¬

%% æ»å»å¤±è´¥åå ç 
-define(Attack_Fail_Invalid_Call, -1).%%æ æçæä½
-define(Attack_Fail_Safe_Area, -2).%%å®å¨åºå
-define(Attack_Fail_Team, -3).%%éå
-define(Attack_Fail_Friend, -4). %%åæ¹
-define(Attack_Fail_Self, -5). %%èªå·±
-define(Attack_Fail_PK_Protect, -6).%%pkä¿æ¤ä¸­
-define(Attack_Fail_OpenGuildProtect, -7).%%å¼å¯äºå¸®ä¼ä¿æ¤

%% æ¥ä»»å¡å¤±è´¥éè¯¯ç 
-define(AcceptTask_Success, 0).%%æå
-define(AcceptTask_Fail_TaskID_Not_Exist, -1).%%éç½®è¡¨æ æ­¤ä»»å¡ID
-define(AcceptTask_Fail_Exist_In_AcceptTaskList, -2).%%å·²ç»å­å¨ä»»å¡åè¡¨ä¸­
-define(AcceptTask_Fail_Max_Player_Task, -3).%%å·²ç»å°è¾¾æå¤§å¯æ¥ä»»å¡æ°é
-define(AcceptTask_Fail_Player_Level, -4).%%ç©å®¶ç­çº§ä¸æ»¡è¶³
-define(AcceptTask_Fail_Player_Carrer, -5).%%ç©å®¶èä¸ä¸æ»¡è¶³
-define(AcceptTask_Fail_Has_Completed, -6).%%è¯¥ä»»å¡å·²ç»å®æ
-define(AcceptTask_Fail_PrevTask_Not_Complete, -7).%%åç½®ä»»å¡æªå®æ
-define(AcceptTask_Fail_Npc_Not_Match, -8).%%Npcä¸å¹é

%% å®æä»»å¡å¤±è´¥éè¯¯ç 
-define(CompleteTask_Success, 0).%%æå
-define(CompleteTask_Fail_TaskID_Not_Exist, -1).%%éç½®è¡¨æ æ­¤ä»»å¡ID
-define(CompleteTask_Fail_Not_Exist_In_AcceptTaskList, -2).%%å·²ç»å­å¨ä»»å¡åè¡¨ä¸­
-define(CompleteTask_Fail_Not_Complete_ProgressList, -3).%%æªå®æä»»å¡è¿åº¦
-define(CompleteTask_Fail_Player_Level, -4).%%ç©å®¶ç­çº§ä¸æ»¡è¶³
-define(CompleteTask_Fail_Npc_Not_Match, -5).%%Npcä¸å¹é
-define(CompleteTask_Fail_Bag_Full, -6).%%èåæ»¡äºï¼ä¸è½åå å¥å¥å±éå·


%% åæ¶ä»»å¡å¤±è´¥éè¯¯ç 
-define(CancelTask_Success, 0).%%æå
-define(CancelTask_Fail_TaskID_Not_Exist, -1).%%éç½®è¡¨æ æ­¤ä»»å¡ID


%% æ·»å å¥½å
-define(AddFriend_Success, 0).%%æå
-define(AddFriend_Fail_Max_Friend_Count, -1).%%å¥½åæ°éè¾¾ä¸é
-define(AddFriend_Fail_Friend_Has_Exist, -2).%%è¯¥ç©å®¶å·²ç»å¨å¥½ååè¡¨
-define(AddFriend_Fail_Friend_Not_Found, -3).%%è¯¥ç©å®¶ä¸å¨çº¿
-define(AddFriend_Fail_Friend_In_Blacklist, -4).
-define(AddFriend_Fail_Friend_Cannot_AddSelf, -5).

%% å é¤å¥½å
-define(DelFriend_Success, 0).%%æå
-define(DelFriend_Fail_Friend_Not_Found, -1).%%æ æ­¤ç©å®¶

%% 开始采集
-define(StartGather_Success, 0).
-define(StartGather_Gathering, 1). %% 正在采集
-define(StartGather_Fail_Not_Found, -1).      %% 采集对象没找到
-define(StartGather_Fail_Distance_Err, -2).   %% 采集对象不在采集范围
-define(StartGather_Fail_Interrupted, -2). %%采集被打断

%% 完成采集
-define(CompleteGather_Success, 0).
-define(CompleteGather_Fail_Not_Found, -1).   %% 采集对象没找到
-define(CompleteGather_Fail_Not_Start, -2).   %% 采集未开始
-define(CompleteGather_Fail_Time_Not_Enough, -3).  %% 采集进度未达到

%% chat
-define(Chat_Private_Success, 0).
-define(Chat_Private_Fail_Not_Online, -1).    %% 不在线
-define(Chat_Private_Fail_Not_Exist, -2).    %% 不存在

-endif.




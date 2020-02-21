-ifndef(__CHAT_DEFINE_HRL__).
-define(__CHAT_DEFINE_HRL__, 1).

-define(SystemMessage_Error, 0).  %% 系统错误提示
-define(SystemMessage_System, 1).  %% 系统提示 屏幕中上方黄色字体提示
-define(SystemMessage_Prompt, 2).  %% 系统提示 聊天框内绿色字体提示
-define(SystemMessage_Box, 3).    %% 系统弹出框提示
-define(SystemMessage_Announce1, 4).  %% 系统公告	游戏公告
-define(SystemMessage_Announce2, 5).  %% 系统公告	全服公告

-define(ChannelType_System, 0).  %% 系统频道
-define(ChannelType_World, 1).    %% 世界频道
-define(ChannelType_Guild, 2).    %% 公会频道
-define(ChannelType_Private, 3).  %% 私聊频道
-define(ChannelType_Team, 4).    %% 队伍频道
-define(ChannelType_Near, 5).    %% 普通频道
-define(ChannelType_Map, 6).    %% 普通频道

%%系统消息的展示方式
-define(DisplayType_JianYin, 1).  %% 渐隐系统提示
-define(DisplayType_PaoMaDeng, 2).  %% 跑马灯系统提示
-define(DisplayType_System, 4).  %% 系统提示(所有频道)
-define(DisplayType_PinDao, 8).  %% 频道消息
-define(DisplayType_ShiJie, 16).  %% 系统消息（世界频道）



-define(Chat_time_interval, 2).
-define(Chat_World_time_interval, 24).

-define(Player_ChatType_System_Timestamp, player_ChatType_System_Timestamp).
-define(Player_ChatType_World_Timestamp, player_ChatType_World_Timestamp).
-define(Player_ChatType_Team_Timestamp, player_ChatType_Team_Timestamp).
-define(Player_ChatType_Guild_Timestamp, player_ChatType_Guild_Timestamp).
-define(Player_ChatType_Private_Timestamp, player_ChatType_Private_Timestamp).
-define(Player_ChatType_Near_Timestamp, player_ChatType_Near_Timestamp).

-define(WorldChannelCost, 20000). %%世界频道聊天需要的金币数量

-endif.

-ifndef(playerProcDictKey_hrl).
-define(playerProcDictKey_hrl, 1).

-define(Player_CurPlayerRecord, player_CurPlayerRecord).
-define(Player_PlayerFight_Tmp, player_PlayerFight_Tmp).
-define(Player_PlayerID, player_PlayerID).
-define(Player_AccountId, player_AccountId).
-define(Player_PlayerName, player_PlayerName).

-define(Player_PlayerMapDynamicInfo, player_PlayerMapDynamicInfo).
-define(Player_BagGridNum, player_BagGridNum).
-define(Player_BagDataArray, player_BagDataArray).

-define(Player_AcceptTaskList, player_AcceptTaskList). %record(acceptTask
-define(Player_RepeatCompletedTaskList, player_RepeatCompletedTaskList).%record(repeatCompletedTask
-define(Player_SingleCompletedTaskList, player_SingleCompletedTaskList).%<<>> 据taskDataId作为index,用一个bit表示一个任务是否完成

-define(Player_ShortcutList, player_ShortcutList).

-define(Player_FriendIdList, player_FriendIdList).
-define(Player_FriendInfoList, player_FriendInfoList).

-define(Player_League, player_League).
-define(Player_LeagueIdList, player_LeagueIdList).


-define(Next_Reset_Time_Perday, next_Reset_Time_Perday).
-define(Next_Save_Player_Time, next_Save_Player_Time).
-define(Next_Save_Player_Map_Time, next_Save_Player_Map_Time).
-define(Player_CopyCDInfoList, player_CopyCDInfoList).
-define(Player_ActivedHighCopyList, player_ActivedHighCopyList).  %% [HighCopy_MapDataId] 已激活的精英副本的dataId list

-define(Player_Enter_Copy_Type, player_Enter_Copy_Type). %% temp, don't need save

-define(Player_Start_Gather_Object, player_Start_Gather_Object).
-define(Player_Start_Gather_Time, player_Start_Gather_Time).

-define(Player_Skill_Push_Role_Info_List, player_Skill_Push_Role_Info_List).
-define(Player_Skill_Savage_Collision_Info, player_Skill_Savage_Collision_Info).

-define(Player_Arena_MirrorPlayerId, player_Arena_MirrorPlayerId).
-define(Player_Info_Before_Enter_Arena, player_Info_Before_Enter_Arena).

-define(Player_Info_Before_Enter_LunHuiDao, player_Info_Before_Enter_LunHuiDao).
-define(Player_Info_Before_Enter_MoNiGongCheng, player_Info_Before_Enter_MoNiGongCheng).

-define(Player_Info_Before_Enter_Indiana, player_Info_Before_Enter_Indiana).

-define(Player_Online_Timestamp, player_Online_Timestamp).

-define(Player_Arena_PlayerInfoList, player_Arena_PlayerInfoList).
-define(Player_Arena_CurCount, player_Arena_CurCount).
-define(Player_Arena_Timer, player_Arena_Timer).

-define(Player_SaleTrade_FindTime, saleTradeFindTime).
-define(Player_FindStList, findStList).
-define(Player_LeftFindStList, leftFindStList).
-define(Player_FindStAllCount, findStAllCount).
-define(Player_FindStCurCount, findStCurCount).
-define(Player_ShiftSalePage, shiftSalePage).
-define(Player_CurSalePage, curSalePage).
-define(Player_AttachInfo, player_attachinfo).

%%光宇游戏平台对接， 玩家进程保留生命指纹用于存储日志
-define(PlatformGuangyuLf, platformGuangyuLf).

-endif.

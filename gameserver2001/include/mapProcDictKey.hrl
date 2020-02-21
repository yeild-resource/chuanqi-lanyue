-ifndef(mapProcDictKey_hrl).

-define(mapProcDictKey_hrl, 1).

-define(MapView_Width, mapView_Width).
-define(MapView_Height, mapView_Height).
-define(MapView_MapViewWidthCellCount, mapView_MapViewWidthCellCount).
-define(MapView_MapViewHeightCellCount, mapView_MapViewHeightCellCount).
-define(MapView_MapViewCellsArray, mapView_MapViewCellsArray).


-define(MapView_MapViewCellsArraySize, mapView_MapViewCellsArraySize).

-define(MapView_LogicCellNumX, mapView_LogicCellNumX).
-define(MapView_LogicCellNumY, mapView_LogicCellNumY).

-define(MapView_PhyArraySize, mapView_PhyArraySize).
-define(MapView_PhyArray, mapView_PhyArray).
-define(MapView_RegionList, mapView_RegionList).


-define(MapView_LogicTo9cellIndexArray, mapView_LogicTo9cellIndexArray).
-define(MapView_LogicTo9cellIndexArraySize, mapView_LogicTo9cellIndexArraySize).
-define(MapView_MapViewAroundCellIndexConstArray, mapView_MapViewAroundCellIndexConstArray).




-define(Map_MapID, map_MapID).
-define(Map4Proc_MapDataID, map4Proc_MapDataID).
-define(Map_LineNum, map_LineNum).

-define(Map_MapPlayerEts, map_MapPlayerEts).
-define(Map_MapMonsterEts, map_MapMonsterEts).
-define(Map_MapNpcEts, map_MapNpcEts).
-define(Map_MapItemEts, map_MapItemEts).
-define(Map_MapTrapEts, map_MapTrapEts).

-define(Map_MapOtherEts, map_MapOtherEts).
-define(Map_MapOtherEts_ViewCellsArrayKey, 1).

-define(Map_MapPetEts, map_MapPetEts).


-define(Map_BroadcastPid, map_BroadcastPid).
-define(Map_AIPid, map_AIPid).
-define(Map_FightPid, map_FightPid).

-define(Map_MapFightMonsterEts, map_MapFightMonsterEts).
-define(Map_MapFightPlayerEts, map_MapFightPlayerEts).
-define(Map_MapFightPetEts, map_MapFightPetEts).


-define(Map_LastNoPlayerTime, map_LastNoPlayerTime).
-define(Map_MapType, map_MapType).
-define(Map_CopyMapCompleted, map_CopyMapCompleted).
-define(Map_CopyMapDrawLuckCntList, map_CopyMapDrawLuckCntList).
-define(Map_LeagueCopyMapAwardPlayerList, map_LeagueCopyMapAwardPlayerList).

-define(Map_OwnId, map_OwnId).
-define(Map_RemindClientCloseTimerRef, map_RemindClientCloseTimerRef).
-define(Map_CopyMapDestroyTimerRef, map_CopyMapDestroyTimerRef).


-define(Map_PlayerOrPet_Move_Prev_Ms, map_PlayerOrPet_Move_Prev_Ms).
-define(Map_Virtual_Player_Monster_Extra_LookInfoList, map_Virtual_Player_Monster_Extra_LookInfoList).

-define(Map_MonsterDoor_Id_List, map_MonsterDoor_Id_List).

-define(Map_Init_Time, map_Init_Time).

-define(Map_MonsterDisappearNum, map_MonsterDisappearNum). %% 怪物消失数目
-define(Map_GongChengPlayerIDList, map_GongChengPlayerIDList). %% 参与怪物攻城玩家id列表

-endif.


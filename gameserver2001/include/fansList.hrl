-ifndef(__FANSLIST_HRL__).
-define(__FANSLIST_HRL__, 1).

%% 粉丝ets表
-define(FansListTableAtom, 'FansListTableAtom').
%% 黑名单关系 ets表
-define(BlackListTableAtom, 'BlackListTableAtom').
%% 黑名单详情ets表
-define(BlackInfoTableAtom, 'BlackInfoTableAtom').
%% 仇人 ets表
-define(ArmyTableAtom, 'ArmyTableAtom').
%% 仇人详情ets表
-define(ArmyInfoTableAtom, 'ArmyInfoTableAtom').
%% 玩家魅力值表
-define(FlowerTableAtom, 'FlowerTableAtom').
%% 玩家名字、职业、性别信息
-define(UserNameTableAtom, 'UserNameTableAtom').

%% 玩家粉丝列表 
-record(playerFansList, {playerId, fansIdlist}).
%% 玩家黑名单表
-record(playerBlackList, {playerId, blackIdList}).
%% 黑名单详情表
-record(blackInfo, {playerId, name, level, career, sex}).
%% 玩家仇人表
-record(playerArmyList, {playerId, armyIdList}).
%% 仇人详情表
-record(armyInfo, {playerId, name, level, career, sex}).

-define(PlayerOnline, 1).
-define(PlayerOffline, 0).

%% 黑名单人数上限
-define(BlackListLimit, 80).
%% 仇人名单上限
-define(ArmyListLimit, 80).

-define(BlackListAdd, 1).
-define(BlackListDel, 2).
-define(BlackListUpdate, 3).

-define(ArmyAdd, 1).
-define(ArmyDel, 2).
-define(ArmyUpdate, 3).

%% 打探令空闲
-define(ArmyStatusFree, 0).
%% 打探令进行中
-define(ArmyStatusBusy, 1).

-endif.
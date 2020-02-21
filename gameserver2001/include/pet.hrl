-ifndef(pet_hrl).

-define(pet_hrl, 1).
-include("excelDefine.hrl").
-define(Pet_Type_MythicalAnimal, 1).%%神兽
-define(Pet_Type_Monster, 2). %%怪物



-record(pet, {
  id,
  dataId,              %%配置文件ID
  petType,                         %%
  level,              %%等级
  speed,
  masterId,            %%主人ID

  %exp,							%%当前经验
  onlineSecs = 0,                      %%在线时长，升级后会清0
  name,              %%名字
  hp,                              %% it's also exist in mapFightPlayer, 并且mapFightPlayer里是最新的
  isActive = 1,                        %% 是否活跃，1：active  0:non-active
  skillId = 0,
  cdtime = 0,
  upgrade_secs = 9999999
}).

-record(mapPet, {id, objType, pid, sendPid,
  dataId,              %%配置文件ID
  masterId,
  name,
  petType,                         %%
  level,              %%等级
  moveState, pos, moveTargetList = [],
  speed, speedX = 0, speedY = 0,
  isForbidMove = false, petChangeId}).

-endif.




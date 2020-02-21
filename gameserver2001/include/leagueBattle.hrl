-define(LeagueBattleMapDataId, 9000). %%帮会战副本使用地图ID为9000

-define(CreateMapDay, [ 1, 2, 3]).
-define(LeagueBattleBidEndTime, {20, 0, 0}).
-define(CreateMapTime, {20, 30, 0}).

-record( leagueBattle, {
  id = 0, %%帮会战哪张地图id
  level = 1, %%帮会战地图等级
  defending_id = 0, %%占领者的帮会ID
  defending_player_id_list = [], %%战斗时, 参与守方的帮会玩家ID列表
  offending_id = 0, %%获得进攻权限的帮会ID
  offending_player_id_list = [], %%战斗时, 参与攻方的帮会玩家ID列表
  map_data_id = ?LeagueBattleMapDataId,
  state = 0, %% 0代表不能操作, 1代表已经报名, 2代表正在开打
  map_id = 0, %%地图创建过后, 地图的实例ID
  league_bid = [], %% [ {帮会ID, 竞标资金}, {帮会ID, 竞标资金} ],
  fief = 0, %%已经封地的帮会ID
  sync = 0 %%是否需要更新到数据库
} ).

-record(leagueBattleNpc, {
  npc_id,
  gathering_player_id = 0,
  league_id = 0,
  x,
  y
}).

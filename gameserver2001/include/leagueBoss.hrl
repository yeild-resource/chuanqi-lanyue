-ifndef(__LEAGUE_BOSS_DEFINE_HRL__).
-define(__LEAGUE_BOSS_DEFINE_HRL__, 1).

-record(league_boss, {
  league_id,
  level = 1,
  exp = 0,
  inspire_level = 1,
  pill = 0,
  free_league_inspire_times = 1,
  inspired = 0,
  expire_milli_seconds_timestamp = 0,
  need_to_sync = 1
}).

-define(INSPIRE_REQUIRED_TREASURE, 200).

-define(LEAGUE_BOSS_EXP_ITEM_ID, 39163). %%神兽培养丹
-define(LEAGUE_BOSS_INSPIRE_ITEM_ID, 39164). %%神兽技能丹

-endif.

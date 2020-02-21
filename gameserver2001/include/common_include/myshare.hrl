-ifndef(__MYSHAR_HRL__).
-define(__MYSHAR_HRL__, 1).

%%玩家访问协议的日志保存
-define(ETS_CACHE_LOG_ROUTER, ets_cache_router_log).
-define(ETS_CACHE_SERVER_ENV, ets_cache_server_env).


-define(INT16, 16 / signed - little - integer).
-define(INT8, 8 / signed - little - integer).
-define(INT, 32 / signed - little - integer).
-define(INT64, 64 / signed - little - integer).
-define(UINT, 32 / unsigned - little - integer).

%% 定义一天的秒数
-define(OneDay, 86400).

-endif.

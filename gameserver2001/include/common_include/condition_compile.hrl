-ifndef(__CONDITION_COMPILE_HRL__).
-define(__CONDITION_COMPILE_HRL__, 1).


-ifdef(RELEASE).
-define(Is_Debug_version, false).
-define(Start_Link_TimeOut_ms, 19000).
-define(LOG_LEVEL, log).
-else.
-define(Is_Debug_version, true).
-define(Start_Link_TimeOut_ms, 388000).
-define(LOG_LEVEL, debug).
-endif.

-endif.




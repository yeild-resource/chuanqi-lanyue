-define(GlobalLimitIPTable, limitIPTable).
-record(ipLimit, {ip, connect = 0}).

-define(UseLimitIP, true).

-define(LimitPerIP, 10000).


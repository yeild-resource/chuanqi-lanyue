-ifndef(__TEST_HRL__).
-define(__TEST_HRL__, 1).

-define(IP, "127.0.0.1").
-define(Port, 10000).
-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false},
  {reuseaddr, true}, {nodelay, false},
  {delay_send, true}, {send_timeout, 10000},
  {keepalive, true}, {exit_on_close, true}]).
-define(HEADER_LENGTH, 5).

-endif.


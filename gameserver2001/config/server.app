{application, server,
  [{description, "game server"},
    {vsn, "0.1.0"},
    {modules, [
      tcp_reader,
      tcp_reader_sup,
      tcp_listener,
      tcp_listener_sup,
      tcp_accepter,
      tcp_accepter_sup,
      networking,
      server_app
    ]},
    {registered, []},
    {applications, [kernel, stdlib, sasl]},
    {mod, {server_app, []}}
  ]}.

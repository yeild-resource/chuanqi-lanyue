{application, loginserver,
  [{description, "dragon login server"},
   {vsn, "0.1.0"},
   {modules, [
     gameServer,
     gameServerHandle,
     gsNetListener,
     gsNetServerSup,
     main,
     md5,
     messageBase,
     messageOn,
     msg_LS2GS,
     msg_LS2User,
     netListener,
     netServerSup,

     mysql_auth,
     mysqlCommon,
     mysql_conn,
     mysql,
     mysql_recv

   ]},
   {registered, []},
   {applications, [kernel, stdlib]},
   {mod, {loginserver_app, []}}
  ]}.

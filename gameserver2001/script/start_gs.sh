#!/bin/sh
ulimit -n 10000
cd ../config
erl -detached -smp +K true -pa ../ebin -pa ../deps -env ERL_MAX_ETS_TABLES 32768 -env ERL_MAX_PORTS 10000 -sname gameserver_qanew -setcookie gameserver_qanew -s server start
#erl -noshell -boot start_clean -sname gameserver -pa ../ebin  -s main start
#-kernel inet_dist_listen_min 50000 -kernel inet_dist_listen_max 50000 设置随机端口

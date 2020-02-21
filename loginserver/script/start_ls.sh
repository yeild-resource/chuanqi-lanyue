#!/bin/sh
ulimit -n 65536
cd ../config
erl -detached -smp +K true -pa ../ebin -env ERL_MAX_ETS_TABLES 32768 -env ERL_MAX_PORTS 10000 -sname loginserver -setcookie loginserver -s server start

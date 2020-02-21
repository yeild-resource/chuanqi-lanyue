@echo off
title GameServer
color 1f
set path=C:\erl7.3\bin;%path%
set ip=127.0.0.1
cd config
erl -smp -pa "../ebin" -sasl sasl_error_logger "{file, \"..\\sasl.log\"}" -kernel inet_dist_listen_min 60000 -env ERL_MAX_ETS_TABLES 32768 -name crossserver@%ip% -setcookie dev_gs -s server start
pause
exit
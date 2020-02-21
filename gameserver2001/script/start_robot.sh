#!/bin/bash
cd ../config

ulimit -n 50000

erl -detached -smp +K true -pa ../ebin -env ERL_MAX_ETS_TABLES 32768  -name myrobot@127.0.0.1 -setcookie myrobot -s myrobot start

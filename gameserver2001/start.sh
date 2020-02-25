cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
cd ./config
erl -detached -smp +K true -pz ../ebin/ -pz ../deps/ -env ERL_MAX_ETS_TABLES 32768 -env ERL_MAX_PORTS 10000 -sname s2001 -setcookie gameserver -s server start
echo 'gameserver started'

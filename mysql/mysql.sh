#!/bin/sh
cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
port=3307
mysql_user="root"
#请填写自已数据库密码
mysql_pwd="123456"
cmd_path="`which mysqld_safe`"
mysql_sock="/tmp/mysql_${port}.sock"
 
mysql_start() {
    if [ ! -e "$mysql_sock" ];then
        printf "mysql start ... \n"
        mysqld_safe --defaults-file=${cur_path}/my.cnf 2>&1 > /dev/null &
    else
        printf "mysql is running ... \n"
        exit
    fi
}
 
mysql_stop() {
    if [ ! -e "$mysql_sock" ];then
        printf "mysql is stopped ... \n"
        exit
    else
        printf "mysql stop ... \n"
        mysqladmin -u${mysql_user} -p${mysql_pwd} -S ${mysql_sock} shutdown
    fi
}
 
mysql_restart() {
    printf "mysql restart ... \n"
    mysql_stop
    sleep 2
    mysql_start
}
 
case $1 in
    start) mysql_start ;;
    stop) mysql_stop ;;
    restart) mysql_restart ;;
*)
printf "usage: /data/${port}/mysql {start|stop|restart}\n"
esac

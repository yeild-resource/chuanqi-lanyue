cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
kill -9 $(ps aux|grep erl\ .*\ ../ebin/\ .*\ -sname\ s2001\ .*\ gameserver | grep -v grep | awk '{print $2}')
echo 'gameserver stoped'

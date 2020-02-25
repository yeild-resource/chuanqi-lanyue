cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
cd gameserver2001
./stop.sh
cd ../loginserver
./stop.sh
cd ../mysql
./mysql.sh stop

echo "Server stoped"
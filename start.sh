cur_path=$(cd `dirname $0`; pwd)
cd $cur_path
cd mysql
./mysql.sh start
cd ../loginserver
./start.sh
cd ../gameserver2001
./start.sh

echo "Server started"
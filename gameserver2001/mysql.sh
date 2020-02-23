#!/bin/bash
# export LANG="zh_CN.UTF-8"

# server table column : id name ip port status desc sign isNew regionName allowRechage orders minPlatformId maxPlatformId
# modify serverid,port,order

echo -n "input server_name:"
read server_name
echo -n "input region_name:"
read region_name
mysql --host=127.0.0.1 --port=3307 -uroot -p1987429a -e "
use dragonlogindata;
insert into server values(2001, '${server_name}', '222.187.222.176', 26669, 1, '', '1234567890', 1, '${region_name}', 1, 1, 180, 1001);
quit
"
echo "insert server record"

echo "import database"
mysql --host=127.0.0.1 --port=3307  -p1987429a < structure.sql

#echo "import gift code" 
#mysql --host=127.0.0.1 --port=3307  -p1987429a < giftcodesum.sql 

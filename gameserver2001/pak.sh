#test.sh

#!/bin/bash

# the script use to modify 'structure.sql','server.config' and pack project 
# tips:
# you should use lastest project code 
# you should assign serverid to 's', port to 'p', opentime to 't' when run the script 

#rm ./log/*
 
while getopts "s:p:t:" arg
do
        case $arg in
             s)
                server_id=$OPTARG
                ;;
             p)
                server_port=$OPTARG
                ;;
             t)
                open_time=$OPTARG
                ;;
             ?)
                echo "unkonw argument"
                #exit 1
                ;;
        esac
done

echo "server id is ${server_id}"
echo "server port is ${server_port}"
echo "server open time is ${open_time}"

open_time=`date -d "${open_time}" +%s`
rebateendtime=$[$open_time+604800]

echo "server open time is ${open_time}"
sql=$(echo " "s/dragongamedata[0-9]*/dragongamedata${server_id}/g"")
logsql=$(echo " "s/dragongamelog[0-9]*/dragongamelog${server_id}/g"")
giftsql=$(echo " "s/dragongamedata[0-9]*/dragongamedata${server_id}/g"")

sed -i ${sql} structure.sql
sed -i ${logsql} structure.sql
sed -i ${giftsql} giftcodesum.sql

id=$(echo " "s/server_id,[0-9]*/server_id,${server_id}/g"")
db=$(echo " "s/dragongamedata[0-9]*/dragongamedata${server_id}/g"")
logdb=$(echo " "s/dragongamelog[0-9]*/dragongamelog${server_id}/g"")
port=$(echo " "s/tcp_accept_user_port,[0-9]*/tcp_accept_user_port,${server_port}/g"")
time=$(echo " "s/server_open_timestamp,[0-9]*/server_open_timestamp,${open_time}/g"")
rebatetime=$(echo " "s/pay_rebate_end_timestamp,[0-9]*/pay_rebate_end_timestamp,${rebateendtime}/g"")

cd config
echo "working dir `pwd`" 

sed -i ${id} server.config
sed -i ${db} server.config
sed -i ${logdb} server.config
sed -i ${port} server.config
sed -i ${time} server.config
sed -i ${rebatetime} server.config

cd ..
echo "back to main dir `pwd`"

#tar -czf gameserver${server_id}.tar.gz config deps ebin include script structure.sql giftcodesum.sql pak.sh  




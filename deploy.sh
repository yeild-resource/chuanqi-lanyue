#!/bin/sh
#!/usr/bin/sh
#!/bin/bash
cur_path=$(cd `dirname $0`; pwd)

echo "init mysql"
cd mysql
cat << EOF > "my.cnf"
# Here follows entries for some specific programs
[client]
port = 3307
socket		= /tmp/mysql_3307.sock

# The MySQL server
[mysqld]
user = root
port		= 3307
socket		= /tmp/mysql_3307.sock

datadir=${cur_path}/mysql/data

character-set-server=utf8
collation-server=utf8_general_ci
server_id=3307

[mysqld_safe]
log-error=/var/log/mysqld-3307.log
pid-file=/var/run/mysqld-3307.pid
EOF
chown -R mysql:mysql data
chmod -R 777 data
chmod 777 mysql.sh

cd ..

cd apache2
cat << EOF > "lanyue.conf"
<VirtualHost *:80>
    DocumentRoot ${cur_path}/wwwroot
    ServerName lanyue.mir.yeild.top
</VirtualHost>
EOF
echo "IncludeOptional ${cur_path}/apache2/lanyue.conf" >> /etc/httpd/conf/httpd.conf

cd ..

yum install -y ncurses-devel xmlto perl
wget -c http://erlang.org/download/otp_src_18.0.tar.gz -O otp_src_18.0.tar.gz
tar zxvf otp_src_18.0.tar.gz
cd otp_src_18.0
./configure --prefix=${cur_path}/erlang
make && make install
cd .. && rm -rf otp_src_18.0* 

echo "export PATH=${cur_path}/erlang/bin:\$PATH" >> /etc/profile
source /etc/profile

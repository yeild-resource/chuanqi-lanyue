@echo off
if not exist c:\erl7.3\bin\erl.exe (
echo 正在安装erlang7.3...
start /wait erl7.3.exe
)
set path=%cd%\php;%path%
cd mysql
start bin\mysqld.exe --defaults-file=my.ini
ping 127.1>nul
cd ..\apache2
start /min "DF20166.COMWEB服务" bin\httpd.exe
ping 127.1>nul
cd ..\loginserver
start startls.bat
cd ..\gameserver2001
start startgs.bat

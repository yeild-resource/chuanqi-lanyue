@echo off
taskkill /f /t /im erl.exe
taskkill /f /im httpd.exe
mysql\bin\mysqladmin.exe -uroot -p123456 shutdown
del /s /q *.log
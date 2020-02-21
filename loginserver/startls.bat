@echo off
title LoginServer
color 2f
set path=C:\erl7.3\bin;%path%
cd config
erl -smp +K true -pa ../ebin -sname loginserver -setcookie loginserver -s server start
pause
exit
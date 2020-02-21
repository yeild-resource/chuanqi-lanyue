#!/bin/sh
erl   -sname tmp1234 -setcookie gameserver_qanew -s stop_gameserver stop 'gameserver_qanew@localhost'

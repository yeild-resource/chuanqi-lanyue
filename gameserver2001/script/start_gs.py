#/usr/bin/env python3
import os
import subprocess
import time

def getErl():
    if os.name == 'nt':
        return 'werl'
    else:
        return 'erl'

def getParameters():
    if os.name == 'nt':
        return "  -sname gameserver -pa ../ebin -setcookie gameserver -s server start"
    else:
        return ''' -detached -smp +K true -kernel inet_dist_listen_min 50000 -kernel inet_dist_listen_max 60000 +pc unicode
                    -pa ../ebin -env ERL_MAX_ETS_TABLES 32768 -env ERL_MAX_PORTS 4000 -sname gameserver_qanew -setcookie gameserver_qanew -s server start
                    '''

gameServerPath = '../config'
os.chdir( gameServerPath )
command = getErl() +  getParameters()
subprocess.Popen(command)

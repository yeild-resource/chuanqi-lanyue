#!/usr/bin/env python3

import os
import subprocess
import random

def getErl():
    if os.name == 'nt':
        return 'werl'
    else:
        return 'erl'
                  
erl = getErl()

def getParameters():
    if os.name == 'nt':
#        return '  -pa ../ebin -sname loginserver -setcookie loginserver -s server start '
        r = str(int(random.uniform(1,10000)))
        return ' -pa ../ebin -sname debug' + r + "  -setcookie loginserver -remsh loginserver@tang"
    else:
        return ' -detached -smp +K true -pa ../ebin -env ERL_MAX_ETS_TABLES 32768 -sname loginserver -setcookie loginserver -s server start'

loginServerPath = '../config'
os.chdir(loginServerPath)
command = getErl() + getParameters()
subprocess.Popen(command)

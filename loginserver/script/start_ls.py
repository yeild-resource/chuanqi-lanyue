#!/usr/bin/env python3

import os
import subprocess

def getErl():
    if os.name == 'nt':
        return 'werl'
    else:
        return 'erl'
                  
erl = getErl()

def getParameters():
    if os.name == 'nt':
        return ' -pa ../ebin -sname loginserver -setcookie loginserver -s server start '
    else:
        return ' +pc unicode -detached -smp +K true -pa ../ebin -env ERL_MAX_ETS_TABLES 32768 -sname loginserver -setcookie loginserver -s server start'

loginServerPath = '../config'
os.chdir(loginServerPath)
command = getErl() + getParameters()
subprocess.Popen(command)

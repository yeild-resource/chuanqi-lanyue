#/usr/bin/env python3

import os
import subprocess
import time
import random


def getErl():
    if os.name == 'nt':
        return 'werl'
    else:
        return 'erl'

r = random.uniform(1, 10000000)
parameters = "  -sname debug"+str(int(r))+"  -pa ../ebin -setcookie gameserver_qanew -remsh  gameserver_qanew@tang"

gameServerPath = '../config'
os.chdir( gameServerPath )
command = getErl() +  parameters
subprocess.Popen(command)
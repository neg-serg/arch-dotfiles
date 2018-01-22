#!/usr/bin/env python3


""" i3 window tag circle
Usage:
    runner.py

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2018

"""

import i3ipc
import re
import errno
import os
import time

from sys import exit
from docopt import docopt
from threading import Thread
import importlib

from i3gen import *

import i3ipc

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Daemons runner')

    ScriptDaemonsMap={
        'circle': { "instance": None, "manager": None, },
        'ns': { "instance": None, "manager": None, },
        'flast': { "instance": None, "manager": None, }
    }

    threads=[]

    for mod in ScriptDaemonsMap.keys():
        currm=ScriptDaemonsMap[mod]
        currm["instance"]=getattr(importlib.import_module("%s" % mod + "d"), mod).instance()
        currm["manager"]=daemon_manager.instance()
        currm["manager"].add_daemon(mod)

        def cleanup():
            d = currm["manager"].daemons[mod]
            if os.path.exists(d.fifos[mod]):
                os.remove(d.fifos[mod])

        import atexit
        atexit.register(cleanup)

        th=Thread(target=currm["manager"].daemons[mod].mainloop, args=(currm["instance"], mod, ))
        th.start()
        threads.append(th)

    for mod in ScriptDaemonsMap:
        # you should bypass method itself, no return value
        th=Thread(target=ScriptDaemonsMap[mod]["instance"].i3.main)
        th.start()
        threads.append(th)

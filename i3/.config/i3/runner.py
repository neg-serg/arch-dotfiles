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

from script_i3_general import *

import i3ipc

def Benchmark(func):
    import time
    def wrap_(*args, **kwargs):
        t = time.clock()
        res = func(*args, **kwargs)
        print(func.__name__, time.clock() - t)
        return res
    return wrap_

def Logging(func):
    def wrap_(*args, **kwargs):
        res = func(*args, **kwargs)
        print(func.__name__, args, kwargs)
        return res
    return wrap_

def Counter(func):
    def wrap_(*args, **kwargs):
        wrap_.count += 1
        res = func(*args, **kwargs)
        print("{0} called for: {1}x".format(func.__name__, wrap_.count))
        return res
    wrap_.count = 0
    return wrap_

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Daemons runner')

    ScriptDaemonsMap={
        'circle': { "instance": None, "manager": None, },
        'ns': { "instance": None, "manager": None, },
        'flast': { "instance": None, "manager": None, }
    }

    for mod in ScriptDaemonsMap.keys():
        currm=ScriptDaemonsMap[mod]
        currm["instance"]=getattr(importlib.import_module("%s" % mod + "d"), mod).instance()
        currm["manager"]=daemon_manager.instance()
        currm["manager"].add_daemon(mod)

        def cleanup():
            daemon = dm.daemons[mod]
            if os.path.exists(daemon.fifo_):
                os.remove(daemon.fifo_)

        import atexit
        atexit.register(cleanup)

        Thread(target=currm["manager"].daemons[mod].mainloop, args=(currm["instance"], mod, )).start()

    for mod in ScriptDaemonsMap:
        # you should bypass method itself, no return value
        th=Thread(target=ScriptDaemonsMap[mod]["instance"].i3.main)
        th.start()

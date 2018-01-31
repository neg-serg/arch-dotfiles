#!/usr/bin/env python3
""" i3 listner script
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

import inotify.adapters

from i3gen import *

import i3ipc

class RestartPls(Exception):
    pass

def configure_logging():
    import logging

    log_format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)
    ch = logging.StreamHandler()
    formatter = logging.Formatter(log_format)
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    return logger

def watch(watch_dir, file_path, logger, watched_inotify_event="IN_MODIFY"):
    watch_dir=watch_dir.encode()
    i=inotify.adapters.Inotify()
    i.add_watch(watch_dir)

    try:
        for event in i.event_gen():
            if event is not None:
                (header, type_names, watch_path, filename) = event
                if filename.decode('utf-8') == file_path and watched_inotify_event in type_names:
                    logger.info("WD=(%d) MASK=(%d) COOKIE=(%d) LEN=(%d) MASK->NAMES=%s "
                                "WATCH-PATH=[%s] FILENAME=[%s]",
                                header.wd, header.mask, header.cookie, header.len, type_names,
                                watch_path.decode('utf-8'), filename.decode('utf-8'))
                    raise RestartPls
    finally:
        i.remove_watch(watch_dir)

def main():
    try:
        argv = docopt(__doc__, version='i3 Daemons runner')

        ScriptDaemonsMap={
            'circle': { "instance": None, "manager": None, },
            'ns': { "instance": None, "manager": None, },
            'flast': { "instance": None, "manager": None, }
        }

        threads=[]

        user_name=os.environ.get("USER", "neg")
        xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")
        Thread(target=watch, args=(xdg_config_path+'/i3', 'circle_conf.py', configure_logging(), )).start()

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
    except RestartPls:
        print("Fuck yeah!")
        main()

if __name__ == '__main__':
    main()

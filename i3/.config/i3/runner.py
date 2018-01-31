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
import os
from threading import Thread, Event
import importlib
import logging
import inotify.adapters
import gevent.event
from i3gen import *
import atexit

class Listner():
    def __init__(self):
        self.ev = Event()

    def configure_logging(self):
        log_format = '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        logger = logging.getLogger(__name__)
        logger.setLevel(logging.DEBUG)
        ch = logging.StreamHandler()
        formatter = logging.Formatter(log_format)
        ch.setFormatter(formatter)
        logger.addHandler(ch)

        return logger

    def watch(self, watch_dir, file_path, logger, watched_inotify_event="IN_MODIFY"):
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
                        self.ev.set()
                        i.remove_watch(watch_dir)
                        break
        finally:
            i.remove_watch(watch_dir)

    def main(self):
        def cleanup():
            d = currm["manager"].daemons[mod]
            if os.path.exists(d.fifos[mod]):
                os.remove(d.fifos[mod])
        atexit.register(cleanup)

        ScriptDaemonsMap={
            'circle': { "instance": None, "manager": None, },
            'ns': { "instance": None, "manager": None, },
            'flast': { "instance": None, "manager": None, }
        }

        user_name=os.environ.get("USER", "neg")
        xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")
        for mod in ScriptDaemonsMap.keys():
            inotify_thread=Thread(target=self.watch, args=(xdg_config_path+'/i3', mod + '_conf.py', self.configure_logging(), ))
            inotify_thread.setDaemon(False)
            inotify_thread.start()

        for mod in ScriptDaemonsMap.keys():
            currm=ScriptDaemonsMap[mod]
            currm["instance"]=getattr(importlib.import_module("%s" % mod + "d"), mod).instance()
            currm["manager"]=daemon_manager.instance()
            currm["manager"].add_daemon(mod)

            th=Thread(target=currm["manager"].daemons[mod].mainloop, args=(currm["instance"], mod, ))
            th.setDaemon(True)
            th.start()

        # you should bypass method itself, no return value
        for mod in ScriptDaemonsMap:
            th=Thread(target=ScriptDaemonsMap[mod]["instance"].i3.main)
            th.setDaemon(True)
            th.start()

        if self.ev.wait():
            raise RestartMe

class RestartMe(Exception):
    pass

if __name__ == '__main__':
    while True:
        listner = Listner()
        try:
            print("STARTED")
            listner.main()
        except RestartMe:
            del listner

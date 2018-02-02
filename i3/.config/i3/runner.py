#!/usr/bin/env python3
""" i3 listner script
Usage:
    runner.py

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2018

"""

import os
from threading import Thread, Event
import importlib
import inotify.adapters
from i3gen import *
import atexit
import subprocess
import shlex

class Listner():
    def __init__(self):
        self.ev = Event()
        self.modules = set()
        self.__daemons_default_state={
            'circle': { "instance": None, "manager": None, },
            'ns': { "instance": None, "manager": None, },
            'flast': { "instance": None, "manager": None, }
        }
        self.daemons_map=self.__daemons_default_state
        user_name=os.environ.get("USER", "neg")
        self.xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")

    def watch(self, watch_dir, file_path, watched_inotify_event="IN_MODIFY"):
        watch_dir=watch_dir.encode()
        i=inotify.adapters.Inotify()
        i.add_watch(watch_dir)

        try:
            for event in i.event_gen():
                if event is not None:
                    (header, type_names, watch_path, filename) = event
                    if filename.decode('utf-8') == file_path and watched_inotify_event in type_names:
                        self.ev.set()
        finally:
            i.remove_watch(watch_dir)

    def run_inotify(self):
        for mod in self.daemons_map.keys():
            inotify_thread=Thread(target=self.watch, args=(self.xdg_config_path+'/i3', mod + '_conf.py', ))
            inotify_thread.setDaemon(False)
            inotify_thread.start()

    def load_modules(self):
        for mod in self.daemons_map.keys():
            currm=self.daemons_map[mod]
            i3mod=importlib.import_module("%s" % mod + "d")
            self.modules.add(i3mod)
            currm["instance"]=getattr(i3mod, mod).instance()
            currm["manager"]=daemon_manager.instance()
            currm["manager"].add_daemon(mod)

            th=Thread(target=currm["manager"].daemons[mod].mainloop, args=(currm["instance"], mod, ))
            th.setDaemon(False)
            th.start()

    def return_to_i3main(self):
        # you should bypass method itself, no return value
        for mod in self.daemons_map:
            th=Thread(target=self.daemons_map[mod]["instance"].i3.main)
            th.setDaemon(False)
            th.start()

    def cleanup(self):
        def cleanup_():
            d = currm["manager"].daemons[mod]
            if os.path.exists(d.fifos[mod]):
                os.remove(d.fifos[mod])
        atexit.register(cleanup)

    def main(self):
        self.load_modules()
        self.run_inotify()
        self.return_to_i3main()

        while True:
            if self.ev.wait():
                self.ev.clear()
                for mod in self.daemons_map.keys():
                    subprocess.Popen(
                        shlex.split(self.xdg_config_path + "/i3/send.py " + mod + " reload")
                    )

if __name__ == '__main__':
    listner = Listner()
    listner.main()

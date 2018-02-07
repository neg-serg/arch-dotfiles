#!/usr/bin/env pypy3
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
import atexit
import subprocess
import shlex
from i3gen import *

class Listner():
    def __init__(self):
        self.i3_module_event = Event()
        self.i3_config_event = Event()
        self.__daemons_default_state={
            'circle': { "instance": None, "manager": None, },
            'ns': { "instance": None, "manager": None, },
            'flast': { "instance": None, "manager": None, }
        }
        self.daemons_map=self.__daemons_default_state
        user_name=os.environ.get("USER", "neg")
        self.xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")

    def watch(self, watch_dir, file_path, ev, watched_inotify_event="IN_MODIFY"):
        watch_dir=watch_dir.encode()
        i=inotify.adapters.Inotify()
        i.add_watch(watch_dir.decode())

        try:
            for event in i.event_gen():
                if event is not None:
                    (header, type_names, watch_path, filename) = event
                    if filename == file_path and watched_inotify_event in type_names:
                        ev.set()
        finally:
            i.remove_watch(watch_dir)

    def i3_module_inotify(self):
        for mod in self.daemons_map.keys():
            inotify_thread=Thread(target=self.watch, args=(self.xdg_config_path+'/i3', mod + '_conf.py', self.i3_module_event))
            inotify_thread.setDaemon(True)
            inotify_thread.start()

    def i3_config_inotify(self):
        inotify_thread=Thread(target=self.watch, args=(self.xdg_config_path+'/i3', '_config', self.i3_config_event))
        inotify_thread.setDaemon(True)
        inotify_thread.start()

    def load_modules(self):
        for mod in self.daemons_map.keys():
            currm=self.daemons_map[mod]
            i3mod=importlib.import_module("%s" % mod + "d")
            currm["instance"]=getattr(i3mod, mod).instance()
            currm["manager"]=daemon_manager.instance()
            currm["manager"].add_daemon(mod)

            th=Thread(target=currm["manager"].daemons[mod].mainloop, args=(currm["instance"], mod, ))
            th.setDaemon(True)
            th.start()

    def return_to_i3main(self):
        # you should bypass method itself, no return value
        for mod in self.daemons_map:
            th=Thread(target=self.daemons_map[mod]["instance"].i3.main)
            th.setDaemon(False)
            th.start()

    def cleanup_on_exit(self):
        def cleanup_everything():
            for mod in self.daemons_map.keys():
                fifo=self.daemons_map[mod]["manager"].daemons[mod].fifos[mod]
                if os.path.exists(fifo):
                    os.remove(fifo)
        atexit.register(cleanup_everything)

    def i3_config_reload_thread(self):
        def reload_thread_payload():
            while True:
                if self.i3_config_event.wait():
                    self.i3_config_event.clear()
                    with open(self.xdg_config_path + "/i3/config", "w") as fp:
                        subprocess.Popen(
                            shlex.split("ppi3 " + self.xdg_config_path + "/i3/_config"),
                            stdout=fp
                        )
        th=Thread(target=reload_thread_payload)
        th.setDaemon(True)
        th.start()

    def i3_module_reload_thread(self):
        def reload_thread_payload():
            while True:
                if self.i3_module_event.wait():
                    self.i3_module_event.clear()
                    for mod in self.daemons_map.keys():
                        subprocess.Popen(
                            shlex.split(self.xdg_config_path + "/i3/send.py " + mod + " reload")
                        )
        th=Thread(target=reload_thread_payload)
        th.setDaemon(True)
        th.start()

    def main(self):
        self.cleanup_on_exit()
        self.load_modules()
        self.i3_module_inotify()
        self.i3_module_reload_thread()
        self.i3_config_inotify()
        self.i3_config_reload_thread()
        self.return_to_i3main()

if __name__ == '__main__':
    listner = Listner()
    listner.main()

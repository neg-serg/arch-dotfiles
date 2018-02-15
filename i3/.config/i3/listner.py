#!/usr/bin/python3
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
import toml
from i3gen import *

class Listner():
    def __init__(self):
        self.i3_module_event = Event()
        self.i3_config_event = Event()
        self.mods={'circle': {}, 'ns': {}, 'flast': {}}
        user_name=os.environ.get("USER", "neg")
        xdg_config_path=os.environ.get("XDG_CONFIG_HOME", "/home/" + user_name + "/.config/")
        self.i3_path=xdg_config_path+"/i3/"

    def watch(self, watch_dir, file_path, ev, watched_inotify_event="IN_MODIFY"):
        watch_dir=watch_dir.encode()
        i=inotify.adapters.Inotify()
        i.add_watch(watch_dir)

        try:
            for event in i.event_gen():
                if event is not None:
                    (header, type_names, watch_path, filename) = event
                    if filename.decode() == file_path and watched_inotify_event in type_names:
                        ev.set()
        finally:
            i.remove_watch(watch_dir)

    def i3_module_inotify(self):
        for mod in self.mods.keys():
            Thread(target=self.watch, args=(self.i3_path, mod + '.cfg', self.i3_module_event), daemon=True).start()

    def i3_config_inotify(self):
        Thread(target=self.watch, args=(self.i3_path, '_config', self.i3_config_event), daemon=True).start()

    def dump_configs(self):
        try:
            for mod in self.mods.keys():
                m=self.mods[mod]
                with open(self.i3_path + mod + ".cfg", "w") as fp:
                    toml.dump(m["instance"].cfg, fp)
        except:
            pass

    def load_modules(self):
        for mod in self.mods.keys():
            cm=self.mods[mod]
            i3mod=importlib.import_module("%s" % mod + "d")
            cm["instance"]=getattr(i3mod, mod).instance()
            cm["manager"]=daemon_manager.instance()
            cm["manager"].add_daemon(mod)
            Thread(target=cm["manager"].daemons[mod].mainloop, args=(cm["instance"], mod,), daemon=True).start()

    def return_to_i3main(self):
        # you should bypass method itself, no return value
        for mod in self.mods:
            Thread(target=self.mods[mod]["instance"].i3.main, daemon=False).start()

    def cleanup_on_exit(self):
        def cleanup_everything():
            for mod in self.mods.keys():
                fifo=self.mods[mod]["manager"].daemons[mod].fifos[mod]
                if os.path.exists(fifo):
                    os.remove(fifo)
        atexit.register(cleanup_everything)

    def i3_config_reload_thread(self):
        def reload_thread_payload():
            while True:
                if self.i3_config_event.wait():
                    self.i3_config_event.clear()
                    with open(self.i3_path + "/config", "w") as fp:
                        p=subprocess.Popen(
                            shlex.split("ppi3 " + self.i3_path + "_config"),
                            stdout=fp
                        )
                        (output, err) = p.communicate()
                        p_status = p.wait()
                    check_config = subprocess.run(['i3', '-C'], stdout=subprocess.PIPE).stdout.decode('utf-8')
                    if len(check_config):
                        subprocess.Popen(
                            shlex.split("notify-send '{}'".format(check_config.encode('utf-8')))
                        )
                    check_config=""
        Thread(target=reload_thread_payload, daemon=True).start()

    def i3_module_reload_thread(self):
        def reload_thread_payload():
            while True:
                if self.i3_module_event.wait():
                    self.i3_module_event.clear()
                    for mod in self.mods.keys():
                        subprocess.Popen(
                            shlex.split(self.i3_path + "send " + mod + " reload")
                        )
        Thread(target=reload_thread_payload, daemon=True).start()

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

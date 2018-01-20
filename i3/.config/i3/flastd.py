#!/usr/bin/env python3

"""

Focus last focused window.

Usage:
    flastd.py

Options:
    -h, --help  show this help message and exit

"""

import i3ipc
import os

from threading import Thread
from queue import Queue
import time

from singleton_mixin import *
from script_i3_general import *

max_win_history_ = 10

class flast(SingletonMixin):
    def __init__(self):
        self.window_list = i3.get_tree().leaves()
        self.prev_time = 0
        self.curr_time = 0

        self.i3 = i3ipc.Connection()
        wmii_like_goback=True

        self.i3.on('window::focus', self.on_window_focus)
        if wmii_like_goback:
            self.i3.on('window::close', self.go_back_if_nothing)

    def switch(self, args):
        switch_ = {
            "switch": self.alt_tab,
        }
        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

    def alt_tab(self, timer=0.05):
        self.curr_time = time.time()
        windows = set(w.id for w in i3.get_tree().leaves())
        for wid in self.window_list[1:]:
            if wid not in windows:
                self.window_list.remove(wid)
            else:
                if self.curr_time - self.prev_time > timer:
                    i3.command('[con_id=%s] focus' % wid)
                    self.prev_time = self.curr_time
                    self.curr_time = time.time()
                break

    def on_window_focus(self, i3, event):
        wid = event.container.id

        if wid in self.window_list:
            self.window_list.remove(wid)

        self.window_list.insert(0, wid)
        if len(self.window_list) > max_win_history_:
            del self.window_list[max_win_history_:]

    def go_back_if_nothing(self, i3, event):
        con=event.container
        focused_=self.i3.get_tree().find_focused()
        if not len(find_visible_windows(get_windows_on_ws())) \
        and "[pic]" in focused_.workspace().name:
            self.alt_tab(0)

if __name__ == '__main__':
    fw = flast.instance()
    fw.daemon_name='flastd-i3'

    daemon_manager = daemon_manager.instance()
    daemon_manager.add_daemon(fw.daemon_name)

    def cleanup_all_daemons():
        daemon = daemon_manager.daemons[fw.daemon_name]
        if os.path.exists(daemon.fifo_):
            os.remove(daemon.fifo_)

    import atexit
    atexit.register(cleanup_all_daemons)

    mainloop=Thread(target=daemon_manager.daemons[fw.daemon_name].mainloop, args=(fw,)).start()
    fw.i3.main()

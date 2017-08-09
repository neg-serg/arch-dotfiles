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
from docopt import docopt
from queue import Queue
import time

from singleton_mixin import *
from script_i3_general import *

max_win_history_ = 10

class FocusWatcher(SingletonMixin):
    def __init__(self):
        self.window_list = i3.get_tree().leaves()
        self.prev_time = 0
        self.curr_time = 0

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

def on_window_focus(self, event):
    wid = event.container.id
    fw=FocusWatcher.instance()

    if wid in fw.window_list:
        fw.window_list.remove(wid)

    fw.window_list.insert(0, wid)
    if len(fw.window_list) > max_win_history_:
        del fw.window_list[max_win_history_:]

def go_back_if_nothing(self, event):
    con=event.container
    fw=FocusWatcher.instance()
    focused_=i3.get_tree().find_focused()
    if not len(find_visible_windows(get_windows_on_ws())) \
       and "[pic]" in focused_.workspace().name:
        fw.alt_tab(0)

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 nice alt-tab 1.0')
    i3 = i3ipc.Connection()
    wmii_like_goback=True

    name='flastd-i3'

    fw=FocusWatcher.instance()

    mng=daemon_manager.instance()
    mng.add_daemon(name)

    def cleanup_all():
        daemon_=mng.daemons[name]
        if os.path.exists(daemon_.fifo_):
            os.remove(daemon_.fifo_)

    import atexit
    atexit.register(cleanup_all)

    i3.on('window::focus', on_window_focus)
    if wmii_like_goback:
        i3.on('window::close', go_back_if_nothing)

    mainloop=Thread(target=mng.daemons[name].mainloop, args=(fw,)).start()

    i3.main()

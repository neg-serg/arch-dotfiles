import i3ipc
import os
from subprocess import check_output
from singleton_mixin import *
from i3gen import *

class flast(SingletonMixin):
    def __init__(self):
        self.i3 = i3ipc.Connection()
        self.window_list = self.i3.get_tree().leaves()
        self.max_win_history = 64
        self.i3.on('window::focus', self.on_window_focus)
        self.i3.on('window::close', self.go_back_if_nothing)

    def reload_config(self):
        self.__init__()

    def switch(self, args):
        switch_ = {
            "switch": self.alt_tab,
            "reload": self.reload_config,
        }
        try:
            switch_[args[0]](*args[1:])
        except:
            pass

    def alt_tab(self):
        for wid in self.window_list[1:]:
            if wid not in set(w.id for w in self.i3.get_tree().leaves()):
                self.window_list.remove(wid)
            else:
                self.i3.command('[con_id=%s] focus' % wid)
                return

    def on_window_focus(self, i3, event):
        wid = event.container.id

        if wid in self.window_list:
            self.window_list.remove(wid)

        self.window_list.insert(0, wid)
        if len(self.window_list) > self.max_win_history:
            del self.window_list[self.max_win_history:]

    def get_windows_on_ws(self):
        return filter(
            lambda win: win.window,
            self.i3.get_tree().find_focused().workspace().descendents()
        )

    def find_visible_windows(self):
        visible_windows = []
        for w in self.get_windows_on_ws():
            xprop = check_output(['xprop', '-id', str(w.window)]).decode()
            if '_NET_WM_STATE_HIDDEN' not in xprop:
                visible_windows.append(w)
        return visible_windows

    def go_back_if_nothing(self, i3, event):
        focused=i3.get_tree().find_focused()
        if not len(self.find_visible_windows()):
            for ws in ["pic", "media"]:
                if ws in focused.workspace().name:
                    self.alt_tab()
                    return

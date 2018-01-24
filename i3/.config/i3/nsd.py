#!/usr/bin/env python3
import i3ipc

from ns_conf import *

from singleton_mixin import *
from i3gen import *
from threading import Thread

import uuid
import re
import errno
import os

from typing import Callable, List
from timeit import default_timer as timer

class ns(SingletonMixin):
    def __init__(self) -> None:
        self.group_list=[]
        self.fullscreen_list=[]
        self.factors=["class", "instance", "class_r"]
        self.cfg_module=ns_settings()
        self.cfg=self.cfg_module.settings
        self.marked={i:[] for i in self.cfg}

        [self.group_list.append(tag) for tag in self.cfg]

        self.i3 = i3ipc.Connection()

        self.mark_all(hide=True)

        self.i3.on('window::new', self.mark_group)
        self.i3.on('window::close', self.cleanup_mark)

    def make_mark(self, tag: str) -> str:
        uuid_str = str(str(uuid.uuid4().fields[-1]))
        output = "%(tag)s-%(uuid_str)s" % {"tag":tag, "uuid_str":uuid_str}
        return 'mark {}'.format(output)

    def focus(self, tag: str) -> None:
        [
            win.command('move container to workspace current')
            for _,win in enumerate(self.marked[tag])
        ]

    def unfocus(self, tag: str) -> None:
        [
            win.command('move scratchpad')
            for _,win in enumerate(self.marked[tag])
        ]
        self.restore_fullscreens()

    def find_visible_windows(self):
        def get_windows_on_ws():
            return filter(
                lambda x: x.window,
                self.i3.get_tree().find_focused().workspace().descendents()
            )
        visible_windows = []
        wswins=get_windows_on_ws()
        for w in wswins:
            try:
                xprop = check_output(['xprop', '-id', str(w.window)]).decode()
            except FileNotFoundError:
                raise SystemExit("The `xprop` utility is not found!"
                                " Please install it and retry.")
            if '_NET_WM_STATE_HIDDEN' not in xprop:
                visible_windows.append(w)
        return visible_windows

    def toggle(self, tag : str) -> None:
        if self.marked[tag] == [] and "prog" in self.cfg[tag]:
            self.i3.command("exec {}".format(self.cfg[tag]["prog"]))

        # We need to hide scratchpad it is visible, regardless it focused or not
        focused = self.i3.get_tree().find_focused()

        if self.visible(tag) > 0:
            self.unfocus(tag)
            return

        for i in self.marked[tag]:
            if focused.id == i.id:
                self.unfocus(tag); return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(tag)

    def run_prog(self, tag: str, app : str) -> None:
        if "prog_dict" in self.cfg[tag] and app in self.cfg[tag]["prog_dict"]:
            class_list=[win.window_class for win in self.marked[tag]]
            target_class_list=self.cfg[tag]["prog_dict"][app]["includes"]
            target_class_list_set=set(target_class_list)
            interlist=[val for val in class_list if val in target_class_list_set]
            if not len(interlist):
                self.i3.command("exec {}".format(self.cfg[tag]["prog_dict"][app]["prog"]))
            else:
                def focus_subgroup(tag: str):
                    focused=self.i3.get_tree().find_focused()

                    if focused.fullscreen_mode:
                        focused.command('fullscreen toggle')
                        self.fullscreen_list.append(focused)

                    if focused.window_class in target_class_list_set:
                        return

                    self.focus(tag)

                    visible_windows = self.find_visible_windows()
                    for w in visible_windows:
                        for i in self.marked[tag]:
                            if w.id == i.id:
                                self.i3.command('[con_id=%s] focus' % w.id)

                    for index,i in enumerate(self.marked[tag]):
                        if not focused.window_class in target_class_list_set:
                            if self.marked[tag][index].window_class not in target_class_list_set:
                                self.next_win()
                        else:
                            break
                focus_subgroup(tag)
        else:
            self.toggle(tag)

    def restore_fullscreens(self) -> None:
        [i.command('fullscreen toggle') for i in self.fullscreen_list]
        self.fullscreen_list=[]

    def visible(self, tag: str):
        visible_windows = self.find_visible_windows()
        vmarked = 0
        for w in visible_windows:
            for i in self.marked[tag]:
                vmarked+=(w.id == i.id)
        return vmarked

    def get_current_group(self, focused) -> str:
        for tag in self.cfg:
            for i in self.marked[tag]:
                if focused.id == i.id:
                    return tag

    def apply_to_current_group(self, func : Callable) -> bool:
        curr_group=self.get_current_group(self.i3.get_tree().find_focused())
        curr_group_exits=(curr_group != None)
        if curr_group_exits:
            func(curr_group)
        return curr_group_exits

    def next_win(self) -> None:
        focused_=self.i3.get_tree().find_focused()

        def next_win_(tag: str) -> None:
            self.focus(tag)
            for number,win in enumerate(self.marked[tag]):
                if focused_.id != win.id:
                    self.marked[tag][number].command('move container to workspace current')
                    self.marked[tag].insert(len(self.marked[tag]), self.marked[tag].pop(number))
                    win.command('move scratchpad')
            self.focus(tag)

        self.apply_to_current_group(next_win_)

    def hide_current(self) -> None:
        groupwins=self.apply_to_current_group(self.unfocus)
        if not groupwins:
            self.i3.command('[con_id=__focused__] scratchpad show')

    def geom_restore_all(self) -> None:
        for tag in self.cfg:
            geom_restore(tag)

    def geom_restore(self, tag: str) -> None:
        for j,win in enumerate(self.marked[tag]):
            # delete previous mark
            del self.marked[tag][j]

            # then make a new mark and move scratchpad
            win_cmd="%(make_mark)s, move scratchpad, %(get_geom)s" % {
                "make_mark": self.make_mark(tag),
                "get_geom": self.cfg_module.get_geom(tag)
            }
            win.command(win_cmd)
            self.marked[tag].append(win)

    def geom_restore_current(self) -> None:
        groupwins=self.apply_to_current_group(self.geom_restore)

    def switch(self, args : List) -> None:
        switch_ = {
            "show": self.focus,
            "hide": self.unfocus,
            "next": self.next_win,
            "toggle": self.toggle,
            "hide_current": self.hide_current,
            "geom_restore": self.geom_restore_current,
            "run": self.run_prog,
        }
        switch_[args[0]](*args[1:])

    def match(self, win, factor, tag):
        if factor == "class":
            return win.window_class in self.cfg.get(tag,{}).get(factor, {})
        elif factor == "instance":
            return win.window_instance in self.cfg.get(tag,{}).get(factor, {})
        elif factor == "class_r":
            regexes=self.cfg.get(tag,{}).get(factor, {})
            for reg in regexes:
                cls_by_regex=self.i3.get_tree().find_classed(reg)
                if cls_by_regex:
                    for class_regex in cls_by_regex:
                        if win.window_class == class_regex.window_class:
                            return True

    def mark_group(self, i3, event) -> None:
        con=event.container
        for tag in self.cfg:
            for factor in self.factors:
                if self.match(con, factor, tag):
                    # scratch_move
                    con_cmd="%(make_mark)s, move scratchpad, %(get_geom)s" % {
                        "make_mark": self.make_mark(tag),
                        "get_geom": self.cfg_module.get_geom(tag)
                    }
                    con.command(con_cmd)
                    self.marked[tag].append(con)
                    break

    def mark_all(self, hide : bool=True) -> None:
        window_list = self.i3.get_tree().leaves()
        for tag in self.cfg:
            for con in window_list:
                for factor in self.factors:
                    if self.match(con, factor, tag):
                        # scratch move
                        hide_cmd=''
                        if hide:
                            hide_cmd='[con_id=__focused__] scratchpad show'
                        con_cmd="%(make_mark)s, move scratchpad, %(get_geom)s, %(hide_cmd)s" % \
                            {
                                "make_mark": self.make_mark(tag),
                                "get_geom": self.cfg_module.get_geom(tag),
                                "hide_cmd": hide_cmd
                            }
                        con.command(con_cmd)
                        self.marked[tag].append(con)
                        break

    def cleanup_mark(self, i3, event) -> None:
        for tag in self.cfg:
            for j,win in enumerate(self.marked[tag]):
                if win.id == event.container.id:
                    del self.marked[tag][j]

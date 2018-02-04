#!/usr/bin/env python3
import i3ipc
import importlib
import ns_conf
import uuid
import re
import os
import shlex
from subprocess import check_output
from singleton_mixin import *
from i3gen import *
from typing import Callable, List

class ns(SingletonMixin):
    def __init__(self) -> None:
        self.fullscreen_list=[]
        self.factors=["class", "instance", "class_r"]
        self.cfg_module=ns_conf.ns_settings()
        self.cfg=self.cfg_module.settings
        self.marked={l:[] for l in self.cfg}
        self.i3 = i3ipc.Connection()
        self.mark_all_tags(hide=True)

        self.i3.on('window::new', self.mark_tag)
        self.i3.on('window::close', self.unmark_tag)

    def reload_config(self):
        prev_conf=self.cfg
        try:
            importlib.reload(ns_conf)
            self.__init__()
        except:
            self.cfg=prev_conf
            self.__init__()

    def make_mark_str(self, tag: str) -> str:
        uuid_str = str(str(uuid.uuid4().fields[-1]))
        return 'mark {}'.format("%(tag)s-%(uuid_str)s" % {"tag":tag, "uuid_str":uuid_str})

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
        if not len(self.marked[tag]) and "prog" in self.cfg[tag]:
            prog_str=re.sub("~", os.path.realpath(os.path.expandvars("$HOME")), self.cfg[tag]["prog"])
            self.i3.command('exec {}'.format(prog_str))

        if self.visible(tag) > 0:
            self.unfocus(tag)
            return

        # We need to hide scratchpad it is visible, regardless it focused or not
        focused = self.i3.get_tree().find_focused()

        for i in self.marked[tag]:
            if focused.id == i.id:
                self.unfocus(tag)
                return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(tag)

    def run_prog(self, tag: str, app : str) -> None:
        if "prog_dict" in self.cfg[tag] and app in self.cfg[tag]["prog_dict"]:
            class_list=[win.window_class for win in self.marked[tag]]
            target_class_list_set=set(self.cfg[tag]["prog_dict"][app]["includes"])
            interlist=[val for val in class_list if val in target_class_list_set]
            if not len(interlist):
                prog_str=re.sub("~", os.path.realpath(os.path.expandvars("$HOME")), self.cfg[tag]["prog_dict"][app]["prog"])
                self.i3.command('exec {}'.format(prog_str))
            else:
                def focus_sub_tag(tag: str):
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
                focus_sub_tag(tag)
        else:
            self.toggle(tag)

    def restore_fullscreens(self) -> None:
        [win.command('fullscreen toggle') for win in self.fullscreen_list]
        self.fullscreen_list=[]

    def visible(self, tag: str):
        visible_windows = self.find_visible_windows()
        vmarked = 0
        for w in visible_windows:
            for i in self.marked[tag]:
                vmarked+=(w.id == i.id)
        return vmarked

    def get_current_tag(self, focused) -> str:
        for tag in self.cfg:
            for i in self.marked[tag]:
                if focused.id == i.id:
                    return tag

    def apply_to_current_tag(self, func : Callable) -> bool:
        curr_tag=self.get_current_tag(self.i3.get_tree().find_focused())
        curr_tag_exits=(curr_tag != None)
        if curr_tag_exits:
            func(curr_tag)
        return curr_tag_exits

    def next_win(self) -> None:
        focused_win=self.i3.get_tree().find_focused()

        def next_win_(tag: str) -> None:
            self.focus(tag)
            for number,win in enumerate(self.marked[tag]):
                if focused_win.id != win.id:
                    self.marked[tag][number].command('move container to workspace current')
                    self.marked[tag].insert(len(self.marked[tag]), self.marked[tag].pop(number))
                    win.command('move scratchpad')
            self.focus(tag)

        self.apply_to_current_tag(next_win_)

    def hide_current(self) -> None:
        if not self.apply_to_current_tag(self.unfocus):
            self.i3.command('[con_id=__focused__] scratchpad show')

    def geom_restore(self, tag: str) -> None:
        for j,win in enumerate(self.marked[tag]):
            # delete previous mark
            del self.marked[tag][j]

            # then make a new mark and move scratchpad
            win_cmd="%(make_mark)s, move scratchpad, %(get_geom)s" % {
                "make_mark": self.make_mark_str(tag),
                "get_geom": self.cfg_module.get_geom(tag)
            }
            win.command(win_cmd)
            self.marked[tag].append(win)

    def geom_restore_current(self) -> None:
        self.apply_to_current_tag(self.geom_restore)

    def switch(self, args : List) -> None:
        switch_ = {
            "show": self.focus,
            "hide": self.unfocus,
            "next": self.next_win,
            "toggle": self.toggle,
            "hide_current": self.hide_current,
            "geom_restore": self.geom_restore_current,
            "run": self.run_prog,
            "reload": self.reload_config,
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

    def mark_tag(self, i3, event) -> None:
        con=event.container
        for tag in self.cfg:
            for factor in self.factors:
                if self.match(con, factor, tag):
                    # scratch_move
                    con_cmd="%(make_mark)s, move scratchpad, %(get_geom)s" % {
                        "make_mark": self.make_mark_str(tag),
                        "get_geom": self.cfg_module.get_geom(tag)
                    }
                    con.command(con_cmd)
                    self.marked[tag].append(con)
                    break

    def unmark_tag(self, i3, event) -> None:
        for tag in self.cfg:
            for _,win in enumerate(self.marked[tag]):
                if win.id == event.container.id:
                    del self.marked[tag][_]

    def mark_all_tags(self, hide : bool=True) -> None:
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
                                "make_mark": self.make_mark_str(tag),
                                "get_geom": self.cfg_module.get_geom(tag),
                                "hide_cmd": hide_cmd
                            }
                        con.command(con_cmd)
                        self.marked[tag].append(con)
                        break

#!/usr/bin/env python3

""" i3 Named Scratchpads

Usage:
  ns.py

Options:
  -h --help     Show this screen.
  --version     Show version.

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2017

"""

import i3ipc

from docopt import docopt
from ns_conf import *

from threading import Thread
from singleton_mixin import *
from script_i3_general import *

import uuid
import re
import errno
import os

from typing import Callable, List

conf_=ns_settings()
Conf=conf_.settings
marked={i:[] for i in Conf}

class named_scratchpad(SingletonMixin):
    def __init__(self) -> None:
        self.group_list=[]
        self.fullscreen_list=[]
        [self.group_list.append(group) for group in Conf]
        self.prev_id=0

        self.i3 = i3ipc.Connection()

        self.mark_all(hide=True)

        self.i3.on('window::new', self.mark_group)
        self.i3.on('window::close', self.cleanup_mark)

    def make_mark(self, group : str) -> str:
        output=(group) + str(str(uuid.uuid4().fields[-1]))
        return 'mark {}'.format(output)

    def focus(self, group : str) -> None:
        for j,i in enumerate(marked[group]):
            marked[group][j].command('move container to workspace current')

    def toggle(self, group : str) -> None:
        if marked[group] == [] and "prog" in Conf[group]:
            i3.command("exec {}".format(Conf[group]["prog"]))

        # We need to hide scratchpad it is visible, regardless it focused or not
        focused = i3.get_tree().find_focused()

        if self.visible(group) > 0:
            self.unfocus(group)
            return

        for i in marked[group]:
            if focused.id == i.id:
                self.unfocus(group); return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(group)

    def run_prog(self, group : str, app : str) -> None:
        if "prog_dict" in Conf[group] and app in Conf[group]["prog_dict"]:
            class_list=[win.window_class for win in marked[group]]
            target_class_list=Conf[group]["prog_dict"][app]["includes"]
            target_class_list_set=set(target_class_list)
            interlist=[val for val in class_list if val in target_class_list_set]
            if not len(interlist):
                i3.command("exec {}".format(Conf[group]["prog_dict"][app]["prog"]))
            else:
                def focus_subgroup(group : str):
                    focused=i3.get_tree().find_focused()

                    if focused.fullscreen_mode:
                        focused.command('fullscreen toggle')
                        self.fullscreen_list.append(focused)

                    if focused.window_class in target_class_list_set:
                        return

                    self.focus(group)

                    visible_windows = find_visible_windows(get_windows_on_ws())
                    for w in visible_windows:
                        for i in marked[group]:
                            if w.id == i.id:
                                i3.command('[con_id=%s] focus' % w.id)

                    for j,i in enumerate(marked[group]):
                        if not focused.window_class in target_class_list_set:
                            if marked[group][j].window_class not in target_class_list_set:
                                self.next_win()
                        else:
                            break
                focus_subgroup(group)
        else:
            self.toggle(group)

    def restore_fullscreens(self) -> None:
        [i.command('fullscreen toggle') for i in self.fullscreen_list]
        self.fullscreen_list=[]

    def unfocus(self, group : str) -> None:
        for j,i in enumerate(marked[group]):
            marked[group][j].command('move scratchpad')
        self.restore_fullscreens()

    def visible(self, group : str):
        visible_windows = find_visible_windows(get_windows_on_ws())
        vmarked = 0
        for w in visible_windows:
            for i in marked[group]:
                vmarked+=(w.id == i.id)
        return vmarked

    def get_current_group(self, focused) -> str:
        for group in Conf:
            for i in marked[group]:
                if focused.id == i.id:
                    return group

    def apply_to_current_group(self, func : Callable) -> bool:
        curr_group=self.get_current_group(i3.get_tree().find_focused())
        curr_group_exits=(curr_group != None)
        if curr_group_exits:
            func(curr_group)
        return curr_group_exits

    def next_win(self) -> None:
        focused_=i3.get_tree().find_focused()

        def next_win_(group : str) -> None:
            self.focus(group)
            for number,win in enumerate(marked[group]):
                if focused_.id != win.id:
                    marked[group][number].command('move container to workspace current')
                    marked[group].insert(len(marked[group]), marked[group].pop(number))
                    win.command('move scratchpad')
            self.focus(group)

        self.apply_to_current_group(next_win_)

    def hide_current(self) -> None:
        groupwins=self.apply_to_current_group(self.unfocus)
        if not groupwins:
            self.prev_id=i3.get_tree().find_focused().id
            i3.command('[con_id=__focused__] scratchpad show')

    def geom_restore_all(self) -> None:
        for group in Conf:
            geom_restore(group)

    def geom_restore(self, group : str) -> None:
        for j,win in enumerate(marked[group]):
            # delete previous mark
            del marked[group][j]

            # then make a new mark and move scratchpad
            win_cmd=self.make_mark(group)+', move scratchpad,'+conf_.get_geom(group)
            win.command(win_cmd)
            marked[group].append(win)

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

        if len(args) == 3:
            switch_[args[0]](args[1], args[2])
        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

    def mark_group(self, i3, event) -> None:
        def scratch_move() -> None:
            con_cmd=self.make_mark(group)+', move scratchpad,'+conf_.get_geom(group)
            con.command(con_cmd)
            marked[group].append(con)

        def check_by(attr : str) -> bool:
            if attr in Conf[group]:
                return getattr(con, 'window_'+attr) in Conf[group][attr]
            else:
                return False

        con=event.container

        for group in Conf:
            for attr in ["class", "instance"]:
                if check_by(attr):
                    scratch_move()

    def mark_all(self, hide : bool=True) -> None:
        def scratch_move():
            hide_cmd=''
            if hide:
                hide_cmd=', [con_id=__focused__] scratchpad show'

            con_cmd=self.make_mark(group)+', move scratchpad,'+conf_.get_geom(group)+hide_cmd
            con.command(con_cmd)
            marked[group].append(con)

        def check_by(attr : str) -> bool:
            if attr in Conf[group]:
                return getattr(con, 'window_'+attr) in Conf[group][attr]
            else:
                return False

        window_list = i3.get_tree().leaves()
        for group in Conf:
            for con in window_list:
                for attr in ["class", "instance"]:
                    if check_by(attr):
                        scratch_move()

    def cleanup_mark(self, i3, event) -> None:
        for tag in Conf:
            for j,win in enumerate(marked[tag]):
                if win.id == event.container.id:
                    del marked[tag][j]

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')

    ns=named_scratchpad.instance()

    daemon_manager=daemon_manager.instance()

    ns.daemon_name='ns_scratchd'
    daemon_manager.add_daemon(ns.daemon_name)

    def cleanup_all_daemons():
        daemon=daemon_manager.daemons[ns.daemon_name]
        if os.path.exists(daemon.fifo_):
            os.remove(daemon.fifo_)

    import atexit
    atexit.register(cleanup_all_daemons)

    mainloop=Thread(target=daemon_manager.daemons[ns.daemon_name].mainloop, args=(ns,)).start()
    ns.i3.main()

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

settings_obj_=ns_settings()
settings_=settings_obj_.settings
marked={i:[] for i in settings_}

class named_scratchpad(SingletonMixin):
    def __init__(self):
        self.group_list=[]
        self.fullscreen_list=[]
        [self.group_list.append(gr) for gr in settings_]
        self.prev_id=0

    def make_mark(self, group):
        output=(group) + str(str(uuid.uuid4().fields[-1]))
        return 'mark {}'.format(output)

    def focus(self, gr):
        for j,i in zip(
                range(len(marked[gr])),
                marked[gr]
            ):
            marked[gr][j].command('move container to workspace current')

    def toggle(self, gr):
        if marked[gr] == [] and "prog" in settings_[gr]:
            i3.command("exec {}".format(settings_[gr]["prog"]))

        # We need to hide scratchpad it is visible, regardless it focused or not
        focused = i3.get_tree().find_focused()

        if self.visible(gr) > 0:
            self.unfocus(gr); return

        for i in marked[gr]:
            if focused.id == i.id:
                self.unfocus(gr); return

        if focused.fullscreen_mode:
            focused.command('fullscreen toggle')
            self.fullscreen_list.append(focused)

        self.focus(gr)

    def run_prog(self, gr, app):
        if "prog_dict" in settings_[gr] \
        and app in settings_[gr]["prog_dict"]:
            class_list=[win.window_class for win in marked[gr]]
            target_class_list=settings_[gr]["prog_dict"][app]["includes"]
            target_class_list_set=set(target_class_list)
            interlist=[val for val in class_list if val in target_class_list_set]
            if not len(interlist):
                i3.command("exec {}".format(settings_[gr]["prog_dict"][app]["prog"]))
            else:
                def focus_subgroup(gr):
                    focused=i3.get_tree().find_focused()

                    if focused.fullscreen_mode:
                        focused.command('fullscreen toggle')
                        self.fullscreen_list.append(focused)

                    if focused.window_class in target_class_list_set:
                        return

                    self.focus(gr)

                    visible_windows = find_visible_windows(get_windows_on_ws())
                    for w in visible_windows:
                        for i in marked[gr]:
                            if w.id == i.id:
                                i3.command('[con_id=%s] focus' % w.id)

                    for j,i in zip(range(len(marked[gr])), marked[gr]):
                        if not focused.window_class in target_class_list_set:
                            if marked[gr][j].window_class not in target_class_list_set:
                                self.next_win()
                        else:
                            break
                focus_subgroup(gr)
        else:
            self.toggle(gr)

    def restore_fullscreens(self):
        [i.command('fullscreen toggle') for i in self.fullscreen_list]
        self.fullscreen_list=[]

    def unfocus(self, gr):
        for j,i in zip(
                range(len(marked[gr])),
                marked[gr]
            ):
            marked[gr][j].command('move scratchpad')
        self.restore_fullscreens()

    def visible(self, gr):
        visible_windows = find_visible_windows(get_windows_on_ws())
        vmarked = 0
        for w in visible_windows:
            for i in marked[gr]:
                if w.id == i.id:
                    vmarked+=1
        return vmarked

    def apply_to_current_group(self, func):
        def get_current_group(self,focused):
            for group in settings_:
                for i in marked[group]:
                    if focused.id == i.id:
                        return group

        curr_group=get_current_group(self,i3.get_tree().find_focused())
        if curr_group != None:
            func(curr_group)
            return True
        else:
            return False

    def next_win(self):
        focused_=i3.get_tree().find_focused()

        def next_win_(group):
            self.focus(group)
            for number,win in zip(
                    range(len(marked[group])),
                    marked[group]
                ):
                if focused_.id != win.id:
                    marked[group][number].command('move container to workspace current')
                    marked[group].insert(len(marked[group]), marked[group].pop(number))
                    win.command('move scratchpad')
            self.focus(group)

        self.apply_to_current_group(next_win_)

    def hide_current(self):
        groupwins=self.apply_to_current_group(self.unfocus)
        if not groupwins:
            self.prev_id=i3.get_tree().find_focused().id
            i3.command('[con_id=__focused__] scratchpad show')

    def switch(self, args):
        switch_ = {
            "show": self.focus,
            "hide": self.unfocus,
            "next": self.next_win,
            "toggle": self.toggle,
            "hide_current": self.hide_current,
            "run": self.run_prog,
        }

        if len(args) == 3:
            switch_[args[0]](args[1], args[2])
        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

def mark_group(self, event):
    def scratch_move():
        con_cmd=ns.make_mark(group)+', move scratchpad,'+settings_obj_.get_geom(group)
        con.command(con_cmd)
        marked[group].append(con)

    def check_by(attr):
        if attr in settings_[group]:
            return bool(getattr(con, 'window_'+attr) in settings_[group][attr])
        else:
            return False

    con=event.container

    for group in settings_:
        ns=named_scratchpad.instance()
        for attr in ["class", "instance"]:
            if check_by(attr):
                scratch_move()

def mark_all(hide=True):
    def scratch_move():
        hide_cmd=''
        if hide:
            hide_cmd=', [con_id=__focused__] scratchpad show'

        con_cmd=ns.make_mark(group)+', move scratchpad,'+settings_obj_.get_geom(group)+hide_cmd
        con.command(con_cmd)
        marked[group].append(con)

    def check_by(attr):
        if attr in settings_[group]:
            return bool(getattr(con, 'window_'+attr) in settings_[group][attr])
        else:
            return False

    window_list = i3.get_tree().leaves()
    for group in settings_:
        ns=named_scratchpad.instance()
        for con in window_list:
            for attr in ["class", "instance"]:
                if check_by(attr):
                    scratch_move()

def cleanup_mark(self, event):
    for tag in settings_:
        for j,win in zip(range(len(marked[tag])),marked[tag]):
            if win.id == event.container.id:
                del marked[tag][j]

if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 Named Scratchpads 0.3')
    i3 = i3ipc.Connection()
    name='ns_scratchd'

    mng=daemon_manager.instance()
    mng.add_daemon(name)

    def cleanup_all():
        daemon_=mng.daemons[name]
        if os.path.exists(daemon_.fifo_):
            os.remove(daemon_.fifo_)

    import atexit
    atexit.register(cleanup_all)

    ns=named_scratchpad.instance()

    mark_all(hide=True)

    i3.on('window::new', mark_group)
    i3.on('window::close', cleanup_mark)

    mainloop=Thread(target=mng.daemons[name].mainloop, args=(ns,)).start()

    i3.main()

#!/usr/bin/env python3

""" i3 window tag circle
Usage:
    circle.py

Created by :: Neg
email :: <serg.zorg@gmail.com>
github :: https://github.com/neg-serg?tab=repositories
year :: 2017

"""

import i3ipc
import re
import errno
import os
import time

from queue import Queue
from sys import exit
from docopt import docopt
from circle_conf import *
from singleton_mixin import *
from script_i3_general import *
from threading import Thread, enumerate

import redis

redis_db_=redis.StrictRedis(host='localhost', port=6379, db=0)

glob_settings=cycle_settings().settings

class cycle_window(SingletonMixin):
    def __init__(self):
        self.tagged={}
        self.counters={}
        self.restorable=[]
        self.interact=1
        self.repeats=0

        for i in glob_settings:
            self.tagged[i]=list({})
            self.counters[i]=0

    def go_next(self, tag):
        def tag_conf():
            return glob_settings[tag]

        def cur_win():
            return self.current_win

        def cur_win_in_current_class_set():
            tag_classes_set=set(glob_settings[tag]["classes"])
            return cur_win().window_class in tag_classes_set

        def current_class_in_priority():
            if not cur_win_in_current_class_set():
                return cur_win() == tag_conf()["priority"]
            else:
                return True

        def is_priority_attr():
            return "priority" in tag_conf()

        def class_eq_priority():
            return item['win'].window_class == tag_conf()["priority"]

        def inc_c():
            self.counters[tag]+=1

        def target_i():
            return self.tagged[tag][target_]

        def run_prog():
            prog=tag_conf()["prog"]
            i3.command('exec {}'.format(prog))

        def go_next_(inc_counter=True,fullscreen_handler=True):
            if fullscreen_handler:
                fullscreened=i3.get_tree().find_fullscreen()
                for win in fullscreened:
                    if cur_win_in_current_class_set() and cur_win().id == win.id:
                        self.interact=0
                        win.command('fullscreen disable')

            target_i()['win'].command('focus')
            target_i()['focused']=True
            if inc_counter:
                inc_c()

            if fullscreen_handler:
                now_focused=target_i()['win'].id
                for id in self.restorable:
                    if id == now_focused:
                        self.interact=0
                        i3.command('[con_id=%s] fullscreen enable' % now_focused)

            self.interact=1

        def go_to_not_repeat():
            inc_c()
            self.repeats+=1
            if self.repeats < 16:
                self.go_next(tag)
            else:
                self.repeats=0

        try:
            if len(self.tagged[tag]) == 0:
                if "prog" in tag_conf():
                    run_prog()
                else:
                    return
            elif len(self.tagged[tag]) <= 1:
                target_=0
                go_next_(fullscreen_handler=False)
            else:
                target_=self.counters[tag] % len(self.tagged[tag])

                if is_priority_attr() and not current_class_in_priority():
                    if len([ i for i in self.tagged[tag] if i['win'].window_class == tag_conf()["priority"] ]) == 0:
                        run_prog()
                        return

                    for target_,item in zip(range(len(self.tagged[tag])),self.tagged[tag]):
                        if class_eq_priority():
                            fullscreened=i3.get_tree().find_fullscreen()
                            for win in fullscreened:
                                tag_classes_set=set(glob_settings[tag]["classes"])
                                if win.window_class in tag_classes_set and win.window_class != glob_settings[tag]["priority"]:
                                    self.interact=0
                                    win.command('fullscreen disable')
                            go_next_(inc_counter=False)
                            return
                elif self.current_win.id == target_i()['win'].id:
                    go_to_not_repeat()
                else:
                    go_next_()
        except KeyError:
            invalidate_tags_info()
            self.go_next(tag)

    def switch(self, args):
        switch_ = {
            "next": self.go_next,
        }
        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

def redis_update_count(tag):
    cw=cycle_window.instance()
    if tag in cw.tagged and type(cw.tagged[tag]) == list:
        tag_count_dict={tag: len(cw.tagged[tag])}
        redis_db_.hmset('count_dict', tag_count_dict)
    else:
        redis_db_.hmset('count_dict', {tag:0})

def find_acceptable_windows_by_class(tag, wlist):
    cw=cycle_window.instance()
    for con in wlist:
        if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
            cw.tagged[tag].append({ 'win':con, 'focused':False })
        elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
            cw.tagged[tag].append({ 'win':con, 'focused':False })
    redis_update_count(tag)

def invalidate_tags_info():
    cw=cycle_window.instance()
    wlist = i3.get_tree().leaves()
    cw.tagged={}

    for i in glob_settings:
        cw.tagged[i]=list({})

    for tag in glob_settings:
        find_acceptable_windows_by_class(tag, wlist)

def add_acceptable(self, event):
    cw=cycle_window.instance()

    def add_tagged_win():
        cw.tagged[tag].append({'win':con,'focused':con.focused})
        redis_update_count(tag)

    con = event.container
    for tag in glob_settings:
        try:
            if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                add_tagged_win()
            elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                add_tagged_win()
        except KeyError:
            invalidate_tags_info()
            add_acceptable(self, event)

def del_acceptable(self, event):
    def del_tagged_win():
        if 'win' in cw.tagged[tag]:
            if cw.tagged[tag]['win'].id in cw.restorable:
                cw.restorable.remove(cw.tagged[tag]['win'].id)
        del cw.tagged[tag]

    cw=cycle_window.instance()
    con = event.container
    for tag in glob_settings:
        try:
            if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                del_tagged_win()
            elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                del_tagged_win()
            redis_update_count(tag)
        except KeyError:
            invalidate_tags_info()
            del_acceptable(self, event)

def save_current_win(self,event):
    con=event.container
    cw=cycle_window.instance()
    cw.current_win=con

def handle_fullscreen(self,event):
    cw=cycle_window.instance()
    con=event.container
    if cw.interact == 1:
        if con.fullscreen_mode:
            if con.id not in cw.restorable:
                cw.restorable.append(con.id)
        if not con.fullscreen_mode:
            if con.id in cw.restorable:
                cw.restorable.remove(con.id)


if __name__ == '__main__':
    argv = docopt(__doc__, version='i3 window tag circle 0.5')

    i3 = i3ipc.Connection()
    name = 'circled'

    cw=cycle_window.instance()
    cw.current_win=i3.get_tree().find_focused()

    mng=daemon_manager.instance()
    mng.add_daemon(name)

    def cleanup_all():
        daemon_=mng.daemons[name]
        if os.path.exists(daemon_.fifo_):
            os.remove(daemon_.fifo_)

    import atexit
    atexit.register(cleanup_all)

    invalidate_tags_info()

    i3.on('window::new', add_acceptable)
    i3.on('window::close', del_acceptable)
    i3.on("window::focus", save_current_win)
    i3.on("window::fullscreen_mode", handle_fullscreen)

    mainloop=Thread(target=mng.daemons[name].mainloop, args=(cw,)).start()

    i3.main()

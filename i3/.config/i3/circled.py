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

from sys import exit
from docopt import docopt
from circle_conf import *
from singleton_mixin import *

import redis

redis_db_=redis.StrictRedis(host='localhost', port=6379, db=0)

glob_settings=cycle_settings().settings

class circle(SingletonMixin):
    def __init__(self):
        self.tagged={}
        self.counters={}
        self.restorable=[]
        self.interactive=True
        self.repeats=0

        for i in glob_settings:
            self.tagged[i]=list({})
            self.counters[i]=0

        self.i3 = i3ipc.Connection()

        self.invalidate_tags_info()

        self.i3.on('window::new', self.add_acceptable)
        self.i3.on('window::close', self.del_acceptable)
        self.i3.on("window::focus", self.save_current_win)
        self.i3.on("window::fullscreen_mode", self.handle_fullscreen)

        self.current_win=self.i3.get_tree().find_focused()

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
            self.i3.command('exec {}'.format(prog))

        def go_next_(inc_counter=True,fullscreen_handler=True):
            if fullscreen_handler:
                fullscreened=self.i3.get_tree().find_fullscreen()
                for win in fullscreened:
                    if cur_win_in_current_class_set() and cur_win().id == win.id:
                        self.interactive=False
                        win.command('fullscreen disable')

            target_i()['win'].command('focus')
            target_i()['focused']=True
            if inc_counter:
                inc_c()

            if fullscreen_handler:
                now_focused=target_i()['win'].id
                for id in self.restorable:
                    if id == now_focused:
                        self.interactive=False
                        self.i3.command('[con_id=%s] fullscreen enable' % now_focused)

            self.interactive=True

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

                    for target_,item in enumerate(self.tagged[tag]):
                        if class_eq_priority():
                            fullscreened=self.i3.get_tree().find_fullscreen()
                            for win in fullscreened:
                                tag_classes_set=set(glob_settings[tag]["classes"])
                                if win.window_class in tag_classes_set and win.window_class != glob_settings[tag]["priority"]:
                                    self.interactive=False
                                    win.command('fullscreen disable')
                            go_next_(inc_counter=False)
                            return
                elif self.current_win.id == target_i()['win'].id:
                    go_to_not_repeat()
                else:
                    go_next_()
        except KeyError:
            self.invalidate_tags_info()
            self.go_next(tag)

    def switch(self, args):
        switch_ = {
            "next": self.go_next,
        }
        if len(args) == 2:
            switch_[args[0]](args[1])
        elif len(args) == 1:
            switch_[args[0]]()

    def redis_update_count(self, tag):
        if tag in self.tagged and type(self.tagged[tag]) == list:
            tag_count_dict={tag: len(self.tagged[tag])}
            redis_db_.hmset('count_dict', tag_count_dict)
        else:
            redis_db_.hmset('count_dict', {tag:0})

    def find_acceptable_windows_by_class(self, tag, wlist):
        for con in wlist:
            if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                self.tagged[tag].append({ 'win':con, 'focused':False })
            elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                self.tagged[tag].append({ 'win':con, 'focused':False })
        self.redis_update_count(tag)

    def invalidate_tags_info(self):
        wlist = self.i3.get_tree().leaves()
        self.tagged={}

        for tag in glob_settings:
            self.tagged[tag]=list({})

        for tag in glob_settings:
            self.find_acceptable_windows_by_class(tag, wlist)

    def add_acceptable(self, i3, event):
        def add_tagged_win():
            self.tagged[tag].append({'win':con,'focused':con.focused})
            self.redis_update_count(tag)

        con = event.container
        for tag in glob_settings:
            try:
                if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                    add_tagged_win()
                elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                    add_tagged_win()
            except KeyError:
                self.invalidate_tags_info()
                self.add_acceptable(i3, event)

    def del_acceptable(self, i3, event):
        def del_tagged_win():
            if 'win' in self.tagged[tag]:
                if self.tagged[tag]['win'].id in self.restorable:
                    self.restorable.remove(self.tagged[tag]['win'].id)
            del self.tagged[tag]

        con = event.container
        for tag in glob_settings:
            try:
                if ("classes" in glob_settings[tag]) and (con.window_class in glob_settings[tag]["classes"]):
                    del_tagged_win()
                elif ("instances" in glob_settings[tag]) and (con.window_instance in glob_settings[tag]["instances"]):
                    del_tagged_win()
                self.redis_update_count(tag)
            except KeyError:
                self.invalidate_tags_info()
                self.del_acceptable(i3, event)

    def save_current_win(self, i3, event):
        con=event.container
        self.current_win=con

    def handle_fullscreen(self, i3, event):
        con=event.container
        if self.interactive:
            if con.fullscreen_mode:
                if con.id not in self.restorable:
                    self.restorable.append(con.id)
            if not con.fullscreen_mode:
                if con.id in self.restorable:
                    self.restorable.remove(con.id)

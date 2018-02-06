#!/usr/bin/pypy3
import i3ipc
import re
import os
import importlib
import circle_conf
import redis
from singleton_mixin import *
from i3gen import *

class circle(SingletonMixin):
    def __init__(self):
        self.tagged={}
        self.counters={}
        self.restore_fullscreen=[]
        self.factors=["class", "instance", "class_r"]
        self.interactive=True
        self.repeats=0
        self.winlist=[]

        self.redis_db=redis.StrictRedis(host='localhost', port=6379, db=0)
        self.cfg=circle_conf.cycle_settings().settings

        for tag in self.cfg:
            self.tagged[tag]=[]
            self.counters[tag]=0

        self.i3 = i3ipc.Connection()
        self.tag_windows()

        self.i3.on('window::new', self.add_wins)
        self.i3.on('window::close', self.del_wins)
        self.i3.on("window::focus", self.set_curr_win)
        self.i3.on("window::fullscreen_mode", self.handle_fullscreen)

        self.current_win=self.i3.get_tree().find_focused()

    def reload_config(self):
        prev_conf=self.cfg
        try:
            importlib.reload(circle_conf)
            self.__init__()
        except:
            self.cfg=prev_conf
            self.__init__()

    def go_next(self, tag):
        def cur_win_in_current_class_set():
            return self.current_win.window_class in set(self.cfg[tag]["class"])

        def current_class_in_priority():
            if not cur_win_in_current_class_set():
                return self.current_win == self.cfg[tag]["priority"]
            else:
                return True

        def inc_c():
            self.counters[tag]+=1

        def twin():
            return self.tagged[tag][index]

        def run_prog():
            prog_str=re.sub("~", os.path.realpath(os.path.expandvars("$HOME")), self.cfg[tag]["prog"])
            self.i3.command('exec {}'.format(prog_str))

        def focus_next(inc_counter=True,fullscreen_handler=True):
            if fullscreen_handler:
                fullscreened=self.i3.get_tree().find_fullscreen()
                for win in fullscreened:
                    if cur_win_in_current_class_set() and self.current_win.id == win.id:
                        self.need_handle_fullscreen=False
                        win.command('fullscreen disable')

            twin().command('focus')
            if inc_counter:
                inc_c()

            if fullscreen_handler:
                now_focused=twin().id
                for id in self.restore_fullscreen:
                    if id == now_focused:
                        self.need_handle_fullscreen=False
                        self.i3.command('[con_id=%s] fullscreen enable' % now_focused)

            self.need_handle_fullscreen=True

        def find_priority_win():
            inc_c()
            self.repeats+=1
            if self.repeats < 8:
                self.go_next(tag)
            else:
                self.repeats=0

        try:
            if len(self.tagged[tag]) == 0:
                if "prog" in self.cfg[tag]:
                    run_prog()
                else:
                    return
            elif len(self.tagged[tag]) <= 1:
                index=0
                focus_next(fullscreen_handler=False)
            else:
                index=self.counters[tag] % len(self.tagged[tag])

                if ("priority" in self.cfg[tag]) and not current_class_in_priority():
                    if not len([ win for win in self.tagged[tag] if win.window_class == self.cfg[tag]["priority"]]):
                        run_prog()
                        return

                    for index,item in enumerate(self.tagged[tag]):
                        if item.window_class == self.cfg[tag]["priority"]:
                            fullscreened=self.i3.get_tree().find_fullscreen()
                            for win in fullscreened:
                                if win.window_class in set(self.cfg[tag]["class"]) and win.window_class != self.cfg[tag]["priority"]:
                                    self.interactive=False
                                    win.command('fullscreen disable')
                            focus_next(inc_counter=False)
                            return
                elif self.current_win.id == twin().id:
                    find_priority_win()
                else:
                    focus_next()
        except KeyError:
            self.tag_windows()
            self.go_next(tag)

    def switch(self, args):
        switch_ = {
            "next": self.go_next,
            "reload": self.reload_config,
        }
        switch_[args[0]](*args[1:])

    def redis_update_count(self, tag):
        if tag in self.tagged and type(self.tagged[tag]) == list:
            tag_count_dict={tag: len(self.tagged[tag])}
            self.redis_db.hmset('count_dict', tag_count_dict)
        else:
            self.redis_db.hmset('count_dict', {tag:0})

    def match(self, win, factor, tag):
        if factor == "class":
            return win.window_class in self.cfg.get(tag,{}).get(factor, {})
        elif factor == "instance":
            return win.window_instance in self.cfg.get(tag,{}).get(factor, {})
        elif factor == "class_r":
            regexes=self.cfg.get(tag,{}).get(factor, {})
            for reg in regexes:
                cls_by_regex=self.winlist.find_classed(reg)
                if cls_by_regex:
                    for class_regex in cls_by_regex:
                        if win.window_class == class_regex.window_class:
                            return True

    def find_acceptable_windows(self, tag, wlist):
        for win in wlist:
            for factor in self.factors:
                if self.match(win, factor, tag):
                    self.tagged[tag].append(win)
                    break
        self.redis_update_count(tag)

    def tag_windows(self):
        self.winlist=self.i3.get_tree()
        wlist = self.winlist.leaves()
        self.tagged={}

        for tag in self.cfg:
            self.tagged[tag]=[]

        for tag in self.cfg:
            self.find_acceptable_windows(tag, wlist)

    def add_wins(self, i3, event):
        win = event.container
        for tag in self.cfg:
            for factor in self.factors:
                if win.window_class in self.cfg.get(tag,{}).get((factor),{}):
                    try:
                        self.tagged[tag].append(win)
                        self.redis_update_count(tag)
                    except KeyError:
                        self.tag_windows()
                        self.add_wins(i3, event)
                    break

    def del_wins(self, i3, event):
        win = event.container
        for tag in self.cfg:
            for factor in self.factors:
                if self.match(win, factor, tag):
                    try:
                        if self.tagged[tag] is not None:
                            for win in self.tagged[tag]:
                                if win.id in self.restore_fullscreen:
                                    self.restore_fullscreen.remove(win.id)
                        del self.tagged[tag]
                    except KeyError:
                        self.tag_windows()
                        self.del_wins(i3, event)
                    break
            self.redis_update_count(tag)

    def set_curr_win(self, i3, event):
        win=event.container
        self.current_win=win

    def handle_fullscreen(self, i3, event):
        win=event.container
        if self.need_handle_fullscreen:
            if win.fullscreen_mode:
                if win.id not in self.restore_fullscreen:
                    self.restore_fullscreen.append(win.id)
                    return
            if not win.fullscreen_mode:
                if win.id in self.restore_fullscreen:
                    self.restore_fullscreen.remove(win.id)
                    return

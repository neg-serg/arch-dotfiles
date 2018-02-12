import i3ipc
import re
import os
import toml
from i3gen import *

from singleton_mixin import *
from cfg_master import *

class circle(SingletonMixin, CfgMaster):
    def __init__(self):
        self.tagged={}
        self.counters={}
        self.restore_fullscreen=[]
        self.factors=["class", "instance", "class_r"]
        self.interactive=True
        self.repeats=0
        self.winlist=[]
        self.subtag_info={}
        self.need_handle_fullscreen=True

        self.load_config("circle")

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

    def go_next(self, tag, subtag=None):
        def cur_win_in_current_class_set():
            return self.current_win.window_class in set(self.cfg[tag]["class"])

        def current_class_in_priority():
            if not cur_win_in_current_class_set():
                return self.current_win == self.cfg[tag]["priority"]
            else:
                return True

        def inc_c():
            self.counters[tag]+=1

        def twin(with_subtag=False):
            if not with_subtag:
                return self.tagged[tag][idx]
            else:
                subtag_win_classes=self.subtag_info.get("includes",{})
                for subidx,win in enumerate(self.tagged[tag]):
                    if win.window_class in subtag_win_classes:
                        return self.tagged[tag][subidx]

        def run_prog(subtag=None):
            try:
                if subtag is None:
                    prog_str=re.sub(
                        "~", os.path.realpath(os.path.expandvars("$HOME")),
                        self.cfg[tag].get("prog",{})
                    )
                else:
                    prog_str=re.sub(
                        "~", os.path.realpath(os.path.expandvars("$HOME")),
                        self.cfg[tag].get("prog_dict",{}).get(subtag,{}).get("prog",{})
                    )
                if prog_str:
                    self.i3.command('exec {}'.format(prog_str))
            except:
                pass

        def focus_next(inc_counter=True, fullscreen_handler=True, subtag=None):
            if fullscreen_handler:
                fullscreened=self.i3.get_tree().find_fullscreen()
                for win in fullscreened:
                    if cur_win_in_current_class_set() and self.current_win.id == win.id:
                        self.need_handle_fullscreen=False
                        win.command('fullscreen disable')

            twin(subtag is not None).command('focus')

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
            if subtag is None:
                if len(self.tagged[tag]) == 0:
                    run_prog()
                elif len(self.tagged[tag]) <= 1:
                    idx=0
                    focus_next(fullscreen_handler=False)
                else:
                    idx=self.counters[tag] % len(self.tagged[tag])

                    if ("priority" in self.cfg[tag]) and not current_class_in_priority():
                        if not len([ win for win in self.tagged[tag] if win.window_class == self.cfg[tag]["priority"]]):
                            run_prog()
                            return

                        for idx,item in enumerate(self.tagged[tag]):
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
            else:
                self.subtag_info=self.cfg[tag].get("prog_dict",{}).get(subtag,{})
                if not len(set(self.subtag_info.get("includes",{})) & {w.window_class for w in self.tagged[tag]}):
                    run_prog(subtag)
                else:
                    idx=0
                    focus_next(fullscreen_handler=False, subtag=subtag)
        except KeyError:
            self.tag_windows()
            self.go_next(tag)

    def switch(self, args):
        switch_ = {
            "next": self.go_next,
            "run": self.go_next,
            "reload": self.reload_config,
        }
        try:
            switch_[args[0]](*args[1:])
        except:
            pass

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
                    except KeyError:
                        self.tag_windows()
                        self.add_wins(i3, event)
                    break
        self.winlist=self.i3.get_tree()

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
        self.winlist=self.i3.get_tree()

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

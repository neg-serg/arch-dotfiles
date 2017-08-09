import i3ipc
import os

from sys import exit
from subprocess import check_output
from singleton_mixin import *
from threading import Thread

i3 = i3ipc.Connection()

def find_visible_windows(windows_on_workspace):
    visible_windows = []
    for w in windows_on_workspace:
        try:
            xprop = check_output(['xprop', '-id', str(w.window)]).decode()
        except FileNotFoundError:
            raise SystemExit("The `xprop` utility is not found!"
                            " Please install it and retry.")
        if '_NET_WM_STATE_HIDDEN' not in xprop:
            visible_windows.append(w)

    return visible_windows

def get_windows_on_ws():
    return filter(
        lambda x: x.window,
        i3.get_tree()
        .find_focused()
        .workspace()
        .descendents()
    )

def Benchmark(func):
    import time
    def wrap_(*args, **kwargs):
        t = time.clock()
        res = func(*args, **kwargs)
        print(func.__name__, time.clock() - t)
        return res
    return wrap_

def Logging(func):
    def wrap_(*args, **kwargs):
        res = func(*args, **kwargs)
        print(func.__name__, args, kwargs)
        return res
    return wrap_

def Counter(func):
    def wrap_(*args, **kwargs):
        wrap_.count += 1
        res = func(*args, **kwargs)
        print("{0} called for: {1}x".format(func.__name__, wrap_.count))
        return res
    wrap_.count = 0
    return wrap_

from queue import Queue

class daemon_manager(SingletonMixin):
    def __init__(self):
        self.daemons={}

    def add_daemon(self, name):
        daemon_=daemon_i3.instance()
        if daemon_ not in self.daemons.keys():
            self.daemons[name]=daemon_
            self.daemons[name].bind_fifo(name)

class daemon_i3(SingletonMixin):
    def __init__(self):
        self.q = Queue()
        self.fifo_=""

    def bind_fifo(self, name):
        self.fifo_=os.path.realpath(os.path.expandvars('$HOME/tmp/'+name+'.fifo'))
        if os.path.exists(self.fifo_):
            os.remove(self.fifo_)

        try:
            os.mkfifo(self.fifo_)
        except OSError as oe:
            if oe.errno != errno.EEXIST:
                raise

    def fifo_listner(self, singleton):
        with open(self.fifo_) as fifo:
            while True:
                data = fifo.read()
                if len(data) == 0:
                    break
                eval_str=data.split('\n', 1)[0]
                args=list(filter(lambda x: x != '', eval_str.split(' ')))
                singleton.switch(args)

    def worker(self):
        while True:
            if self.q.empty():
                exit()
            i = self.q.get()
            self.q.task_done()

    def mainloop(self, singleton):
        while True:
            self.q.put(self.fifo_listner(singleton))
            Thread(target=self.worker).start()

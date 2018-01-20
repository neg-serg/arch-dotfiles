import i3ipc
import os

from sys import exit
from subprocess import check_output
from singleton_mixin import *
from threading import Thread

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

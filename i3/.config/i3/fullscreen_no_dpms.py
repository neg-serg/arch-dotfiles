#!/usr/bin/env python3

from argparse import ArgumentParser
from subprocess import call
import i3ipc
from singleton_mixin import *

class FullscreenNoDPMS(SingletonMixin):
    def __init__():
        self.i3 = i3ipc.Connection()

        self.i3.on('window::fullscreen_mode', on_fullscreen_mode)
        self.i3.on('window::close', on_window_close)

        self.i3.main()

    def set_dpms(self, state):
        if state:
            call(['xset', 's', 'on'])
            call(['xset', '+dpms'])
        else:
            call(['xset', 's', 'off'])
            call(['xset', '-dpms'])

    def on_fullscreen_mode(self, e):
        set_dpms(not len(self.i3.get_tree().find_fullscreen()))

    def on_window_close(e):
        if not len(not len(self.i3.get_tree().find_fullscreen())):
            set_dpms(True)

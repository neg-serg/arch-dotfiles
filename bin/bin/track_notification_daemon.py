#!/usr/bin/env python

# noqa: E402
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib
import subprocess

player=Playerctl.Player()
md5sums=[]

def remove_prefix(text, prefix):
    return text[text.startswith(prefix) and len(prefix):]

def on_track_change(player, data):
    if data is None or not data:
        return 0
    cover=data['mpris:artUrl']
    if cover:
        try:
            cover=remove_prefix(cover, 'file://')
            cover_sum=subprocess.check_output(
                ["md5sum", cover]
            ).decode("utf-8").strip()
            md5sums.append(cover_sum.split()[0])
        except subprocess.CalledProcessError:
            pass
        if player:
            if len(md5sums) == 1:
                subprocess.Popen(['track-notify', cover])
            elif md5sums[-1] != md5sums[-2]:
                subprocess.Popen(['track-notify', cover])
            del md5sums[:-2]

player.connect('metadata', on_track_change)

GLib.MainLoop().run()

# How to compare images

# import os
# import sys
# from PIL import Image
# from imagehash import dhash
#
# img1,img2=Image.open(sys.argv[1]),Image.open(sys.argv[2])
# if dhash(img1) == dhash(img2):
#     print('fail')
# else:
#     print('ok')

#!/usr/bin/env python3

import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib
import subprocess

player = Playerctl.Player()
md5sums = []

def remove_prefix(text, prefix):
    return text[text.startswith(prefix) and len(prefix):]

def on_track_change(t, data):
    cover=data['mpris:artUrl']
    if cover:
        try:
            cover_sum=subprocess.check_output(
                ["md5sum", remove_prefix(cover, 'file://')]
            ).decode("utf-8").strip()
            md5sums.append(cover_sum.split()[0])
        except subprocess.CalledProcessError:
            pass
        if t:
            print(md5sums)
            if len(md5sums) == 1:
                subprocess.Popen(['track-notify'])
            elif md5sums[-1] != md5sums[-2]:
                subprocess.Popen(['track-notify'])
                del md5sums[:-2]

player.connect('metadata', on_track_change)

GLib.MainLoop().run()

# How to compare images

# import os
# import sys
# from PIL import Image
# from imagehash import dhash
#
# for t in sys.argv[1], sys.argv[2]:
#     if not os.path.exists(t):
#         print('')
#         sys.exit(0)
#
# if len(sys.argv) == 3:
#     img1=Image.open(sys.argv[1])
#     img2=Image.open(sys.argv[2])
#     ret=(dhash(img1) == dhash(img2))
#     if ret:
#         print('fail')
#     else:
#         print('ok')

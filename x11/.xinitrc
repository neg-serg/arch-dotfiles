#!/bin/dash
export PATH=/usr/sbin:/usr/bin:$PATH
~/bin/wl -r &
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
exec i3-gnome

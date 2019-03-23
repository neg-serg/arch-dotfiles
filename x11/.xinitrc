#!/bin/dash
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
exec i3-gnome

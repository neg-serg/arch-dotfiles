#!/bin/dash
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
exec i3-gnome

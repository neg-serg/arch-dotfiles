#!/bin/dash
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
export QT_QPA_PLATFORMTHEME="qt5ct"
exec i3-gnome

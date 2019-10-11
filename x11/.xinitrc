#!/bin/dash

# Force KDE environment when running i3
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_PLUGIN_PATH=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
export DESKTOP_SESSION=kde

xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"

# Register with gnome-session so that it does not kill the whole session thinking it is dead.
test -n "$DESKTOP_AUTOSTART_ID" && {
	dbus-send --print-reply --session --dest=org.gnome.SessionManager "/org/gnome/SessionManager" org.gnome.SessionManager.RegisterClient "string:i3-gnome" "string:$DESKTOP_AUTOSTART_ID"
} &

exec i3

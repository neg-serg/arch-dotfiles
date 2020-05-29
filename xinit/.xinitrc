#!/bin/dash
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
# Register with gnome-session so that it does not kill the whole session thinking it is dead.
test -n "$DESKTOP_AUTOSTART_ID" && {
	dbus-send --print-reply --session --dest=org.gnome.SessionManager "/org/gnome/SessionManager" org.gnome.SessionManager.RegisterClient "string:i3-gnome" "string:$DESKTOP_AUTOSTART_ID"
} &
exec i3

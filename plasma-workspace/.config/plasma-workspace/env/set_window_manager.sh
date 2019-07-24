eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
xrdb -I$XDG_CONFIG_HOME/xres -load "$HOME/.Xresources"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_PLUGIN_PATH=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
XDG_CURRENT_DESKTOP=KDE
export DESKTOP_SESSION=kde
export KDEWM=/usr/bin/i3

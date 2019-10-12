#!/bin/dash

xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc &
unclutter --fork --timeout 1 &

xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50

setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -option 'grp:ctrl_shift_toggle' \
    -variant altgr-intl \
    -option ctrl:nocaps

#!/bin/dash
unclutter --fork --timeout 1 &
# disable mouse acceleration
xset m 0 0
# fast keyboard rate
xset -b r rate 250 50

setxkbmap -option keypad:pointerkeys -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -variant altgr-intl -option ctrl:nocaps &

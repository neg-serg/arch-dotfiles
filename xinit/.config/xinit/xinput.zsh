#!/bin/dash
unclutter --fork --timeout 1 &
xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50 # fast keyboard rate

setxkbmap \
    -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -option keypad:pointerkeys \
    -option ctrl:nocaps \
    -variant altgr-intl &

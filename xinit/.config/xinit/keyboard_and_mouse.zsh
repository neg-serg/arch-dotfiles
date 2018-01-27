#!/bin/zsh
source ~/.zsh/03-xdg_vars.zsh

keyboard_name='Logitech Gaming Keyboard G910'
while [[ $(xinput | grep ${keyboard_name} | wc -l) == 0 ]]; do
    echo 'wait for the keyboard'
    sleep 1s
done

xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc
unclutter --fork --timeout 1

xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50

setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -variant altgr-intl \
    -option ctrl:nocaps

xhost +localhost +local: +si:localuser:$(id -un) > /dev/null

setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -variant altgr-intl \
    -option ctrl:nocaps

xhost +localhost +local: +si:localuser:$(id -un) > /dev/null
xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50

[[ -f ${XDG_CONFIG_HOME}/keymaps/xmodmaprc ]] && \
    inpath xmodmap && nexec xmodmap && xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc

inpath unclutter && nexec unclutter && unclutter --fork --timeout 1 &

#!/bin/zsh
# temp hack for powerline daemon
export PATH=/usr/sbin:/usr/bin:${PATH}
~/bin/wl -r &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
[[ ${WITH_LOCK} == true ]] && xss-lock -- ~/bin/scripts/lock/lock.sh &

SHELL=dash exec i3-gnome

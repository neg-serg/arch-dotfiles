#!/bin/zsh
source ~/.zsh/03-xdg_vars.zsh
path_dirs=(/usr/{s,}bin /usr/lib64/notion/bin {/usr/local,}/{s,}bin)
export PATH=${(j_:_)path_dirs}

~/bin/wl -r &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
[[ ${WITH_LOCK} == true ]] && xss-lock -- ~/bin/scripts/lock/lock.sh &

SHELL=dash exec i3-gnome

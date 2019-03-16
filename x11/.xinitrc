#!/bin/zsh
source ~/.zsh/03-exports.zsh
~/bin/wl -r &
pgrep sxhkd || sxhkd &
${XDG_CONFIG_HOME}/xinit/compositing.zsh &
${XDG_CONFIG_HOME}/xinit/xinput.zsh &
${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh &
udiskie -2 &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
[[ ${WITH_LOCK} == true ]] && xss-lock -- ~/bin/scripts/lock/lock.sh &

SHELL=dash i3-gnome

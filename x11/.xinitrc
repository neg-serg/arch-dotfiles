#!/bin/zsh
source ~/.zsh/03-exports.zsh
~/bin/wl -r &
pgrep sxhkd || sxhkd &
${XDG_CONFIG_HOME}/xinit/compositing.zsh &
${XDG_CONFIG_HOME}/xinit/keyboard_and_mouse.zsh &
${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh &
gpaste-client > /dev/null &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
[[ ${WITH_LOCK} == true ]] && xss-lock -- ~/bin/scripts/lock/lock.sh &
if [[ ! ${WITHLOGS} -eq "" ]]; then
    SHELL=dash exec i3 -V >> "${HOME}/tmp/i3log-$(date +'%F-%k-%M-%S')" 2>&1
else
    SHELL=dash exec i3 2>&1
fi

#!/bin/zsh
unset TMUX
source ~/.zsh/03-exports.zsh
~/bin/wl -r &
dash -c "pgrep sxhkd || sxhkd &"
${XDG_CONFIG_HOME}/xinit/compositing.zsh &
${HOME}/.config/xinit/cursor_swarp.zsh &
${HOME}/.config/xinit/keyboard_and_mouse.zsh &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
if [[ ! ${WITHLOGS} -eq "" ]]; then
    SHELL=dash exec i3 -V >> "${HOME}/tmp/i3log-$(date +'%F-%k-%M-%S')" 2>&1
else
    SHELL=dash exec i3 2>&1
fi

#!/bin/zsh
unset TMUX
source ~/.zsh/03-exports.zsh
~/bin/wl -r &
${XDG_CONFIG_HOME}/xinit/start_xinit.zsh &
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
if [[ ! ${WITHLOGS} -eq "" ]]; then
    SHELL=dash exec dash -c i3 -V >> "${HOME}/tmp/i3log-$(date +'%F-%k-%M-%S')" 2>&1
else
    SHELL=dash exec dash -c i3 2>&1
fi

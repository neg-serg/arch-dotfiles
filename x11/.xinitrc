#!/bin/zsh
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
~/bin/wl rand &
[[ -e ${LOG_ENABLED_} ]] && ~/bin/scripts/log_runner
(${SCRIPT_HOME}/dw cleaner &)
${XDG_CONFIG_HOME}/xinit/wm.zsh "$@"

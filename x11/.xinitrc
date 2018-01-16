#!/bin/zsh
[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -I${XDG_CONFIG_HOME}/xres -load "${HOME}/.Xresources"
${XDG_CONFIG_HOME}/xinit/wm.zsh "$@"

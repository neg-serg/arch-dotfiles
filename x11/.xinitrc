#!/bin/zsh
unset TMUX

windowmanager="${1}"
[[ ${windowmanager} ]] || source ${XDG_CONFIG_HOME}/.windowmanager
export windowmanager

~/bin/wl rand

[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -load "${HOME}/.Xresources"

pulseaudio --start &

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

source "${XDG_CONFIG_HOME}/xinit/keyboard_and_mouse.zsh"
source "${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh"
source "${XDG_CONFIG_HOME}/xinit/compositing.zsh"
source "${XDG_CONFIG_HOME}/xinit/email.dash"

eval $(gpg-agent --daemon)

[[ -e ${LOG_ENABLED_} ]] && ~/bin/scripts/log_runner

(${XDG_CONFIG_HOME}/xinit/run/network_applet &)
(${XDG_CONFIG_HOME}/xinit/run/clipboard_daemon &)
(${SCRIPT_HOME}/dw clean &)

WITHLOGS=1 ${XDG_CONFIG_HOME}/xinit/wm.zsh

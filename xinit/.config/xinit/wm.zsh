#!/bin/zsh
source ~/.zsh/03-exports.zsh
unset TMUX

function main(){
    "${XDG_CONFIG_HOME}/xinit/hotkeys.zsh" true /tmp/sxhkd_fifo
    if [[ ! ${WITHLOGS} -eq "" ]]; then
        SHELL=dash exec dash -c i3 -V >> "${HOME}/tmp/i3log-$(date +'%F-%k-%M-%S')" 2>&1
    else
        SHELL=dash exec dash -c i3 2>&1
    fi
}

main "$@"

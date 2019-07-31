#!/bin/zsh

source ~/.zsh/03-xdg_vars.zsh

function compton_settings(){
    compton_cfg="${HOME}/.config/compton/new.conf"
    if [[ $(lsmod | grep nvidia) > /dev/null ]]; then
        compton --config "${compton_cfg}" > /dev/null
    else
        compton --config "${compton_cfg}" --blur-kern="" > /dev/null
    fi
}

function compton_run(){
    compton_settings
}

case "${1}" in
    "r"*) compton_run ;;
    "k"*) killall compton ;;
    *) compton_run ;;
esac


#!/bin/zsh

source ~/.zsh/03-xdg_vars.zsh

function compton_settings(){
    compton_cfg="${HOME}/.config/compton/new.conf"
    compton --config "${compton_cfg}" > /dev/null
}

function compton_run(){
    compton_settings
}

case "${1}" in
    "r"*) compton_run ;;
    "k"*) killall compton ;;
    *) compton_run ;;
esac


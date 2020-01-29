#!/bin/zsh
source ~/.zsh/03-xdg_vars.zsh

picom_run(){
    picom --experimental-backends > /dev/null
}

case "${1}" in
    "r"*) picom_run ;;
    "k"*) killall picom ;;
    *) picom_run ;;
esac

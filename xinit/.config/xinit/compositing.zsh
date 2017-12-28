#!/bin/zsh

if [[ -z "$1" ]]; then
    nexec compton || sudo pkill compton
    compton_cfg="${XDG_CONFIG_HOME}/compton/compton.conf"
    if [[ $(egrep -i " connected|card detect|primary dev|Setting driver" /var/log/Xorg.0.log \
        | grep -wo 'Using Kernel Mode Setting driver: i915') == "" ]]; then
        compton -b --config "${compton_cfg}"  --vsync=opengl > /dev/null &
    else
        compton -b --config "${compton_cfg}" --vsync=none > /dev/null &
    fi
fi

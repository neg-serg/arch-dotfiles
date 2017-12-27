#!/bin/zsh

if [[ -z "$1" ]]; then
    nexec compton || sudo pkill compton
    if [[ $(egrep -i " connected|card detect|primary dev|Setting driver" /var/log/Xorg.0.log \
        | grep -wo 'Using Kernel Mode Setting driver: i915') == "" ]]; then
        compton -b --config "${XDG_CONFIG_HOME}/compton/compton.conf" > /dev/null &
    else
        compton -b --config "${XDG_CONFIG_HOME}/compton/compton_intel.conf" > /dev/null &
    fi
fi

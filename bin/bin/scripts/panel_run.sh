#!/bin/dash

export POLYBAR_INPUT_FORMAT="input:%layout%"
export POLYBAR_MPD_FORMAT_PAUSED="%{F#005f87}paused%{F#395573} %{F#395573}" 
export POLYBAR_MPD_LEFT_SIDE="%{F#005f87}〉%{F#005fd7}〉%{F#395573} %{F-}"
export POLYBAR_MPD_SONG_TIME="%elapsed%%{F#395573}/%{F-}%total%"
export POLYBAR_MPD_OFFLINE="No MPD%%{F#395573} %{F-}"
export POLYBAR_MPD_FORMAT_ONLINE="<label-song> <label-time>"
export POLYBAR_LL="%{F-}"
export POLYBAR_RR="%{F-}"

pkill -x polybar

if [ $(pgrep -x polybar|wc -l) -le 1  ]; then
    polybar -c ${XDG_CONFIG_HOME}/polybar/main main &
fi

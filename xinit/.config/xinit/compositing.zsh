#!/bin/zsh

local compton_cfg="${XDG_CONFIG_HOME}/compton/compton.conf"
local with_hardcore_blur=false
local -a hardcore_blur=(
    "15,15,0.969839,0.973787,0.977140,0.979892,0.982038,0.983574,0.984496,0.984804,0.984496,0.983574,0.982038,0.979892,0.977140,0.973787,0.969839,0.973787,0.977751,0.981118,0.983881,0.986036,0.987578,0.988504,0.988813,0.988504,0.987578,0.986036,0.983881,0.981118,0.977751,0.973787,0.977140,0.981118,0.984496,0.987269,0.989431,0.990978,0.991908,0.992218,0.991908,0.990978,0.989431,0.987269,0.984496,0.981118,0.977140,0.979892,0.983881,0.987269,0.990050,0.992218,0.993769,0.994702,0.995012,0.994702,0.993769,0.992218,0.990050,0.987269,0.983881,0.979892,0.982038,0.986036,0.989431,0.992218,0.994391,0.995946,0.996880,0.997191,0.996880,0.995946,0.994391,0.992218,0.989431,0.986036,0.982038,0.983574,0.987578,0.990978,0.993769,0.995946,0.997503,0.998439,0.998751,0.998439,0.997503,0.995946,0.993769,0.990978,0.987578,0.983574,0.984496,0.988504,0.991908,0.994702,0.996880,0.998439,0.999375,0.999688,0.999375,0.998439,0.996880,0.994702,0.991908,0.988504,0.984496,0.984804,0.988813,0.992218,0.995012,0.997191,0.998751,0.999688,0.999688,0.998751,0.997191,0.995012,0.992218,0.988813,0.984804,0.984496,0.988504,0.991908,0.994702,0.996880,0.998439,0.999375,0.999688,0.999375,0.998439,0.996880,0.994702,0.991908,0.988504,0.984496,0.983574,0.987578,0.990978,0.993769,0.995946,0.997503,0.998439,0.998751,0.998439,0.997503,0.995946,0.993769,0.990978,0.987578,0.983574,0.982038,0.986036,0.989431,0.992218,0.994391,0.995946,0.996880,0.997191,0.996880,0.995946,0.994391,0.992218,0.989431,0.986036,0.982038,0.979892,0.983881,0.987269,0.990050,0.992218,0.993769,0.994702,0.995012,0.994702,0.993769,0.992218,0.990050,0.987269,0.983881,0.979892,0.977140,0.981118,0.984496,0.987269,0.989431,0.990978,0.991908,0.992218,0.991908,0.990978,0.989431,0.987269,0.984496,0.981118,0.977140,0.973787,0.977751,0.981118,0.983881,0.986036,0.987578,0.988504,0.988813,0.988504,0.987578,0.986036,0.983881,0.981118,0.977751,0.973787,0.969839,0.973787,0.977140,0.979892,0.982038,0.983574,0.984496,0.984804,0.984496,0.983574,0.982038,0.979892,0.977140,0.973787,0.969839,"
)

function intel_compton_settings(){
    compton -b --config "${compton_cfg}" \
        --blur-method=kawase \
        --blur-strength=6 \
        --backend="glx" \
        --glx-no-stencil \
        --glx-no-rebind-pixmap \
        --glx-swap-method=undefined \
        --glx-use-copysubbuffermesa \
        --paint-on-overlay \
        --vsync="drm"
}

function nvidia_compton_settings(){
    compton -b --config "${compton_cfg}"  --vsync=none \
            --blur-method=kawase \
            --blur-strength=6 \
            --backend="glx" \
            --paint-on-overlay \
            --glx-no-stencil \
            --glx-no-rebind-pixmap \
        > /dev/null &
}

local sharp_shadows=(
    --shadow-offset-x="8"
    --shadow-offset-y="8"
    --shadow-opacity="1.0"
    --shadow-red="0.0"
    --shadow-green="0.0"
    --shadow-blue="0.0"
)

function compton_run(){
    if [[ $(lsmod|grep nvidia) != "" ]]; then
        nvidia_compton_settings
    else
        intel_compton_settings
    fi
}

case "${1}" in
    "r"*) compton_run ;;
    "k"*) killall compton ;;
    *)
        if pidof compton; then
            killall compton 
            compton_run
        else
            compton_run
        fi
    ;;
esac

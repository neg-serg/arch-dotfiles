#!/bin/zsh

source ~/.zsh/03-helpers.zsh
source ~/.zsh/03-exports.zsh

unset TMUX

windowmanager="${1}"
[[ ${windowmanager} ]] || source ${XDG_CONFIG_HOME}/.windowmanager
export windowmanager

function notion_run(){
    "${SCRIPT_HOME}/panels"
    source "${XDG_CONFIG_HOME}/xinit/hotkeys.zsh"
    (${BIN_HOME}/term) &
    cat /tmp/ws_out.txt &
    exec notion -oneroot 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function windowchef_run() {
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec windowchef 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function herbstluftwm_run() {
    exec herbstluftwm -c ~/.config/herbstluftwm/autostart
}

function bspwm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec bspwm 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function 2bwm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec 2bwm 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function nowm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    wew | ~/bin/yawee &
    exec ~/bin/wm/wmtls/xwait 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function pantheon_run(){
    gsettings-data-convert &
    xdg-user-dirs-gtk-update &
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
    /usr/lib/gnome-settings-daemon/gnome-settings-daemon &
    /usr/lib/gnome-user-share/gnome-user-share &
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
    export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
    exec cerbere
}

function i3_run(){
    (${BIN_HOME}/term) &
    zsh "${XDG_CONFIG_HOME}/xinit/hotkeys.zsh"
    if [[ ! ${WITHLOGS} -eq "" ]]; then
        exec i3 -V >> "${HOME}/tmp/i3log-$(date +'%F-%k-%M-%S')" 2>&1
    else
        exec i3 2>&1
    fi
}

function fallback_run(){
    ${BIN_HOME}/term
}

if type "${windowmanager}"_run; then
    eval "${windowmanager}"_run "$@"
else
    exec ${windowmanager} "$@"
fi


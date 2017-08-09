if [[ $(readlink ${HOME}/.base16_theme|awk '/base16-dark3/') == "" ]]; then
    BASE16_SHELL=${XDG_CONFIG_HOME}/base16-shell
    [[ -n "${PS1}" ]] && [[ -s ${BASE16_SHELL}/profile_helper.sh ]] && eval "$(${BASE16_SHELL}/profile_helper.sh)"
fi

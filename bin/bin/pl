#!/bin/zsh

mp() {
    local args=""
    for arg; do
        if [[ -d ${arg} ]]; then
            {find "${arg}" -maxdepth 1 -type f -print0 | xargs -0n10 -P 10 ~/bin/scripts/vid_info} &
        fi
    done
    {for arg; [[ -f "${arg}" ]] && args+="$(printf '%s\0' "${arg}")";
    xargs -0n10 -P 10 ~/bin/scripts/vid_info <<< "${args}"} &
    mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu "$@" > ${HOME}/tmp/mpv.log
}

pl() {
    [[ -e "$1" ]] && arg_="$1"
    [[ -z "${arg_}" ]] && arg_="${XDG_VIDEOS_DIR}/"
    pushd ${arg_}
    rg_cmd=(
        rg -g \"'!{.git,node_modules}/*'\" -g \"'!*.srt'\"
        --files --hidden --follow
    )
    run_command=(fzf-tmux)
    find_result="$(eval ${run_command[@]})"
    xsel <<< "${find_result}"
    if [[ ! -z ${find_result} ]]; then
        mp "${find_result}"
    fi
    popd
}

pl_rofi() {
    [[ -e "$1" ]] && arg_="$1"
    [[ -z "${arg_}" ]] && arg_="${XDG_VIDEOS_DIR}/"
    pushd ${arg_}
    rg_cmd=(
        rg -g \"'!{.git,node_modules}/*'\" -g \"'!*.srt'\"
        --files --hidden --follow
    )
    if [[ ${set_maxdepth} == true ]]; then
        rg_cmd+=(--max-depth 1)
    fi
    rg_cmd_result=$(eval ${rg_cmd[@]})
    if [[ $#rg_cmd_result > 1 ]]; then
        find_result=$(rofi -p '[>>]' -i -dmenu <<< ${rg_cmd_result})
    else
        find_result=rg_cmd_result
    fi
    xsel <<< "${find_result}"
    if [[ ! -z ${find_result} ]]; then
        mp "${find_result}"
    fi
    popd
}

main() {
    set_maxdepth=false
    if [[ $1 != "rofi" ]]; then
        if [[ $1 == "1st_level" ]]; then
            set_maxdepth=true
            shift
        fi
        pl "$@"
        exit
    else
        shift;
        if [[ $1 == "1st_level" ]]; then
            set_maxdepth=true
            shift
        fi
        pl_rofi "$@"
        exit
    fi
}

main "$@"

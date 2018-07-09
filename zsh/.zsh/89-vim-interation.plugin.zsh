export vim_server_name="VIM"
export nvim_server_name="NVIM"

readonly to_normal="<C-\><C-N>:call<SPACE>foreground()<CR>"

function wim_run(){
    local proc="process_list"
    [[ $1 == "__wim_embed" ]] && {proc="eprocess_list"; shift}
    local wid=$(xdotool search --classname wim)
    if [[ -z "${wid}" ]]; then
        st -f "${wim_font}:pixelsize=${wim_font_size}" -c 'wim' -e bash -c "tmux -S ${wim_sock_path} new -s vim -n vim \"vim --servername ${vim_server_name}\" && \
            tmux -S ${wim_sock_path} switch-client -t vim" 2>/dev/null &!
        eval ${proc} ${wim_timer} "$@"
    else  
        eval ${proc} ${wim_timer} "$@"
    fi
}

function wim_goto() {
    if [[ $(pidof notion) && -x $(which notionflux) ]]; then
        notionflux -e "app.byclass('', 'wim')" > /dev/null
    else
        if [[ -x $(which wmctrl) ]]; then
            wmctrl -i -a $(wmctrl -l -x|awk '/wim.wim/{print $1}')
        elif [[ -x $(which xdotool) ]]; then
            xdotool windowfocus $(xdotool search --class wim)
        fi
    fi
}

function vim_file_open() (
    local file_name="$(resolve_file ${line})"
    file_name=$(bash -c "printf %q '${file_name}'")
    { vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
        || { while [[ $(vim --servername ${vim_server_name} --remote-expr "g:vim_is_started" 2>/dev/null) != "on" ]]; do
            sleep ${wim_timer}
        done \
        && vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null } } && {
        local file_size=$(stat -c%s "${file_name}" 2>/dev/null | \
                          numfmt --to=iec-i --suffix=B | \
                          sed "s/\([KMGT]iB\|B\)/$fg[green]&/")
        local file_length=$(wc -l ${file_name} 2>/dev/null| \
            grep -owE '[0-9]* '| \
            tr -d ' ')
        local sz_msg=$(zwrap "sz$(zfg 237)~$fg[white]${file_size}")
        local len_msg=$(zwrap "len$(zfg 237)=$fg[white]${file_length}")
        local new_file_msg=$(zwrap new_file)
        local dir_msg=$(zwrap directory)
        local pref=$(zwrap ">>")
        if [[ ! -e "${file_name}" ]]; then
            <<< "${pref} $(zfwrap ${file_name}) $(zdelim) ${new_file_msg}"
        elif [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
            <<< "${pref} $(zfwrap ${file_name}) $(zdelim) ${sz_msg} $(zdelim) ${len_msg}${syn_msg}"
        else
            if [[ -d "${file_name}" ]]; then
                if [[ $(readlink -f ${file_name}) == $(readlink -f $(pwd)) ]]; then
                    <<< "${pref} $(zfwrap "current dir") $(zdelim) ${dir_msg}"
                else
                    <<< "${pref} ${fancy_name} $(zdelim) ${dir_msg}"
                fi
            fi
        fi
    }
    unset file_name
)

function process_list() {
    sleep "$1"; shift
    while getopts ":b:a:c:" opt; do
        case ${opt} in
            a|c) after="${OPTARG}" ;;
            b) before="${before}${OPTARG}" ;;
            --) shift ; break ;;
        esac
    done
    shift $((OPTIND-1))
    [[ ${after#:} != ${after} && ${after%<CR>} == ${after} ]] && after="${after}<CR>"
    [[ ${before#:} != ${before} && ${before%<CR>} == ${before} ]] && before="${before}<CR>"
    local cmd="${to_normal}${before}${after}"
    if [[ ${cmd} == ${to_normal} ]]; then
        for line; do vim_file_open; done
    else
        vim --servername ${vim_server_name} --remote-send "${cmd}"
        for line; do vim_file_open; done
    fi
    unset before; unset after
}

function eprocess_list() {
    wim_goto
    sleep "$1"; shift   
    for line; do vim --servername ${vim_server_name} --remote-wait "$@"; done
}

function v { 
    while read -r arg; do
        wim_run ${arg[@]}
    done <<< "$(printf '%q\n' "$@")"
    wim_goto
}

function wim_embed { wim_run "__wim_embed" "$@" }

function wdiff {
    local prev_ 
    local arg2_
    # or it's maybe better to use :windo diffthis
    if [[ $# == 2 ]]; then
        prev_="$1" 
        wim_run "" && v -b":tabnew" && \
        { wim_run $1; shift } && v -b":diffthis" && \
        { v -b":vs" && {
            if [[ -d $1 ]]; then  
                arg2_="$1/$(basename ${prev_})"
            else
                arg2_="$1"
            fi
            wim_run ${arg2_};
            shift
        } && v -b":diffthis" }
    fi
}

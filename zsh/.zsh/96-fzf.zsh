__fzf_use_tmux__() {
    [[ -n "${TMUX_PANE}" ]] && [[ "${FZF_TMUX:-0}" != 0 ]] && [[ ${LINES:-40} -gt 15 ]]
}

__fzfcmd() {
    __fzf_use_tmux__ &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "\!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"
export FZF_TMUX=1

export SKIM_DEFAULT_COMMAND='rg --files --hidden --follow -g "\!{.git,node_modules}/*"'

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -l 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS} --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort ${FZF_CTRL_R_OPTS} --query=${(q)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "${selected}" ]; then
    num=${selected}[1]
    if [ -n "${num}" ]; then
      zle vi-fetch-history -n ${num}
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

function fe() {
    local out file key
    out=$(fzf-tmux --color=16 --ansi --multi --with-nth=3 --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
    key=$(head -1 <<< "${out}")
    file=$(head -2 <<< "${out}" | tail -1)
    if [[ -n "${file}" ]]; then
        [[ "${key}" = 'ctrl-o' ]] && xdg-open "${file}" || ${EDITOR:-vim} "${file}"
    fi
}

function fkill() {
    zle -I
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

function fco() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "${commits}" | fzf --tac +s +m -e) &&
    git checkout $(echo "${commit}" | sed "s/ .*//")
}

function fshow() {
    local out shas sha q k
    while out=$(
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --multi --no-sort --reverse --query="${q}" \
            --print-query --expect=ctrl-o,ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "${out}")
    k=$(head -2 <<< "${out}" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "${out}" | awk '{print $1}')
    [[ -z "${shas}" ]] && continue
    if [[ "${k}" = 'ctrl-d' ]]; then
        git diff --color=always ${shas} | ${PAGER}
    elif [[ "${k}" = 'ctrl-o' ]]; then
        git checkout ${shas}
    else
        for sha in ${shas}; do
            git show --color=always ${sha} | ${PAGER}
        done
    fi
    done
}

function ftpane () {
    local panes current_window target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_window=$(tmux display-message  -p '#I')
    target=$(fzf <<< "${panes}") || return
    target_window=$(awk 'BEGIN{FS=":|-"} {print$1}' <<< ${target})
    target_pane=$(awk 'BEGIN{FS=":|-"} {print$2}' <<< ${target}| cut -c 1)

    if [[ ${current_window} -eq ${target_window} ]]; then
        tmux select-pane -t ${target_window}.${target_pane}
    else
        tmux select-pane -t ${target_window}.${target_pane} &&
        tmux select-window -t $target_window
    fi
}

function pl(){
    [[ -e "$1" ]] && arg_="$1"
    [[ -z "${arg_}" ]] && arg_="${XDG_VIDEOS_DIR}/"
    pushd ${arg_}
    rg_cmd=(
        rg -g \"'!{.git,node_modules}/*'\"
        --files
        --hidden
        --follow
    )
    run_command=(sk-tmux -c \'${rg_cmd[@]}\' -d 40% --)
    find_result="$(eval ${run_command[@]})"
    xsel <<< "${find_result}"
    if [[ ! -z ${find_result} ]]; then
        vid_fancy_print "${find_result}"
        mpv "${find_result}"
    fi
    popd
}

function fmpc() {
    local song_position
    song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
                    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
                    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
    [[ -n "${song_position}" ]] && mpc -q play $song_position
}

function fqq() {
    local file=$(find ${1:-.} -maxdepth 1 -type f -print 2> /dev/null | fzf +m)
    echo ${file}
}

zle -N fe ; bindkey "^Xe" fe
zle -N fh ; bindkey "^Xh" fh
zle -N fkill ; bindkey "^Xq" fkill


# fh - repeat history
function fh() {
    zle -I;
    echo $(([[ -n "$ZSH_NAME" ]] && fc -l 1 || history) | fzf +s| sed 's/ *[0-9]* *//')
}

#fzf locate
function foc() {
  local selected
  if selected=$(locate / | fzf -q "$LBUFFER"); then
    LBUFFER=$selected
  fi
  zle redisplay
}

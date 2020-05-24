local readonly use_cope_path=false
if [[ ${use_cope_path} == true  ]]; then
    if [[ -x $(which cope_path 2> /dev/null) ]]; then
        # to prevent slow cope_path evaluation
        local copepath=$(cope_path)
        for i in "${copepath}"/*; alias $(basename ${i})=\"$i\"
        alias df="${copepath}/df -hT"
    else
        alias df="df -hT"
    fi
else
    local copepath=~/bin/scripts/Cope
    for i in "${copepath}"/*; alias $(basename ${i})=\"$i\"
    alias df="${copepath}/df -hT"
fi
unset copepath

alias l=ls
alias ls="ls --color=auto"
alias mv="mv -i"
alias mk="mkdir -p"
alias rd="rmdir"
alias ping='prettyping'
alias s="sudo"
alias e="mimeo"
alias grep="grep --color=auto"
alias rg="rg --colors 'match:fg:magenta' --colors 'line:fg:cyan'"
alias sort='sort --parallel 8 -S 16M'

alias se="patool extract"
alias pk="patool create"
alias sp='cdu -idh -s -r -c ":"'
alias '?=bc -l <<<'
alias acpi="acpi -V"
pacnews() { sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//' }
alias pkglist="comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)"
alias @r="~/bin/scripts/music_rename"
alias v="~/bin/v --remote-silent"
alias ip='ip -c'
alias fd='fd -H'
alias qe='cd *(/om[1])'
alias history='history 0'
alias objdump='objdump -M intel -d'
alias cal="task calendar"

alias mpa="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu "$@" -mute > ${HOME}/tmp/mpv.log"
alias mpA="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu "$@" -fs -ao null > ${HOME}/tmp/mpv.log"
alias mpi="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu --interpolation=yes --tscale='oversample' --video-sync='display-resample' "$@" > ${HOME}/tmp/mpv.log"
alias love="mpc sendmessage mpdas love"
alias unlove="mpc sendmessage mpdas unlove"
alias yt="youtube-dl"

alias mutt="dtach -A ${HOME}/1st_level/mutt.session neomutt"
alias img="imgur-screenshot"

alias memgrind='valgrind --tool=memcheck "$@" --leak-check=full'
alias iostat='iostat -mtx'

eval 'alias :{x,q,Q}=exit'
alias куищще='reboot'
alias учше='exit'
alias :й=':q'

hash journalctl > /dev/null && {
    alias log='journalctl -f | ccze -A' #follow log
}

hash iotop > /dev/null && {
    alias iotop='sudo iotop -oPa'
    alias diskact="sudo iotop -Po"
}

chpwd() {
    if [[ -x $(which fasd) ]]; then
        [[ "${PWD}" -ef "${HOME}" ]] || fasd -A "${PWD}"
    fi
}

# grep for running process, like: 'any vime
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        if [[ -x $(which fzf-tmux) ]]; then
            ps xauwww | fzf-tmux
        fi
    else
        ps xauwww | grep  --color=auto -i "[${1[1]}]${1[2,-1]}"
    fi
}

local rlwrap_list=(bigloo clisp irb guile bb)
local sudo_list=({u,}mount ch{mod,own} modprobe i7z aircrack-ng)
local logind_sudo_list=(reboot halt poweroff)
local nocorrect_commands=(ebuild gist heroku hpodder man mkdir mv mysql sudo)

local noglob_list=(
    fc find {,s,l}ftp history locate rake rsync scp
    eix {z,m}mv wget clive{,scan} youtube-{dl,viewer}
    translate links{,2} lynx you-get bower pip task
)

local user_commands=(
    list-units is-active status show help list-unit-files
    is-enabled list-jobs show-environment cat
)

local systemctl_sudo_commands=(
    start stop reload restart try-restart isolate kill
    reset-failed enable disable reenable preset mask unmask
    link load cancel set-environment unset-environment
    edit
)

for c in ${user_commands}; do; alias sc-${c}="systemctl ${c}"; done
for c in ${systemctl_sudo_commands}; do; alias sc-${c}="sudo systemctl ${c}"; done

for i in ${sudo_list[@]}; alias "${i}=sudo ${i}";
for i in ${noglob_list[@]}; alias "${i}=noglob ${i}";
for i in ${rlwrap_list[@]}; alias "${i}=rlwrap ${i}";
for i in ${nocorrect_list[@]}; alias "${i}=nocorrect ${i}";

[[ -x /usr/bin/systemctl ]] && sysctl_pref="systemctl"
for i in ${logind_sudo_list[@]}; alias "${i}=sudo ${sysctl_pref} ${i}"

unset noglob_list rlwrap_list sudo_list sys_sudo_list

if hash git 2>/dev/null; then
    alias gs='git status --short -b'
    alias gp='git push'
    alias gc='git commit'
    # http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
    intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'
    intra_line_less='LESS="-R +/-\]|\{\+"' # jump directly to changes in diffs
    alias gd="${intra_line_less} git diff ${intra_line_diff}"
    alias gd2='git diff -w -U0 --word-diff-regex=[^[:space:]]'
    alias gd3='git diff --word-diff-regex="[A-Za-z0-9. ]|[^[:space:]]" --word-diff=color'
    eval "$(hub alias -s)"
fi

zleiab() {
    local -A abk=(
        'G'    '|& rg -i '
        'C'    '| wc -l'
        'E'    '| head'
        'T'    '| tail'
        'Q'    '&>/dev/null'
        'S'    '| sort -h '
        'V'    '|& v -'
        "e1"   "!-2$"
        "e2"   "!-3$"
        "e3"   "!-4$"
        "we"   "!-2$"
        "wd"   "!-3$"
        "wc"   "!-4$"
    )

    local MATCH
    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}
zle -N zleiab

[[ -x =nvim ]] && alias vim=nvim
[[ ${DISPLAY} ]] &&  alias nvim=v

inplace_mk_dirs() {
    # Press ctrl-xM to create the directory under the cursor or the selected area.
    # To select an area press ctrl-@ or ctrl-space and use the cursor.
    # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
    # directory does not exist yet -> press ctrl-XM and problem solved
    local PATHTOMKDIR
    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR
        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi
        # get marked area from buffer and eliminate whitespace
        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi
    [[ -z "${PATHTOMKDIR}" ]] && return 1
    PATHTOMKDIR=${~PATHTOMKDIR}
    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M " path already exists, doing nothing"
    else
        zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
        zle end-of-line
    fi
}

imv() {
    local src dst
    for src; do
        [[ -e ${src} ]] || { print -u2 "${src} does not exist"; continue }
        dst=${src}
        vared dst
        [[ ${src} != ${dst} ]] && mkdir -p ${dst:h} && mv -n ${src} ${dst}
    done
}

# just type '...' to get '../..'
rationalise-dot() {
    local MATCH
    if [[ $LBUFFER =~ '(^|/| |  |'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}
zle -N rationalise-dot

fg-widget() {
    stty icanon echo -inlcr < /dev/tty
    stty lnext '^V' quit '^\' susp '^Z' < /dev/tty
    zle reset-prompt
    if jobs %- >/dev/null 2>&1; then
        fg %-
    else
        fg
    fi
}
zle -N fg-widget

# Widgets for changing current working directory.
function z4h-redraw-prompt() {
    emulate -L zsh
    local f
    for f in chpwd $chpwd_functions precmd $precmd_functions; do
        (( $+functions[$f] )) && $f &>/dev/null
    done
    zle .reset-prompt
    zle -R
}

function z4h-cd-rotate() {
    emulate -L zsh
    while (( $#dirstack )) && ! pushd -q $1 &>/dev/null; do
        popd -q $1
    done
    if (( $#dirstack )); then
        z4h-redraw-prompt
    fi
}
function z4h-cd-back() { z4h-cd-rotate +1 }
function z4h-cd-forward() { z4h-cd-rotate -0 }

zle -N z4h-cd-back
zle -N z4h-cd-forward

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}
no-magic-abbrev-expand() { LBUFFER+=' ' }

negcd-1() { cd "${NEGCD1}" && z4h-redraw-prompt }
negcd-2() { cd "${NEGCD2}" && z4h-redraw-prompt }
negcd-3() { cd "${NEGCD3}" && z4h-redraw-prompt }
negcd-4() { cd "${NEGCD4}" && z4h-redraw-prompt }
zle -N negcd-1
zle -N negcd-2
zle -N negcd-3
zle -N negcd-4

special-accept-line() {
    if [[ $BUFFER = '..' || $BUFFER = '../' ]]; then
        cd ..
        z4h-redraw-prompt
        BUFFER=
    else
        zle accept-line
    fi
}
zle -N special-accept-line

expand-or-complete-with-dots() {
    echo -n "\e[36m··\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots

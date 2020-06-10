_exists() { (( $+commands[$1] )) }

local copepath=~/bin/scripts/Cope
for i in "${copepath}"/*; alias $(basename ${i})=\"$i\"
alias df="df -hT"

alias l=ls
alias ls="ls --color=auto"
alias mv="mv -i"
alias mk="mkdir -p"
alias rd="rmdir"
alias grep="grep --color=auto"
alias sort='sort --parallel 8 -S 16M'

alias s="sudo"
_exists prettyping && alias ping='prettyping'
_exists mimeo && alias e="mimeo"

_exists rg && {
    local rg_options="--max-columns=0 \
    --max-columns-preview \
    --glob=\!git/* \
    --colors=match:fg:25 \
    --colors=match:style:underline \
    --colors=line:fg:cyan \
    --colors=line:style:bold \
    --colors=path:fg:249 \
    --colors=path:style:bold \
    --smart-case \
    --hidden"
    alias rg="rg ${rg_options}"
    alias zrg="rg ${rg_options} -z"
}

alias @r="~/bin/scripts/music_rename"
alias qe='cd *(/om[1])'

_exists patool && {
    alias se="patool extract"
    alias pk="patool create"
}

_exists xz && alias xz='xz --threads=0'
_exists pigz && alias gzip='pigz'
_exists pbzip2 && alias bzip2='pbzip2'
_exists zstd && alias zstd="zstd --threads=0"

_exists cdu && alias sp='cdu -idh -s -r -c ":"'
_exists bc && alias '?=bc -l <<<'
_exists acpi && alias acpi="acpi -V"
_exists ip && alias ip='ip -c'
_exists fd && alias fd='fd -H'
_exists objdump && alias objdump='objdump -M intel -d'
_exists task && alias cal="task calendar"
_exists gdb && alias gdb="gdb -nh -x "$XDG_CONFIG_HOME"/gdb/gdbinit.gdb"

pacnews() { sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//' }

_exists mpv && {
    alias mpa="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu "$@" -mute > ${HOME}/tmp/mpv.log"
    alias mpA="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu "$@" -fs -ao null > ${HOME}/tmp/mpv.log"
    alias mpi="mpv --input-ipc-server=/tmp/mpvsocket --vo=gpu --interpolation=yes --tscale='oversample' --video-sync='display-resample' "$@" > ${HOME}/tmp/mpv.log"
}

_exists mpc && {
    alias love="mpc sendmessage mpdas love"
    alias unlove="mpc sendmessage mpdas unlove"
}
_exists yt && alias yt="youtube-dl"
_exists imgur_screenshot && alias img="imgur-screenshot"

_exists nvim && {
    alias vim=nvim
    alias nvim=v
    alias v="~/bin/v"
}

_exists iostat && alias iostat='iostat -mtx'
_exists iotop && alias iotop='sudo iotop -oPa'

local rlwrap_list=(bigloo clisp irb guile bb)
local sudo_list=(umount mount chmod chown modprobe i7z aircrack-ng)
local logind_sudo_list=(reboot halt poweroff)
local noglob_list=(
    fc find ftp sftp lftp history locate rake rsync scp eix zmv mmv wget clive
    clivescan youtube-dl youtube-viewer translate links links2 lynx you-get
    bower pip task
)
for i in ${sudo_list[@]}; alias "${i}=sudo ${i}";
for i in ${noglob_list[@]}; alias "${i}=noglob ${i}";
for i in ${rlwrap_list[@]}; alias "${i}=rlwrap ${i}";
for i in ${nocorrect_list[@]}; alias "${i}=nocorrect ${i}";
[[ -x /usr/bin/systemctl ]] && sysctl_pref="systemctl"
for i in ${logind_sudo_list[@]}; alias "${i}=sudo ${sysctl_pref} ${i}"
unset sudo_list noglob_list rlwrap_list nocorrect_list logind_sudo_list

_exists git && {
    alias gs='git status --short -b'
    alias gp='git push'
    # http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
    intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'
    intra_line_less='LESS="-R +/-\]|\{\+"' # jump directly to changes in diffs
    alias gd="${intra_line_less} git diff ${intra_line_diff}"
    alias gd2='git diff -w -U0 --word-diff-regex=[^[:space:]]'
    alias gd3='git diff --word-diff-regex="[A-Za-z0-9. ]|[^[:space:]]" --word-diff=color'
}

unfunction _exists

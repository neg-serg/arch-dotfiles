_exists() { (( $+commands[$1] )) }

alias @r="~/bin/scripts/music_rename"
alias qe='cd *(/om[1]D)'

local copepath=~/bin/scripts/Cope
for i in "${copepath}"/*; alias $(basename ${i})=\"$i\"
alias df="df -hT"

if _exists exa; then
    alias l="exa --icons"
    alias ll="exa --icons -L 2 -R"
else
    alias l="ls --color=auto"
    alias ll="l"
fi
alias ls="ls --color=auto"
alias mv="mv -i"
alias mk="mkdir -p"
alias rd="rmdir"
alias grep="grep --color=auto"
alias sort='sort --parallel 8 -S 16M'
alias P="patch -p1 <"
alias U="yay -Su --devel --noconfirm --timeupdate"

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

_exists cdu && alias sp='cdu -idh -s -r -c ":"'
_exists lfs && alias df='lfs'
_exists bc && alias '?=bc -l <<<'
_exists acpi && alias acpi="acpi -V"
_exists ip && alias ip='ip -c'
_exists fd && alias fd='fd -H -u'
_exists objdump && alias objdump='objdump -M intel -d'
_exists task && alias cal="task calendar"
_exists todoist && {
    alias t="todoist"
    alias ta="todoist add"
    alias tm="todoist modify"
    alias tl="todoist list"
    alias td="todoist close"
    alias ts="todoist show"
}
_exists gdb && alias gdb="gdb -nh -x "${XDG_CONFIG_HOME}"/gdb/gdbinit.gdb"

_exists nvim && {
    alias vim=nvim
    alias nvim=v
    alias v="~/bin/v"
}

_exists iostat && alias iostat='iostat -mtx'
_exists iotop && alias iotop='sudo iotop -oPa'

_exists patool && {
    alias se="patool extract"
    alias pk="patool create"
}
_exists xz && alias xz='xz --threads=0'
_exists pigz && alias gzip='pigz'
_exists pbzip2 && alias bzip2='pbzip2'
_exists zstd && alias zstd="zstd --threads=0"

pacnews() { sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//' }

_exists mpv && {
    local mpv_ipc="--input-ipc-server=/tmp/mpvsocket"
    alias mpa="mpv ${mpv_ipc} --vo=gpu -mute "$@" > ${HOME}/tmp/mpv.log"
    alias mpA="mpv ${mpv_ipc} --vo=gpu -fs -ao null "$@" > ${HOME}/tmp/mpv.log"
    alias mpi="mpv ${mpv_ipc} --vo=gpu \
        --interpolation=yes \
        --tscale='oversample' \
        --video-sync='display-resample' "$@" > ${HOME}/tmp/mpv.log"
}

_exists mpc && {
    alias love="mpc sendmessage mpdas love"
    alias unlove="mpc sendmessage mpdas unlove"
}
_exists youtube-dl && alias yt="youtube-dl"
_exists imgur_screenshot && alias img="imgur-screenshot"
_exists ffsend && alias ff="ffsend upload"

local rlwrap_list=(bigloo clisp irb guile bb)
local sudo_list=(umount mount chmod chown modprobe i7z aircrack-ng)
local logind_sudo_list=(reboot halt poweroff)
local noglob_list=(
    fc find ftp sftp lftp history locate rake rsync scp eix zmv mmv wget clive
    clivescan youtube-dl youtube-viewer translate links links2 lynx you-get
    bower pip task
)
local dev_null_list=(tig)
for i in ${sudo_list[@]}; alias "${i}=sudo ${i}"
for i in ${noglob_list[@]}; alias "${i}=noglob ${i}"
for i in ${rlwrap_list[@]}; alias "${i}=rlwrap ${i}"
for i in ${nocorrect_list[@]}; alias "${i}=nocorrect ${i}"
for i in ${dev_null_list[@]}; alias "${i}=${i} 2>/dev/null"
_exists systemctl && {
    alias sysctl_pref="systemctl"
    alias S="sudo systemctl stop"
    alias R="sudo systemctl restart"
    alias SU="systemctl stop --user"
    alias RU="systemctl restart --user"
    alias log="sudo journalctl --output cat"
    alias log-previous-boot="sudo journalctl --boot=-1"
}
_exists lsof && alias ports="sudo lsof -Pni"
_exists bandwhich && alias nethogs="sudo bandwhich"
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

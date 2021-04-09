_exists() { (( $+commands[$1] )) }
alias -g @r='~/bin/scripts/music-rename'
alias qe='cd *(/om[1]D)'
if _exists exa; then
    alias la='exa --icons -a --group-directories-first'
    alias ll='exa --icons -al --group-directories-first'
    alias ls='exa --icons --group-directories-first'
    alias lr='exa -s modified --icons --group-directories-first'
else
    alias ls='ls --color=auto'
fi
alias l='ls'
alias -g mv='mv -i'
alias -g mk='mkdir -p'
alias -g rd='rmdir'
alias grep='grep --color=auto'
alias -g sort='sort --parallel 8 -S 16M'
alias P='patch -p1 <'
_exists yay && alias U='yay -Su --devel --noconfirm --timeupdate'
_exists sudo && alias s='sudo -A'
_exists plocate && alias -g locate=plocate
_exists dd && alias -g dd='dd status=progress'
autoload -U zcalc
__calc_plugin() { zcalc -e "$*" }
aliases[=]='noglob __calc_plugin'
_exists bc && alias '?=bc -l <<<'
_exists prettyping && alias ping='prettyping'
_exists handlr && alias -g e='handlr open'
_exists rg && {
    local rg_options='--max-columns=0 \
    --max-columns-preview \
    --glob=\!git/* \
    --colors=match:fg:25 \
    --colors=match:style:underline \
    --colors=line:fg:cyan \
    --colors=line:style:bold \
    --colors=path:fg:249 \
    --colors=path:style:bold \
    --smart-case \
    --hidden'
    alias -g rg="rg ${rg_options}"
    alias -g zrg="rg ${rg_options} -z"
}
_exists bpython && alias python='bpython'
_exists cdu && alias -g sp='cdu -idh -s -r -c ":"'
_exists lfs && alias -g df='lfs'
_exists ip && alias ip='ip -c'
_exists fd && alias fd='fd -H -u'
_exists objdump && alias objdump='objdump -M intel -d'
_exists todoist && {
    alias t='todoist'
    alias ta='todoist add'
    alias tl='todoist list'
    alias ts='todoist show'
}
_exists gdb && alias gdb="gdb -nh -x "${XDG_CONFIG_HOME}"/gdb/gdbinit.gdb"
_exists nvim && {
    alias -g vim='nvim'
    alias -g v='~/bin/v'
    alias -g nvim='v'
}
_exists iostat && alias -g iostat='iostat -mtx'
_exists iotop && alias -g iotop='sudo iotop -oPa'
_exists patool && {
    alias -g se='patool extract'
    alias -g pk='patool create'
}
_exists xz && alias -g xz='xz --threads=0'
_exists pigz && alias -g gzip='pigz'
_exists pbzip2 && alias -g bzip2='pbzip2'
_exists zstd && alias -g zstd='zstd --threads=0'
_exists mpv && {
    local mpv_ipc='--input-ipc-server=/tmp/mpvsocket'
    alias mpa="mpv ${mpv_ipc} --vo=gpu -mute "$@" > ${HOME}/tmp/mpv.log"
    alias mpA="mpv ${mpv_ipc} --vo=gpu -fs -ao null "$@" > ${HOME}/tmp/mpv.log"
    alias mpi="mpv ${mpv_ipc} --vo=gpu \
        --interpolation=yes \
        --tscale='oversample' \
        --video-sync='display-resample' "$@" > ${HOME}/tmp/mpv.log"
}
_exists mpc && {
    alias love='mpc sendmessage mpdas love'
    alias unlove='mpc sendmessage mpdas unlove'
}
_exists youtube-dl && alias yt='youtube-dl'
_exists imgur_screenshot && alias img='imgur-screenshot'
local rlwrap_list=(bigloo clisp irb guile bb)
local sudo_list=(umount mount chmod chown modprobe i7z aircrack-ng)
local logind_sudo_list=(reboot halt poweroff)
local noglob_list=(
    fc find ftp sftp lftp history locate rake rsync scp eix zmv mmv wget clive
    clivescan youtube-dl youtube-viewer translate links links2 lynx you-get
    bower pip task
)
autoload zmv
alias zcp='zmv -C' zln='zmv -L'
local dev_null_list=(tig)
for i in ${sudo_list[@]}; alias "${i}=sudo ${i}"
for i in ${noglob_list[@]}; alias "${i}=noglob ${i}"
for i in ${rlwrap_list[@]}; alias "${i}=rlwrap ${i}"
for i in ${nocorrect_list[@]}; alias "${i}=nocorrect ${i}"
for i in ${dev_null_list[@]}; alias "${i}=${i} 2>/dev/null"
_exists systemctl && {
    sysctl_pref='systemctl'
    alias S='sudo systemctl stop'
    alias R='sudo systemctl restart'
    alias SU='systemctl stop --user'
    alias RU='systemctl restart --user'
    alias log='sudo journalctl --output cat'
    alias log-previous-boot='sudo journalctl --boot=-1'
}
_exists lsof && alias ports='sudo lsof -Pni'
_exists bandwhich && alias nethogs='sudo bandwhich'
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
_exists fzf && bindings() { bindkey -L | fzf }
zc() {
    for f in "${ZDOTDIR}"/*.zsh; do
        zcompare "$f"
    done
}
_exists broot && \
br() {
    f=$(mktemp)
    (
        set +e
        broot --outcmd "$f" "$@"
        code=$?
        if [ "$code" != 0 ]; then
            rm -f "$f"
            exit "$code"
        fi
    )
    code=$?
    if [ "$code" != 0 ]; then
        return "$code"
    fi
    d=$(<"$f")
    rm -f "$f"
    eval "$d"
}
unfunction _exists

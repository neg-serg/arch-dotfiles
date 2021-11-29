_exists() { (( $+commands[$1] )) }
typeset -gx ACOLS_PATH="$HOME/bin/colorizers"
[[ -x ~/bin/acol ]] && {
    du(){ command du "$@" | acol "$ACOLS_PATH/du.1.awk" };
    env(){ command env "$@" | acol "$ACOLS_PATH/env.1.sed" };
    lsblk(){ command lsblk "$@"| acol "$ACOLS_PATH/lsblk.1.awk" };
    lspci(){ command lspci "$@"| acol "$ACOLS_PATH/lspci.1.awk" };
    mount(){ command sudo mount "$@"| acol "$ACOLS_PATH/mount.1.sed" };
    nmap(){ command nmap "$@" | acol "$ACOLS_PATH/nmap.1.awk" };
}
alias @r='~/bin/music-rename'
alias qe='cd ^.git*(/om[1]D)'
if [[ $USE_EXA ]] && _exists exa; then
    alias ls='exa -ga --icons --group-directories-first --time-style=long-iso'
fi
if _exists lsc; then
    alias ls='lsc'
    alias l='lsc -l'
else
    alias ls='ls --color=auto'
    alias l='ls'
fi
alias mv='mv -i'
alias mk='mkdir -p'
alias rd='rmdir'
alias grep='grep --color=auto'
_exists rg && {
    local rg_options='--max-columns=0 \
    --max-columns-preview \
    --glob=\!git/\* \
    --colors=match:fg:25 \
    --colors=match:style:underline \
    --colors=line:fg:cyan \
    --colors=line:style:bold \
    --colors=path:fg:249 \
    --colors=path:style:bold \
    --smart-case \
    --hidden'
    alias rg="rg ${rg_options}"
    alias -g RG="rg ${rg_options}"
    alias -g zrg="rg ${rg_options} -z"
}
alias sort='sort --parallel 8 -S 16M'
alias :q="exit"
_exists paru && {
    alias paru='yay'
    alias U='paru -Su --devel --noconfirm --timeupdate'
}
_exists sudo && {alias sudo='sudo '; alias s='sudo '}
_exists plocate && alias locate='plocate'
_exists dd && alias dd='dd status=progress'
autoload -U zcalc
__calc_plugin() { zcalc -e "$*" }
aliases[=]='noglob __calc_plugin'
_exists bc && alias '?=bc -l <<<'
_exists hxd && alias hexdump='hxd'
_exists prettyping && alias ping='prettyping'
_exists handlr && alias e='handlr open'
_exists rsync && alias rsync='rsync -az --compress-choice=zstd --info=FLIST,COPY,DEL,REMOVE,SKIP,SYMSAFE,MISC,NAME,PROGRESS,STATS'
_exists bpython && alias python='bpython'
_exists dust && alias sp='dust -r'
_exists lfs && alias df='lfs'
_exists journalctl && journalctl() {command journalctl "${@:--b}";}
_exists ip && alias ip='ip -c'
_exists fd && alias fd='fd -H -u'
_exists objdump && alias objdump='objdump -M intel -d'
_exists gdb && alias gdb="gdb -nh -x ${XDG_CONFIG_HOME}/gdb/gdbinit"
_exists nvim && {
    alias vim='nvim'
    alias v='~/bin/v'
    alias nvim='v'
}
_exists iostat && alias iostat='iostat -mtx'
_exists iotop && alias iotop='sudo iotop -oPa'
_exists patool && {
    alias se='patool extract'
    alias pk='patool create'
}
_exists xz && alias xz='xz --threads=0'
_exists pigz && alias gzip='pigz'
_exists pbzip2 && alias bzip2='pbzip2'
_exists zstd && alias zstd='zstd --threads=0'
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
_exists youtube-dl && alias yt='noglob yt-dlp -q --downloader aria2c -f "(bestvideo+bestaudio/best)"'
_exists ytfzf && alias ytfzf='ytfzf --preview-side=left -t'
_exists curl && {
    alias weather="curl 'wttr.in/?T'"
    alias cht='f(){ curl -s "cheat.sh/$(echo -n "$*"|jq -sRr @uri)";};f'
}
_exists wget2 && alias wget='wget2'
_exists imgur_screenshot && alias img='imgur-screenshot'
local rlwrap_list=(irb guile bb)
local sudo_list=(umount chmod chown modprobe)
local logind_sudo_list=(reboot halt poweroff)
local noglob_list=(fc find ftp sftp lftp history locate rake rsync scp wget youtube-dl links2 lynx you-get pip)
for c in ${sudo_list[@]}; {_exists "$c" && alias "$c=sudo $c"}
for c in ${noglob_list[@]}; {_exists "$c" && alias "$c=noglob $c"}
for c in ${rlwrap_list[@]}; {_exists "$c" && alias "$c=rlwrap $c"}
for c in ${nocorrect_list[@]}; {_exists "$c" && alias "$c=nocorrect $c"}
for c in ${dev_null_list[@]}; {_exists "$c" && alias "$c=$c 2>/dev/null"}
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
    alias gd='git diff -w -U0 --word-diff-regex=[^[:space:]]'
    alias gdd="${intra_line_less} git diff ${intra_line_diff}"
    alias tig='forgit::log'
    alias gdi='forgit::diff'
    alias ga='forgit::add'
    alias gi='forgit::ignore'
    alias gcf='forgit::checkout::file'
    alias gcb='forgit::checkout::branch'
    alias gco='forgit::checkout::commit'
    alias ga='forgit::add'
    alias gst='forgit::stash::show'
    export FORGIT_FZF_DEFAULT_OPTS="
    $FZF_DEFAULT_OPTS
    --reverse
    --ansi --height='100%'
    --disabled
    --bind='alt-k:preview-up,alt-p:preview-up'
    --bind='alt-j:preview-down,alt-n:preview-down'
    --bind='ctrl-r:toggle-all'
    --bind='ctrl-s:toggle-sort'
    --bind 'j:down,k:up'
    --bind 'tab:unbind(j,k)+enable-search'
    --bind='?:toggle-preview'
    --preview-window='noborder,right:70%'
    +1"
}
_exists fzf && {
    alias ttcmd="echo '' | fzf -q '$*' --prompt '│ ' --pointer '― ' --preview-window=up:99% --preview='eval {q}'"
    bindings() { bindkey -L | fzf }
    logs() {
      local cmd log_file
      cmd="command find /var/log/ -type f -name '*log' 2>/dev/null"
      log_file=$(eval "$cmd" | fzf --height 40% --min-height 25 --tac --tiebreak=length,begin,index --reverse --inline-info) && less "$log_file"
    }
}
_exists xev && alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
_exists khal && alias cal='khal calendar'
autoload zc
unfunction _exists

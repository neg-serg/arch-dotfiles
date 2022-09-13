_exists() { (( $+commands[$1] )) }
[[ -x ~/bin/acol ]] && { for t in du env lsblk lspci nmap mount; alias $t="acol $t" }
alias qe='cd ^.git*(/om[1]D)'
alias ls='ls --time-style=+"%d.%m.%Y %H:%M" --color=auto --hyperlink=auto'
alias l='ls'
alias mv='mv -i'
alias mk='mkdir -p'
alias rd='rmdir'
if _exists ugrep; then
    # ------------------------------------------------------------------
    alias grep='ug -G' # search with basic regular expressions (BRE)
    alias egrep='ug -E' # search with extended regular expressions (ERE)
    alias fgrep='ug -F' # find string(s)
    alias pgrep='ug -P' # search with Perl regular expressions
    alias xgrep='ug -W' # search (ERE) and output text or hex for binary
    # ------------------------------------------------------------------
    alias zgrep='ug -zG' # search compressed files and archives with BRE
    alias zegrep='ug -zE' # search compressed files and archives with ERE
    alias zfgrep='ug -zF' # find string(s) in compressed files and/or archives
    alias zpgrep='ug -zP' # search compressed files and archives with Perl regular expressions
    alias zxgrep='ug -zW' # search (ERE) compressed files/archives and output text or hex for binary
    # ----------------------------------------------------------------------------------------------
    alias xdump='ug -X ""' # hexdump files without searching
    alias ugit='ug -R --ignore-files'
else
    alias grep='grep --color=auto'
fi
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
    alias rg="rg $rg_options"
    alias -g RG="rg $rg_options"
    alias -g zrg="rg $rg_options -z"
}
alias sort='sort --parallel 8 -S 16M'
alias :q="exit"
alias emptydir='ls -ld **/*(/^F)'
_exists paru && {alias yay='paru'; alias rmorphans='paru -Rs $(paru -Qqdt)'}
_exists reflector && _exists doas && alias mirrors='doas /usr/bin/reflector --score 100 --fastest 10 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
_exists sudo && {alias sudo='sudo '; alias s='sudo '}
_exists doas && {alias doas='doas '; alias s='doas '}
_exists nvidia-settings && alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"
_exists plocate && alias locate='plocate'
_exists dd && alias dd='dd status=progress'
_exists hxd && alias hexdump='hxd'
_exists prettyping && alias ping='prettyping'
_exists khal && alias cal='khal calendar'
_exists handlr && alias e='handlr open'
_exists rsync && alias rsync='rsync -az --compress-choice=zstd --info=FLIST,COPY,DEL,REMOVE,SKIP,SYMSAFE,MISC,NAME,PROGRESS,STATS'
_exists pass && alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'
_exists dig && alias dig='dig +noall +answer'
_exists mtr && alias mtrr='mtr -wzbe'
_exists bpython && alias python='bpython'
_exists dust && alias sp='dust -r'
_exists duf && alias df='duf -theme ansi'
_exists btm && alias htop='btm -b'
_exists journalctl && journalctl() {command journalctl "${@:--b}";}
_exists ip && alias ip='ip -c'
_exists fd && alias fd='fd -Hu'
_exists objdump && alias objdump='objdump -M intel -d'
_exists gdb && alias gdb="gdb -nh -x ${XDG_CONFIG_HOME}/gdb/gdbinit"
_exists nvim && { alias nvim='v'; }
_exists iostat && alias iostat='iostat -mtx'
_exists iotop && alias iotop='sudo iotop -oPa'
_exists patool && { alias se='patool extract'; alias pk='patool create'; }
_exists xz && alias xz='xz --threads=0'
_exists pigz && alias gzip='pigz'
_exists pbzip2 && alias bzip2='pbzip2'
_exists zstd && alias zstd='zstd --threads=0'
_exists mpv && {
    alias mpa="mpv --vo=gpu -mute "$@" > ${HOME}/tmp/mpv.log"
    alias mpi="mpv --vo=gpu --interpolation=yes --tscale='oversample' \
        --video-sync='display-resample' "$@" > ${HOME}/tmp/mpv.log"
}
_exists mpc && {
    alias love='mpc sendmessage mpdas love'
    alias unlove='mpc sendmessage mpdas unlove'
}
_exists yt-dlp && {
    alias yt='yt-dlp --downloader aria2c -f "(bestvideo+bestaudio/best)"'
    alias ytt='ytfzf --preview-side=left -t'
}
if _exists wget2; then
    alias wget="wget2 --hsts-file=$XDG_DATA_HOME/wget-hsts"
else
    alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
fi
_exists imgur_screenshot && alias img='imgur-screenshot'
local rlwrap_list=(bb fennel guile irb)
local sudo_list=(chmod chown modprobe umount)
local logind_sudo_list=(reboot halt poweroff)
local noglob_list=(fc find ftp history lftp links2 locate lynx rake rsync scp sftp you-get)
for c in ${sudo_list[@]}; {_exists "$c" && alias "$c=sudo $c"}
for c in ${noglob_list[@]}; {_exists "$c" && alias "$c=noglob $c"}
for c in ${rlwrap_list[@]}; {_exists "$c" && alias "$c=rlwrap $c"}
for c in ${nocorrect_list[@]}; {_exists "$c" && alias "$c=nocorrect $c"}
for c in ${dev_null_list[@]}; {_exists "$c" && alias "$c=$c 2>/dev/null"}
_exists lsof && alias ports='sudo lsof -Pni'
for i in ${logind_sudo_list[@]}; alias "${i}=sudo ${sysctl_pref} ${i}"
unset sudo_list noglob_list rlwrap_list nocorrect_list logind_sudo_list
_exists svn && alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
_exists git && {
    alias gs='git status --short -b'
    alias gp='git push'
    # http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
    intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'
    intra_line_less='LESS="-R +/-\]|\{\+"' # jump directly to changes in diffs
    alias gd='git diff -w -U0 --word-diff-regex=[^[:space:]]'
    alias add="git add"
    alias checkout='git checkout'
    alias commit='git commit'
    alias fetch="git fetch"
    alias pull="git pull"
    alias push='git push'
    alias stash="git stash"
    alias status="git status"
}
_exists curl && {
    alias weather="curl 'wttr.in/?T'"
    alias cht='f(){ curl -s "cheat.sh/$(echo -n "$*"|jq -sRr @uri)";};f'
}
_exists fzf && {
    logs() {
        local cmd log_file
        cmd="command find /var/log/ -type f -name '*log' 2>/dev/null"
        log_file=$(eval "$cmd" | fzy --height 40% --min-height 25 --tac --tiebreak=length,begin,index --reverse --inline-info) && less "$log_file"
    }
}
_exists xev && alias xev="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
autoload zc
unfunction _exists

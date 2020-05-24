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
alias @r="~/bin/scripts/music_rename"
alias v="~/bin/v --remote-silent"
alias ip='ip -c'
alias fd='fd -H'
alias qe='cd *(/om[1])'
alias history='history 0'
alias objdump='objdump -M intel -d'
alias cal="task calendar"

pacnews() { sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//' }
alias pkglist="comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)"

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
alias log='journalctl -f'
alias iotop='sudo iotop -oPa'
alias diskact="sudo iotop -Po"

local rlwrap_list=(bigloo clisp irb guile bb)
local sudo_list=(umount mount chmod chown modprobe i7z aircrack-ng)
local logind_sudo_list=(reboot halt poweroff)
local nocorrect_commands=(ebuild gist heroku hpodder man mkdir mv mysql sudo)
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

unset noglob_list rlwrap_list sudo_list

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
    alias git='hub'
fi

chpwd() {
    if [[ -x $(which fasd) ]]; then
        [[ "${PWD}" -ef "${HOME}" ]] || fasd -A "${PWD}"
    fi
}

(){
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
        local copepath=${SCRIPT_HOME}/Cope
        for i in "${copepath}"/*; alias $(basename ${i})=\"$i\"
        alias df="${copepath}/df -hT"
    fi
    unset copepath
}

if hash dfc > /dev/null && false; then
    alias df='dfc -q type -T -n -s'
fi

local noglob_list=(
    fc find {,s,l}ftp history locate rake rsync scp
    eix {z,m}mv wget clive{,scan} youtube-{dl,viewer}
    translate links{,2} lynx you-get bower pip task
)

local rlwrap_list=(
    bigloo clisp irb guile
)

local sudo_list=(
    {u,}mount ch{mod,own} modprobe i7z
    node npm reaver aircrack-ng
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

local logind_sudo_list=(
    reboot halt poweroff
)

local nocorrect_commands=(
    ebuild gist heroku hpodder man mkdir mv mysql sudo
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

if [[ ! -x "${BIN_HOME}/l" ]] && [[ ! -x $(which l) ]]; then
    if  [[ -x "${BIN_HOME}/lsp" ]]; then
        alias l="lsp"
    elif [[ -x "$(which ls++)" ]]; then
        alias l="ls++"
    else
        alias l="ls -aChkopl --group-directories-first --color=auto"
    fi
else
    alias l='l -g'
fi
alias ls="ls --color=auto" # do we have GNU ls with color-support?
hash l > /dev/null || alias l="ls -aChkopl --group-directories-first --color=auto"

alias s="sudo"
alias x='xargs'
alias e="open"

alias u='umount'

alias primusrun="vblank_mode=0 primusrun"

alias magnet2torrent="aria2c -q --bt-metadata-only --bt-save-metadata"

function mp(){
    for i; do vid_fancy_print "${i}"; done
    ${VIDEO_PLAYER_} --input-ipc-server=/tmp/mpvsocket "$@" > ${HOME}/mpv.log
}

alias mpa="${VIDEO_PLAYER_} -mute > ${HOME}/mpv.log"
alias mpA="${VIDEO_PLAYER_} -fs -ao null > ${HOME}/mpv.log"

alias love="mpc sendmessage mpdas love"
alias unlove="mpc sendmessage mpdas unlove"

alias grep="grep --color=auto"
alias rg="rg --colors 'match:fg:magenta' --colors 'line:fg:cyan'"

alias mutt="dtach -A ${HOME}/1st_level/mutt.session neomutt"

alias gps='ps -eo cmd,fname,pid,pcpu,time --sort=-pcpu | head -n 11 && echo && ps -eo cmd,fname,pid,pmem,rss --sort=-rss | head -n 9'
alias pstree="pstree -U "$@" | sed '
	s/[-a-zA-Z]\+/\x1B[32m&\x1B[0m/g
	s/[{}]/\x1B[31m&\x1B[0m/g
	s/[─┬─├─└│]/\x1B[34m&\x1B[0m/g'"

alias '?=bc -l <<<'

alias {z,m}mv="noglob zmv -Wn"
alias mv="mv -i"
alias mk="mkdir -p"
alias rd="rmdir"

alias tree="tree --dirsfirst -C"
alias acpi="acpi -V"
alias se=extract
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'

if inpath git; then
    alias gs='git status --short -b'
    alias gp='git push'
    alias gdd='git diff'
    alias gc='git commit'

    # http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
    intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'
    intra_line_less='LESS="-R +/-\]|\{\+"' # jump directly to changes in diffs
    alias gdiff="${intra_line_less} git diff ${intra_line_diff}"
    alias gdiff2="git diff -w -U0 --word-diff-regex=[^[:space:]]"

    # commit staged changes with the given message
    alias gcm='git commit -m'

    function git_confclicts() {
        # list all conflicted files
        alias gkl='git ls-files --unmerged | cut -f2 | uniq'
        # add changes from all conflicted files
        alias gka='git add $(gkl)'
        # edit conflicted files
        alias gke='vim +"set hlsearch" +"/^[<=>]\{7\}/\( \|$\)" $(gkl)'
        # use local version of the given files
        alias gko='git checkout --$(test -f .git/MERGE_HEAD && echo ours || echo theirs) --'
        # use local version of all conflicted files
        alias gkO='gko $(gkl)'
        # use upstream version of the given files
        alias gkt='git checkout --$(test -f .git/MERGE_HEAD && echo theirs || echo ours) --'
        # use upstream version of all conflicted files
        alias gkT='gkt $(gkl)'
    }
    eval "$(hub alias -s)"
    [[ -x ${SCRIPT_HOME}/git-cal ]] && alias git-cal=${SCRIPT_HOME}/git-cal
fi

for i in x q Q; eval alias :${i}=\' exit\'

alias iostat='iostat -mtx'
alias yt='you-get'

function yr(){
    ${XDG_CONFIG_HOME}/i3/send ns toggle youtube
    sleep 1s
    echo "$@" | xsel -i
    xdotool key shift+Insert
}

alias qe='cd *(/om[1])'
if hash ccat > /dev/null; then
    alias {cat,hi}='ccat -G String="_default_" -G Plaintext="white" -G Punctuation="blue" -G Literal="fuscia" -G Keyword="fuscia" 2>/dev/null'
fi

alias awk="$(whence gawk || whence awk)"
alias history='history 0'
alias httpscan='sudo ngrep -d "enp6s0" -t "^(GET|POST) " "tcp and port 80"'

alias pastebinit='pastebinit -a "Neg" -b "http://paste2.org" -t "Neg is here"'

alias objdump='objdump -M intel -d'
alias memgrind='valgrind --tool=memcheck "$@" --leak-check=full'

alias cal="task calendar"

if hash ${DEFAULT_TOP} > /dev/null; then
    alias {{h,}top,lk}=${DEFAULT_TOP}
elif hash htop >/dev/null; then
    alias {{h,}top,lk}=htop
elif hash glances >/dev/null; then
    alias {{h,}top,lk}=glances
elif hash top >/dev/null; then
    alias {{h,}top,lk}=top
fi

if [[ $(whence python) != "" ]]; then
    alias urlencode='python -c "import sys, urllib; print(urllib.quote_plus(sys.argv[1]))"'
    alias urldecode='python -c "import sys, urllib; print(urllib.unquote_plus(sys.argv[1]))"'
elif [[ $(whence xxd) != "" ]]; then
    function urlencode() {echo $@ | tr -d "\n" | xxd -plain | sed "s/\(..\)/%\1/g"}
    function urldecode() {printf $(echo -n $@ | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n"}
fi

zleiab() {
    declare -A abk
    abk=(
        'G'    '|& rg -i '
        'C'    '| wc -l'
        'H'    '| head'
        'T'    '| tail'
        'N'    '&>/dev/null'
        'S'    '| sort -h '
        'V'    '|& nvim -'
        "jk"   "!-2$"
        "j2"   "!-3$"
        "j3"   "!-4$"
    )

    emulate -L zsh
    setopt extendedglob
    local MATCH

    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}

alias vmpd='command cava -i fifo -p /tmp/mpd.fifo -b 20'

zle -N zleiab

hash nmap > /dev/null && {
    # -- [ nmap ] ---------------------------------------------------
    #  -sS - TCP SYN scan
    #  -v - verbose
    #  -T1 - timing of scan. Options are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5)
    #  -sF - FIN scan (can sneak through non-stateful firewalls)
    #  -PE - ICMP echo discovery probe
    #  -PP - timestamp discovery probe
    #  -PY - SCTP init ping
    #  -g - use given number as source port
    #  -A - enable OS detection, version detection, script scanning, and traceroute (aggressive)
    #  -O - enable OS detection
    #  -sA - TCP ACK scan
    #  -F - fast scan
    #  --script=vulscan - also access vulnerabilities in target
    alias nmap_open_ports="nmap --open"
    alias nmap_list_interfaces="nmap --iflist"
    alias nmap_slow="nmap -sS -v -T1"
    alias nmap_fin="nmap -sF -v"
    alias nmap_full="nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
    alias nmap_check_for_firewall="nmap -sA -p1-65535 -v -T4"
    alias nmap_ping_through_firewall="nmap -PS -PA"
    alias nmap_fast="nmap -F -T5 --version-light --top-ports 300"
    alias nmap_detect_versions="nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
    alias nmap_check_for_vulns="nmap --script=vulscan"
    alias nmap_full_udp="nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
    alias nmap_traceroute="nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
    alias nmap_full_with_scripts="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all "
    alias nmap_web_safe_osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "
}

hash journalctl > /dev/null && {
    alias log='journalctl -f | ccze -A' #follow log
}

hash iotop > /dev/null && {
    alias iotop='sudo iotop -oPa'
    alias diskact="sudo iotop -Po"
}

hash nc > /dev/null && alias nyan='nc -v nyancat.dakko.us 23'


alias java='java "$_SILENT_JAVA_OPTIONS"'
alias zinc="zinc -nailed"
alias je="bundle exec jekyll serve"
alias twitch="livestreamer -p ${VIDEO_PLAYER_} twitch.tv/$1 high"
alias recordmydesktop="recordmydesktop --no-frame"
alias up="rtv -s unixporn"

#--[ Fun ]-----------------
alias taco='curl -L git.io/taco'
alias starwars='telnet towel.blinkenlights.nl'

#--[ Csound ]--------------
alias engage='play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +4  synth whitenoise lowpass -1 100 lowpass -1 100  lowpass -1 100 gain +2'
alias ocean='play -q -n -c 2 synth 0 noise 100 noise 100 lowpass 100 gain 12 tremolo 0.125 80;'

#--[ gdb ]-----------------
alias gdb8="gdb -x ${XDG_CONFIG_HOME}/gdb/gdbinit8.gdb"
alias gdbv="gdb -x ${XDG_CONFIG_HOME}/gdb/voltron.gdb"
alias gdbp="gdb -x ${XDG_CONFIG_HOME}/gdb/peda.gdb"

clojure(){ drip -cp /usr/share/clojure/clojure.jar clojure.main }

alias -s Dockerfile="docker build - < "

pacnews() { sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//' }
alias pkglist="comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)"

# upload to imgur with modified zmwangx/imgur
if [[ ${USE_IMGUR_QT} ]]; then
    alias img="imgur-upload $@"
else
    alias img="imgur-screenshot $@"
fi

alias @r=${SCRIPT_HOME}/music_rename

alias vim=nvim
alias vimv=massren

alias ip='ip -c'
alias fd='fd -H'

function mimemap() {
  default=${1}; shift
  for i in $@; do alias -s ${i}=${default}; done
}

mimemap ${BROWSER} htm html
mimemap ${VIDEO_PLAYER_} ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm


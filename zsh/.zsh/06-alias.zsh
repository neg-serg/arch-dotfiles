(){
    local readonly use_cope_path=false
    if [[ ${use_cope_path} == true  ]]; then
        if [[ -x $(which cope_path 2> /dev/null) ]]; then
            # to prevent slow cope_path evaluation
            local cope_path_=$(cope_path)
            for i in "${cope_path_}"/*; alias $(basename ${i})=\"$i\"
            alias df="${cope_path_}/df -hT"
        else
            alias df="df -hT"
        fi
    else 
        local cope_path_=${SCRIPT_HOME}/Cope
        for i in "${cope_path_}"/*; alias $(basename ${i})=\"$i\"
        alias df="${cope_path_}/df -hT"
    fi
    unset cope_path_
}

alias gps='ps -eo cmd,fname,pid,pcpu,time --sort=-pcpu | head -n 11 && echo && ps -eo cmd,fname,pid,pmem,rss --sort=-rss | head -n 9'
alias pstree="pstree -U "$@" | sed '
	s/[-a-zA-Z]\+/\x1B[32m&\x1B[0m/g
	s/[{}]/\x1B[31m&\x1B[0m/g
	s/[─┬─├─└│]/\x1B[34m&\x1B[0m/g'"
alias pscpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias psmem='ps -e -orss=,args= | sort -b -k1,1n|pr -TW$COLUMNS' 

alias '?=bc -l <<<'
alias stderred="LD_PRELOAD=${BIN_HOME}/lib/libstderred.so${LD_PRELOAD:+:\$LD_PRELOAD}"

# If noglob (for zsh) is not available, just make it a noop
if ! type noglob >/dev/null 2>&1; then
    alias noglob=''
fi

local noglob_list=( \
    fc find {,s,l}ftp history locate rake rsync scp \
    eix {z,m}mv wget clive{,scan} youtube-{dl,viewer} \
    translate links{,2} lynx you-get bower pip task)
rlwrap_list=( bigloo clisp irb guile)
sudo_list=({u,}mount ch{mod,own} modprobe i7z) 
[[ -x /usr/bin/systemctl ]] && sysctl_pref="systemctl"
sys_sudo_list=(reboot halt poweroff)

local user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment cat)

local sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
  edit)

local nocorrect_commands=(
    ebuild gist heroku hpodder man mkdir mv mysql sudo
)

for c in ${user_commands}; do; alias sc-${c}="systemctl ${c}"; done
for c in ${sudo_commands}; do; alias sc-${c}="sudo systemctl ${c}"; done

alias sc-enable-now="sc-enable --now"
alias sc-disable-now="sc-disable --now"
alias sc-mask-now="sc-mask --now"

for i in ${sudo_list[@]}; alias "${i}=sudo ${i}";
for i in ${noglob_list[@]}; alias "${i}=noglob ${i}";
for i in ${rlwrap_list[@]}; alias "${i}=rlwrap ${i}";
for i in ${nocorrect_list[@]}; alias "${i}=nocorrect ${i}";
for i in ${sys_sudo_list[@]}; alias "${i}=sudo ${sysctl_pref} ${i}"
unset noglob_list rlwrap_list sudo_list sys_sudo_list

alias fevil='find . -regextype posix-extended -regex'

alias cdu='cdu -idh'

if [[ $UID != 0 ]]; then
    if [ -f "${HOME}/.ssh/config" ]; then
        for host in $( perl -ne 'print "$1\n" if /\A[Hh]ost\s+(.+)$/' ${HOME}/.ssh/config);
            alias ${host}="ssh ${host} '$@'";
    fi
fi

alias ls="ls --color=auto"   # do we have GNU ls with color-support?

if [[ ! -x "${BIN_HOME}/l" ]]; then
    if  [[ -x "${BIN_HOME}/lsp" ]]; then
        alias l="lsp"
        if [[ -x "/usr/bin/vendor_perl/ls++" ]]; then 
            alias l="ls++"; 
        else 
            alias l="ls -aChkopl --group-directories-first --color=auto";
        fi
    fi
fi
alias l.='ls -d .*'
alias l='l -g'
alias spf="ls -Sshr ./*(.)"

alias primusrun="vblank_mode=0 primusrun"

alias magnet2torrent="aria2c -q --bt-metadata-only --bt-save-metadata"

alias mk="mkdir -p"

function eat(){ 
    for i; do 
        vid_fancy_print "${i}"
        ${VIDEO_PLAYER_} --input-ipc-server=$(readlink -f -- ${HOME}/tmp/${VIDEO_PLAYER_}.socket) "${i}"
    done 
}

function mp(){ 
    for i; do vid_fancy_print "${i}"; done
    ${VIDEO_PLAYER_} --input-ipc-server=/tmp/mpvsocket "$@"
}

alias mpa="${VIDEO_PLAYER_} -fs -ao null"
alias mpl="mplayer -ao pulse -vo gl_nosw -really-quiet -double -cache 500 -cache-min 3 -framedrop -utf8  -autoq 100 -bpp 32 -subfont PragmataPro"

alias mpclove="mpc sendmessage mpdas love"
alias mpcunlove="mpc sendmessage mpdas unlove"

alias rg="rg --colors 'match:fg:magenta' --colors 'line:fg:cyan'"
alias grep="grep --color=auto"

alias mutt="dtach -A ${HOME}/.mutt/mutt.session mutt"

#--[ Mount ]----------------------------------------------------------
alias u="umount"
# Taken from https://github.com/blacpythoz/.dots
nmount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }
alias usrmount="sudo mount -o umask=0,uid=nobody,gid=nobody "$1" "$2""
alias mnt='sudo mount'
alias ym="${SCRIPT_HOME}/yandex.mount > /dev/null"

alias s="sudo"
alias x='xargs'
alias e="open"
alias rd="rmdir"

alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

alias ple='perl -wlne' # use perl like awk/sed
# Perl grep, because 'grep -P' is terrible. Lets you work with pipes or files.
# [pattern] [filename unless STDOUT]
prep() { perl -nle 'print if /'"$1"'/;' $2 }

alias {z,m}mv="noglob zmv -Wn"
alias mv="mv -i"

alias tree="tree --dirsfirst -C"
alias acpi="acpi -V"
alias se=extract
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'

if inpath git; then
    alias gs='git status --short -b'
    alias gt='git tag|sort --reverse'
    alias gp='git push'
    alias gdd='git diff'
    alias gc='git commit'
    alias gl='git l|head -20'

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
# alias yt="tsocks youtube-dl  -o '%(autonumber)s_%(title)s.%(ext)s' -c -t -f best --no-part --restrict-filenames 'url'"
# alias yt='cert exec -f ~/.certificates/google.com.crt -- youtube-dl --user-agent Mozilla/5.0'; TCOMP youtube-dl yt
alias ytmp3='youtube-dl -x --audio-format ogg'
_zsh_proxy=""
function yt(){
    ${_zsh_proxy} you-get "$@"
}

function yr(){
    wid=$(xdotool search --classname youtube-get)
    if [[ -z "${wid}" ]]; then
        st -c youtube-get ${SCRIPT_HOME}/yr "$@"
    else
        source ${XDG_CONFIG_HOME}/.windowmanager
        if [[ ${windowmanager} = "i3" ]]; then
            i3-msg '[con_mark="console2"] scratchpad show'
        fi
    fi
}

alias qe='cd *(/om[1])'
alias {cat,hi}='ccat -G String="_default_" -G Plaintext="white" -G Punctuation="blue" -G Literal="fuscia" -G Keyword="fuscia" 2>/dev/null'

alias awk="$(whence gawk || whence awk)"
alias history='history 0'
alias hist10='print -l ${(o)history%%*} | uniq -c | sort -nr | head -n 10' # top10 of the history
alias hist='history'
alias sniff='sudo ngrep -d "enp6s0" -t "^(GET|POST) " "tcp and port 80"'

alias pastebinit='pastebinit -a "Neg" -b "http://paste2.org" -t "Neg is here"'

alias objdump='objdump -M intel -d'
alias memgrind='valgrind --tool=memcheck "$@" --leak-check=full'

alias cal="task calendar"
alias Cal="${SCRIPT_HOME}/dzen/time-date"

if hash glances >/dev/null; then
    alias {{h,}top,lk}=glances
elif hash htop >/dev/null; then
    alias {{h,}top,lk}=htop
elif hash top >/dev/null; then
    alias {{h,}top,lk}=top
fi

user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment)

sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
  node npm reaver aircrack-ng
)

for c in ${user_commands}; do; alias sc-${c}="systemctl ${c}"; done
for c in ${sudo_commands}; do; alias sc-${c}="sudo systemctl ${c}"; done

# URL Tools
# Adds handy command line aliases useful for dealing with URLs
#
# Taken from:
# http://ruslanspivak.com/2010/06/02/urlencode-and-urldecode-from-a-command-line/

if [[ $(whence $URLTOOLS_METHOD) = "" ]]; then
    URLTOOLS_METHOD=""
fi

if [[ $(whence node) != "" && ( "x$URLTOOLS_METHOD" = "x"  || "x$URLTOOLS_METHOD" = "xnode" ) ]]; then
    alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
    alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
elif [[ $(whence python) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xpython" ) ]]; then
    alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
    alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
elif [[ $(whence xxd) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xshell" ) ]]; then
    function urlencode() {echo $@ | tr -d "\n" | xxd -plain | sed "s/\(..\)/%\1/g"}
    function urldecode() {printf $(echo -n $@ | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n"}
elif [[ $(whence ruby) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xruby" ) ]]; then
    alias urlencode='ruby -r cgi -e "puts CGI.escape(ARGV[0])"'
    alias urldecode='ruby -r cgi -e "puts CGI.unescape(ARGV[0])"'
elif [[ $(whence php) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xphp" ) ]]; then
    alias urlencode='php -r "echo rawurlencode(\$argv[1]); echo \"\n\";"'
    alias urldecode='php -r "echo rawurldecode(\$argv[1]); echo \"\\n\";"'
elif [[ $(whence perl) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xperl" ) ]]; then
    if perl -MURI::Encode -e 1&> /dev/null; then
        alias urlencode='perl -MURI::Encode -ep "uri_encode($ARGV[0]);"'
        alias urldecode='perl -MURI::Encode -ep "uri_decode($ARGV[0]);"'
    elif perl -MURI::Escape -e 1 &> /dev/null; then
        alias urlencode='perl -MURI::Escape -ep "uri_escape($ARGV[0]);"'
        alias urldecode='perl -MURI::Escape -ep "uri_unescape($ARGV[0]);"'
    else
        alias urlencode="perl -e '\$new=\$ARGV[0]; \$new =~ s/([^A-Za-z0-9])/sprintf(\"%%%02X\", ord(\$1))/seg; print \"\$new\n\";'"
        alias urldecode="perl -e '\$new=\$ARGV[0]; \$new =~ s/\%([A-Fa-f0-9]{2})/pack(\"C\", hex(\$1))/seg; print \"\$new\n\";'"
    fi
fi

unset URLTOOLS_METHOD

setopt extendedglob
setopt interactivecomments
declare -A abk
abk=(
    'A'    '|& ack -i '
    'G'    '|& rg -i '
    'C'    '| wc -l'
    'H'    '| head'
    'T'    '| tail'
    'N'    '&>/dev/null'
    'S'    '| sort -h '
    'V'    '|& vim -'
    'W'    '|& v -'
    "jk"   "!-2$"
    "jj"   "!-3$"
    "kk"   "!-4$"
)

zleiab() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}

alias vmpd='command cava -i fifo -p /tmp/mpd.fifo -b 20'

zle -N zleiab

inpath nmap && {
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

inpath journalctl && {
    alias log='journalctl -f | ccze -A' #follow log
    alias log0='journalctl -b -0 | ccze -A' #current log 
    alias log1='journalctl -b -1 | ccze -A' #previous log
} 
alias log4="v \"${HOME}/tmp/notionerr\$(pidof notion)\""
inpath iotop && {
    alias iotop='sudo iotop -oPa'
    alias diskact="sudo iotop -Po"
}

inpath nc && alias nyan='nc -v nyancat.dakko.us 23'

alias vuze="vuze&>/dev/null&"

(){
    local dist_dir="/one/dist"
    local jetbrain_products=(idea pycharm rubymine webstorm clion)
    for i in ${jetbrain_products[@]}; do
        jetbrains_path="${dist_dir}/${i}/bin/${i}.sh"
        jetbrains_path_alter="/opt/${i}/bin/${i}.sh"
        if readlink -fq ${jetbrains_path} > /dev/null; then
            alias "$i=${jetbrains_path} > /dev/shm/${i}$$ &" 
        fi
        if readlink -fq ${jetbrains_path_alter} > /dev/null; then
            alias "$i=${jetbrains_path_alter} > /dev/shm/${i}$$ &" 
        fi
    done
}

alias vim=nvim

alias java='java "$_SILENT_JAVA_OPTIONS"'
alias zinc="zinc -nailed"
alias py="bpython"
alias ya="${SCRIPT_HOME}/pkgsearch"
alias gcp="${BIN_HOME}/1st_level/gcp"
alias je="bundle exec jekyll serve"
alias twitch="livestreamer -p ${VIDEO_PLAYER_} twitch.tv/$1 high"
alias vol="${SCRIPT_HOME}/vol_"
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias recordmydesktop="recordmydesktop --no-frame"
alias up="rtv -s unixporn"
#--[ xcape ]---------------
alias xescape='xcape -e "Control_L=Escape" -t 500'
alias capsesc="xcape -e 'Caps_Lock=Escape'"
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

function ju(){
    if [[ $(any jupyter|wc -l) == 0  ]]; then
        jupyter notebook --ip=127.0.0.1 &
        sleep 1s && {
            [[ ${windowmanager} == "notion" ]] && \
                notionflux -e "app.byclass('', 'Firefox')"
        } &
    fi
}

clojure(){ drip -cp /usr/share/clojure/clojure.jar clojure.main }

function g() {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status --short ./*
    fi
}

function d(){
    case "$1" in
        clean)   docker volume ls -qf dangling=true | xargs -r docker volume rm  -v ;;
        craft)   docker run -t -i -d -p 0.0.0.0:25565:25565 -v /var/run/docker.sock:/var/run/docker.sock --name dockercraft gaetan/dockercraft ;;
        check*)  bash <(curl -s https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh) ;;
        mysqld)  docker run -d -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=1 --name mysql mariadb ;;
        mysql)   docker run -it --rm --link mysql:mysql mariadb sh -c 'exec mysql -h$MYSQL_PORT_3306_TCP_ADDR -P$MYSQL_PORT_3306_TCP_PORT -uroot $@' ;;
        pg*)     docker run -d -p 5432:5432 --name postgres postgres ;;
        psql)    docker run -it --rm --link postgres:postgres postgres psql -h postgres -U postgres $@ ;;
        rbt*)    docker run -d --hostname rabbitmq --name rabbitmq -p 15672:15672 -p 5672:5672 rabbitmq:3-management ;;
    esac
}
alias dpa="docker ps -a"

mysql_create() { echo "CREATE USER '$1'@'%' IDENTIFIED BY '$2'; CREATE DATABASE $1 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; GRANT ALL ON $1.* TO '$1'@'%'; FLUSH PRIVILEGES;" }
mysql_drop() { echo "DROP DATABASE $1; DROP USER '$1'@'%'; FLUSH PRIVILEGES;" }
psql_create() { echo "CREATE DATABASE $1" }
psql_drop() { echo "DROP DATABASE $1" }

alias -s Dockerfile="docker build - < "
alias ocr='docker run --rm -v `pwd`:/home/docker jbarlow83/ocrmypdf --skip-text'
alias -s tex='docker run -i -t --rm -v `pwd`:/build docker-registry.eccenca.com/eccenca-latex:v1.4.0 rubber --inplace --maxerr -1 --short --force --warn all --pdf'
alias htcnet='sshfs root@192.168.0.107:/storage/emulated/0 /media/phone/ -p 22'

# Aliases for functions
(){
    alias mdel="${SCRIPT_HOME}/mpd/mdel"
    alias mkeep="${SCRIPT_HOME}/mpd/mkeep"
}

alias gcd='cd $(git rev-parse --show-toplevel 2> /dev/null || builtin print ".")'

function yaourt() {
    pacaur "$@"
}

function pacnews() {
    sudo find /etc -name '*.pacnew' | sed -e 's|^/etc/||' -e 's/.pacnew$//'
}

alias pkglist="comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort)"

# upload to imgur with modified zmwangx/imgur
alias img="imgur-upload $@"

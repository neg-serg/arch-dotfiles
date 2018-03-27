# Dir reload
.() { [[ $# = 0 ]] && cd . || builtin . "$@"; }

function chpwd() {
    if [ -x ${BIN_HOME}/Z ]; then
        [ "${PWD}" -ef "${HOME}" ] || Z -a "${PWD}"
    fi
    setup_prompt
}

function zc(){
    autoload -U zrecompile
    local zcompdumpfile="${HOME}/.zsh/zcomp-${HOST}"
    compinit -d ${compdumpfile}
    for z in ${ZSH}/*.zsh ${HOME}/.zshrc; do 
        zrecompile -p ${z}; 
        echo $(_zpref) $(_zfwrap "${z}"); 
        rm -fv "${z}.zwc.old"
    done
    for f in ${ZSH}/zshrc ${zcompdumpfile};
        zrecompile -p "${f}" && command rm -f "${f}.zwc.old"
    source ${HOME}/.zshrc
}

# Load is-at-least() for more precise version checks Note that this test will
# *always* fail, if the is-at-least function could not be marked for
# autoloading.
zrcautoload is-at-least || is-at-least() { return 1 }

function pk () {
    if [ $1 ] ; then
        case $1 in
            tbz)    tar cjvf $2.tar.bz2 $2                ;;
            tgz)    tar czvf $2.tar.gz  $2                ;;
            tar)    tar cpvf $2.tar  $2                   ;;
            bz2)    bzip $2                               ;;
            gz)     gzip -c -9 -n $2 > $2.gz              ;;
            zip)    zip -r $2.zip $2                      ;;
            7z)     7z a $2.7z $2                         ;;
            *)      echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0 
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "${file_name}" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) [ -z ${commands}[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) [ -z ${commands}[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar x -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "${extract_dir}/control"
        mkdir -p "${extract_dir}/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*) 
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1 
      ;; 
    esac

    (( success = ${success} > 0 ? ${success} : $? ))
    (( ${success} == 0 )) && (( ${remove_archive} == 0 )) && rm "$1"
    shift
  done
}

# grep for running process, like: 'any vime
function any() {
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

function imv() {
    local src dst
    for src; do
        [[ -e ${src} ]] || { print -u2 "${src} does not exist"; continue }
        dst=${src}
        vared dst
        [[ ${src} != ${dst} ]] && mkdir -p ${dst:h} && mv -n ${src} ${dst}
    done
}

function pstop() {
    ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu |
    head "${@:--n 20}" | 
    column -t
}

fasd_cache="${XDG_CACHE_HOME}/fasd-init-cache"
if [ "$(command -v fasd)" -nt "${fasd_cache}" -o ! -s "${fasd_cache}" ]; then
    fasd --init auto >| "${fasd_cache}"
fi
source "${fasd_cache}"
unset fasd_cache

[[ ! -x $(which fd)  ]] && fd() { find . -iregex ".*$@.*" -printf '%P\0' | xargs -r0 ls --color=auto -1d }

XC() { xclip -in -selection clipboard <(history | tail -n1 | cut -f2) }

function slow_output() { while IFS= read -r -N1; do printf "%c" "$REPLY"; sleep ${1:-.02}; done; }
function dropcache { sync && command sudo /bin/zsh -c 'echo 3 > /proc/sys/vm/drop_caches' }

function hugepage_disable(){
    echo 'echo "madvise" >> /sys/kernel/mm/transparent_hugepage/defrag' | sudo -s
    cat /sys/kernel/mm/transparent_hugepage/defrag
}

function cache_list(){
    dirlist=(
        "${HOME}/.w3m/*"
        "${XDG_DATA_HOME}/recently-used.xbel"
        "${XDG_CACHE_HOME}/mc/*"
        "${XDG_DATA_HOME}/mc/history"
        "${HOME}/.viminfo"
        "${HOME}/.adobe/"
        "${HOME}/.macromedia/"
        "${XDG_CACHE_HOME}/mozilla/"
        "${HOME}/.thumbnails/"
    )
    sp ${dirlist}
}

function lastfm_scrobbler_toggle(){
    local is_run="active (running)"
    local use_mpdscribble=false
    if [[ use_mpdscribble == true ]]; then
        if [[ "$(systemctl --user status mpdscribble.service|grep -o "${is_run}")" != "" ]]; then
            systemctl --user stop mpdscribble
            =mpdscribble --conf ${XDG_CONFIG_HOME}/mpdscribble/hextrick.conf --no-daemon &!
        else
            pkill mpdscribble
            systemctl --user start mpdscribble.service
        fi
        builtin printf "$(_zpref) $(_zfwrap "$(any mpdscribble | awk  '{print substr($0, index($0,$11))}'|
            sed "s|${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")")\n"
    else
        if [[ "$(systemctl --user status mpdas.service|grep -o "${is_run}")" != "" ]]; then
            systemctl --user stop mpdas.service
            =mpdas -c ${XDG_CONFIG_HOME}/mpdas/hextrick.rc 2&> /dev/null &!
        else
            pkill mpdas
            systemctl --user start mpdas.service
        fi
        builtin printf "$(_zpref) $(_zfwrap "$(any mpdas | awk  '{print substr($0, index($0,$11))}'|
            sed "s|${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")")\n"
    fi
    unset is_run use_mpdscribble
}

function pid2xid(){ wmctrl -lp | awk "\$3 == $(pgrep $1) {print \$1}" }

if whence adb > /dev/null; then
    function adbpush() {
        for i; do
            echo "$(_zpref) -> $(_zwrap Pushing\ ${i}\ to\ /sdcard/${i:t})"
            adb push ${i} /sdcard/${i:t}
        done
    }
fi

# gather external ip address
function geteip() { curl http://ifconfig.me }

function sp() {
    setopt extendedglob bareglobqual
    if [[ $# == 0 ]]; then
        output=$(du -smc *)
    else
        output=$(du -smc "$@")
    fi
    total=$(tail -1 <<< "${output}")
    distribution.pl --color -g -s=l --char=em <<< $(sed -e '$ d' <<< "${output}")
    _zwrap "Total: $(cut -f1 <<< ${total})"
}


# shameless stolen from http://ft.bewatermyfriend.org/comp/data/zsh/zfunct.html
# MISC: zurl() create small urls via tinyurl.com needs wget, grep and sed. yes, it's a hack ;)
function zurl() {
    [[ -z ${1} ]] && print "please give an url to shrink." && return 1
    local url=${1}
    local tiny="http://tinyurl.com/create.php?url="
    wget -O- -o /dev/null "${tiny}${url}"|grep -Eio "copy\('http://tinyurl.com/.*'"|grep -o "http://.*"|sed s/\'//
}

torch_activate(){ source  ~/src/1st_level/torch/install/bin/torch-activate }
scm_init(){ [[ -s "${HOME}/.scm_breeze/scm_breeze.sh" ]] && source "${HOME}/.scm_breeze/scm_breeze.sh" }

function ql(){
    if [[ $1 != "" ]]; then
        local file=$(resolve_file "$1")
        local upload_dir=${HOME}/1st_level/upload/
        cp "${file}" "${upload_dir}" && \
        builtin printf "$(_zfwrap ${file})\n"
        xsel -o <<< "${upload_dir}/$(basename ${file})"
    fi
}

# this is similar to cut(1) but using awk(1) fields:
# print only the given columns, numbered from 1 to N
kut() { awk "{ print $(for n; do echo -n "\$$n,"; done | sed 's/,$//') }" ;}

function which() {
    if [[ $# > 0 ]]; then
        if [[ -x ${BIN_HOME}/_v ]]; then
            ${BIN_HOME}/_v -c 'set ft=sh' <<< $(builtin which "$@")
        elif [[ -x /usr/bin/ccat ]]; then
            builtin which "$@" | ccat
        else            
            builtin which "$@"
        fi
    fi
}

function set_proxy(){
    if [[ -z ${http_proxy} ]]; then
        echo $(_zpref) $(_zwrap "$(echo "setting proxy to http://127.0.0.1:8118/")")
        export http_proxy="http://127.0.0.1:8118/"
    else
        echo $(_zpref) $(_zwrap "$(echo "unsetting proxy")")
        unset http_proxy
        export http_proxy
    fi
}

function py23switch(){
    python_path="$(which python)"

    if [[ $(basename $(readlink /usr/sbin/python)) == python3 ]]; then
        echo ':: set python (3 to 2) ::'
        sudo ln -fs /usr/sbin/python2 /usr/sbin/python && \
            l ${python_path}
    elif
        [[ $(basename $(readlink /usr/sbin/python)) == python2 ]]; then
        echo ':: set python (2 to 3) ::'
        sudo ln -fs /usr/sbin/python3 /usr/sbin/python && \
            l ${python_path}
    fi
}

if inpath nvim && inpath nvr; then
    function gv(){
        nvr --remote-send ":cd $(pwd)<CR>:GV<CR>"
    }
fi

function ipaddr(){
    one_only=1
    # Created by [jvinet], improved by [Neg]
    for intf in $(ip link |awk -F : '/^[[:alnum:]]+:/{print $2}'|xargs); do
        ip=$(ip addr show "${intf}" 2>/dev/null | grep 'inet ' | grep -o -E '[0-9\.]+' | head -n 1)
        if [[ "${ip}" ]]; then
            builtin print "${intf}: ${ip}"
            if [[ ! ${one_only} ]]; then
                exit # only output one, as that's what our conkyrc expects
            fi
        fi
    done
}

::() { echo -e "\e[0;31m:: \e[0;32m$*\e[0m" >&2 "$@" }

function sprunge() {
    if [[ -t 0 ]]; then
      if [[ "$*" ]]; then
        if [[ -f "$*" ]]; then
          cat "$*"
        else
          echo "$*"
        fi | curl -F 'sprunge=<-' http://sprunge.us
      fi
    else
      curl -F 'sprunge=<-' http://sprunge.us
    fi
}


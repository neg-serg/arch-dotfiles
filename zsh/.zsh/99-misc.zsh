function arc-fix(){
    find -type f -exec sed -i 's/5294e2/00465F/g' {} \;
    find -type f -exec sed -i 's/5294E2/00465F/g' {} \;
}

function chrome_history(){
    export CONF_COLS=$[ COLUMNS/2 ]
    export CONF_SEP='{::}'

    cp -f ${XDG_CONFIG_HOME}/chromium/Default/History /tmp/h

    sqlite3 -separator $CONF_SEP /tmp/h 'select title, url from urls order by last_visit_time desc' \
        | ruby -ne '
    cols = ENV["CONF_COLS"].to_i
    title, url = $_.split(ENV["CONF_SEP"])
    puts "\x1b[33m#{title.ljust(cols)}\x1b[0m #{url}"' \
        | fzf --ansi --multi --no-hscroll --tiebreak=index \
        | grep --color=never -o 'https\?://.*'

    unset CONF_COLS CONF_SEP
}


function firefox_history(){
    (($# == 1)) || { echo "Usage: ${FUNCNAME} path/to/places.sqlite"; exit 1; }

# http://unfocusedbrain.com/site/2010/03/09/dumping-firefoxs-places-sqlite/
sqlite3 "$@" <<-EOF
    SELECT datetime(moz_historyvisits.visit_date/1000000, 'unixepoch'), moz_places.url, moz_places.title, moz_places.visit_count
    FROM moz_places, moz_historyvisits
    WHERE moz_places.id = moz_historyvisits.place_id
    ORDER BY moz_historyvisits.visit_date DESC;
EOF
}


rodir() { sudo mount --bind "$@" && sudo mount -o remount,ro,bind "$@" }

# unrpm: unpack an rpm into a build dir
# 
# Copyright 2007 Aron Griffis <agriffis@n01se.net>
# Released under the GNU General Public License v2

unrpm() {
    declare cmd=${0##*/}
    declare dum version
    read dum version dum <<<'$Revision: 4036 $'

    case $cmd in
        unrpm_|rpmbuild) true ;;
        *) die "unrpm: I don't know how to be $cmd" ;;
    esac

    $cmd "$@"
    exit $?
}

unrpm_() {
    declare args usage
    read -d '' usage <<EOT
usage: unrpm pkg-1.0.src.rpm...

        -f   --force          Unpack into an existing dir
        -l   --list           List contents rather than unpack
        -p   --prep           Prep sources after unpack
        -v   --verbose        Be louder

             --help           Show this help message
             --version        Show version information
EOT

    # Use /usr/bin/getopt which supports GNU-style long options
    declare opt_force=false
    declare opt_list=false
    declare opt_prep=false
    declare opt_verbose=false
    args=$(getopt -n "$0" \
    -o flpv --long force,help,list,prep,verbose,version -- "$@") || exit
    eval set -- "$args"
    while true; do
        case $1 in
            -f|--force) opt_force=true ; shift ;;
            -l|--list) opt_list=true ; shift ;;
            -p|--prep) opt_prep=true ; shift ;;
            -v|--verbose) opt_verbose=true ; shift ;;
            --help) echo_unrpm_ "$usage"; exit 0 ;;
            --version) echo_unrpm_ "$cmd $version"; exit 0 ;;
            --) shift; break ;;
            *) die "failed to process cmdline args" ;;
        esac
    done

    if [[ -z $1 ]]; then
        die "missing argument, try --help"
    elif [[ ! -r $1 ]]; then
        die "can't read: $1"
    fi

    set -e

    declare dirs rpm repo v
    $opt_verbose && v=v ||:
    for rpm in "$@"; do
        repo=$(rpm -qp --qf '%{N}-%{V}-%{R}' "$rpm")
        dirs=( "$repo/"{BUILD,RPMS,SOURCES,SPECS,SRPMS} )

        if $opt_list; then
            rpm2cpio $rpm | cpio --quiet -it$v | \
            sed "s|^[./]*/*|$repo/SOURCES/|;/\\.spec/s/SOURCES/SPECS/"
            continue
        fi

        if $opt_force; then
            mkdir -p$v "${dirs[@]}"
        else
            mkdir ${v:+-v} $repo "${dirs[@]}"
        fi

        rm -f$v $repo/SOURCES/* $repo/SPECS/*
        rpm2cpio $rpm | ( cd $repo/SOURCES; cpio --quiet -imd$v; )
        mv ${v:+-v} $repo/SOURCES/*.spec $repo/SPECS

        if $opt_prep; then
            rpmbuild -bp $repo/SPECS/*.spec
        fi
    done
}

echo_unrpm_() {
    printf '%s\n' "$*"
}

die() {
    declare status=1
    if [[ $1 == ?* && $1 != *[!0-9]* ]]; then
        status=$1
        shift
    fi
    echo_unrpm_ "$cmd: ${*:-error}" >&2
    exit $status
}

rpmbuild() {
    declare x topdir
    for x; do
        if [[ $x == *.spec ]]; then
            topdir=$(cd $(dirname $x)/..; pwd)
            break
        elif [[ $1 == -t* ]]; then
            case $x in
                *.tar.gz|*.tar.bz2) topdir=${x%.*.*}; break ;;
                *.tgz|*.tbz2)       topdir=${x%.*};   break ;;
            esac
        fi
    done

    set -e

    declare cmd status=0

    # it sucks when rpmbuild bombs because of missing dirs
    [[ -z $topdir ]] || topdir=$(readlink -f $topdir)
    [[ -z $topdir ]] || mkdir -p "$topdir/"{SPECS,SOURCES,BUILD,RPMS,SRPMS}

    # can't use simple "wrapped $0" because we might have been called as unrpm
    cmd=( 
        "$(wrapped "$(dirname "$(type -P "$0")")"/rpmbuild)"
        ${topdir:+--define="_topdir $topdir"}
        "$@"
    )
    printf "%q " "${cmd[@]}"; echo_unrpm_

    # log rpmbuild output
    [[ -z $topdir ]] || exec 3>&1 4>&2 1> >(tee $topdir/rpmbuild-$$.out) 2>&1
    "${cmd[@]}" || status=$?
    [[ -z $topdir ]] || exec 1>&3- 2>&4-

    set +e

    return $status
}

function gfshow(){
    git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(bold black)(%cr) %C(bold blue)<%an>" "$@" |
    SHELL="/bin/bash" fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=ctrl-s \
        --exact --cycle --inline-info --prompt="Commits> " \
        --bind "ctrl-m:execute:
                (grep -o '[0-9a-f]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF_EOF'
        {}
    FZF_EOF"
}

function allip(){
    netstat -lantp \
  | grep ESTABLISHED \
  | awk '{print }' \
  | awk -F: '{print }' \
  | sort -u
}


function flac2alac() {
	local infile="$1"
	local outfile="${infile/%flac/m4a}"
	local album_artist=$(metaflac --show-tag='ALBUM ARTIST' "$infile" | sed 's/ALBUM ARTIST=//g')

	echo "Converting ${infile} to ${outfile} ..."

	ffmpeg -i "$infile" -acodec flac -metadata album_artist="$album_artist" "$outfile"
}

function flac2mp3(){
    for f in "$@"; do
        [[ "$f" != *.flac ]] && continue
        album="$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')"
        artist="$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')"
        date="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
        title="$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')"
        year="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
        genre="$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')"
        tracknumber="$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')"

        flac --decode --stdout "$f" | lame -b 320 --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre" - "${f%.flac}.mp3"
    done
}

# tmux-neww-in-cwd - open a new shell with same cwd as calling pane
# http://chneukirchen.org/dotfiles/bin/tmux-neww-in-cwd
tmux-neww-in-cwd() {
    SIP=$(tmux display-message -p "#S:#I:#P")

    PTY=$(tmux server-info |
    egrep flags=\|bytes |
    awk '/windows/ { s = $2 }
    /references/ { i = $1 }
    /bytes/ { print s i $1 $2 } ' |
    grep "$SIP" |
    cut -d: -f4)

    PTS=${PTY#/dev/}

    PID=$(ps -eao pid,tty,command --forest | awk '$2 == "'$PTS'" {print $1; exit}')

    DIR=$(readlink /proc/$PID/cwd)

    tmux neww "cd '$DIR'; $SHELL"
}

function print_hooks() {
    print -C 1 ":::pwd_functions:" ${chpwd_functions}
    print -C 1 ":::periodic_functions:" ${periodic_functions}
    print -C 1 ":::precmd_functions:" ${precmd_functions}
    print -C 1 ":::preexec_functions:" ${preexec_functions}
    print -C 1 ":::zshaddhistory_functions:" ${zshaddhistory_functions}
    print -C 1 ":::zshexit_functions:" ${zshexit_functions}
}

function fun::fonts(){
    alias 2023='toilet -f future'
    alias gaym='toilet --gay -f mono9 -t'
    alias gayf='toilet --gay -f future -t'
    alias gayt='toilet --gay -f term -t'
    alias gayp='toilet --gay -f pagga -t'
    alias metm='toilet --metal -f mono9 -t'
    alias metf='toilet --metal -f future -t'
    alias mett='toilet --metal -f term -t'
    alias metp='toilet --metal -f pagga -t'
    alias 3d='figlet -f 3d'
}

function sh_lsof(){
    pushd
    cd /proc
    for a in * ; do
        test "${a}" -gt 0 2> /dev/null
        [[ ! $? = 0 ]] && continue
        pid_="${a}"
        name="$(readlink ${a}/exe)"
        [[ -z "${name}" ]] && continue
        name="$(basename ${name})"
        (   cd ${a}/fd
            for b in * ; do
                link="$(readlink ${b})"
                [[ -z "${link}" ]] && continue
                printf "${pid_}\t${name}\t${link}\n"
            done
        )
    done
    popd
}

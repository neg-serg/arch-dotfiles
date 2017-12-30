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

function allip(){
    netstat -lantp \
  | grep ESTABLISHED \
  | awk '{print }' \
  | awk -F: '{print }' \
  | sort -u
}

function flac2alac() {
    for infile in "$@"; do
        [[ "${infile}" != *.flac ]] && continue
        outfile="${infile/%flac/m4a}"

        album_artist=$(metaflac --show-tag='ALBUM ARTIST' "${infile}" | sed 's/ALBUM ARTIST=//g')
        album="$(metaflac --show-tag=album "${infile}" | sed 's/[^=]*=//')"
        artist="$(metaflac --show-tag=artist "${infile}" | sed 's/[^=]*=//')"
        date="$(metaflac --show-tag=date "${infile}" | sed 's/[^=]*=//')"
        title="$(metaflac --show-tag=title "${infile}" | sed 's/[^=]*=//')"
        year="$(metaflac --show-tag=date "${infile}" | sed 's/[^=]*=//')"
        genre="$(metaflac --show-tag=genre "${infile}" | sed 's/[^=]*=//')"
        tracknumber="$(metaflac --show-tag=tracknumber "${infile}" | sed 's/[^=]*=//')"

        ffmpeg -i "${infile}" -c:a alac \
            -metadata album_artist="${album_artist}" \
            -metadata album="${album}" \
            -metadata artist="${artist}" \
            -metadata title="${title}" \
            -metadata date="${date}" \
            -metadata genre="${genre}" \
            -metadata tracknumber="${tracknumber}" \
                "${outfile}" 
    done
}

function flac2mp3(){
    for infile in "$@"; do
        [[ "${infile}" != *.flac ]] && continue
        album="$(metaflac --show-tag=album "${infile}" | sed 's/[^=]*=//')"
        artist="$(metaflac --show-tag=artist "${infile}" | sed 's/[^=]*=//')"
        date="$(metaflac --show-tag=date "${infile}" | sed 's/[^=]*=//')"
        title="$(metaflac --show-tag=title "${infile}" | sed 's/[^=]*=//')"
        year="$(metaflac --show-tag=date "${infile}" | sed 's/[^=]*=//')"
        genre="$(metaflac --show-tag=genre "${infile}" | sed 's/[^=]*=//')"
        tracknumber="$(metaflac --show-tag=tracknumber "${infile}" | sed 's/[^=]*=//')"

        flac --decode --stdout "${infile}" | lame -b 320 --add-id3v2 \
            --tt "${title}" \
            --ta "${artist}" \
            --tl "${album}" \
            --ty "${year}" \
            --tn "${tracknumber}" \
            --tg "${genre}" - "${infile%.flac}.mp3"
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

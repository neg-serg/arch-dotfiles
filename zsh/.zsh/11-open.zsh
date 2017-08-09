#! /bin/zsh
function open(){
    local editor="v"
    local web_browser="firefox"
    local vid_pl="mpv"
    local audio_player="mpv"
    local doc_reader="zathura"
    local image_viewer="~/bin/scripts/sxiv_browser.sh"

    if [[ -e $1 ]]; then
        mime_type=$(file -L -b --mime-type "$1")
        # the order is important, e.g. foo/bar must appear before foo/*
        case ${mime_type} in
            video/*|application/vnd.rn-realmedia) ${vid_pl} "$1" ;;
            audio/*) ${audio_player} "$1" ;;
            image/vnd.djvu) [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
            image/svg+xml\
                |application/x-shockwave-flash) ${web_browser} "$1" ;;
            image/x-xcf) gimp "$1" ;;
            image/*) ${image_viewer} "$1" ;;
            application/postscript) [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
            application/pdf) [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
            application/djvu) [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
            application/epub) [[ $# -le 9 ]] && ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
            application/x-bittorrent) ta "$1" ;;
            application/vnd.ms-opentype\
                |application/x-font-ttf\
                |application/vnd.font-fontforge-sfd) fontforge "$1" ;;
            text/html) $web_browser "$1" ;;
            text/troff) man -l "$1" ;;
            *) case "$1" in
                *.nzb) xchm "$1" 2>/dev/null ;;
                *.nfo) nzbget -A "$1" 2>/dev/null ;;
                *.pcf|*.bdf|*.pfb) ${editor} "$1" ;;
                *.svg) display "$1" ;;
                *.pps|*.PPS|*.ppt|*.PPT) ${web_browser} "$1" ;;
                *.rtf|*.doc|*.docx)  libreoffice "$1" 2>/dev/null ;;
                *.epub|*.ps|*.pdf|*.cb|*.djvu) ${doc_reader} "$@" >/dev/null 2>/dev/null &! ;;
                *.xls) catdoc -w -s cp1251 "$1" ;;
                *.xpm) xls2csv -s cp1251 "$1" ;;
                *.mp3|*.m3u|*.ogg) ${audio_player} "$1" ;;
                *.mp4|*.avi|*.mpg|*.mpeg|*.mkv|*.ogv|*.f4v|*.m2ts) ${vid_pl} "$1" ;;
            esac
            ;;
        esac
    fi
}

function finfo() {
while [ $# -gt 0 ] ; do
    mime_type=$(file -L -b --mime-type "$1")
    case $mime_type in
        image/svg+xml) inkscape -S "$1" ;;
        video/* | application/vnd.rn-realmedia | audio/* | image/*) mediainfo "$1" ;;
        application/pdf) pdfinfo "$1" ;;
        application/zip) unzip -l "$1" ;;
        application/x-lha) lha -l "$1" ;;
        application/x-rar) unrar lb "$1" ;;
        application/x-bittorrent) aria2c -S "$1" | grep '\./' ;;
        application/x-iso9660-image) isoinfo -J -l -i "$1" ;;
        *)
            case "$1" in
                *.torrent) aria2c -S "$1" | grep '\./' ;;
                *.mkv) mediainfo "$1" ;;
                *.ace) unace l "$1" ;;
                *.icns) icns2png -l "$1" ;;
                *) file -b "$1" ;;
            esac
            ;;
    esac
    shift
done
}


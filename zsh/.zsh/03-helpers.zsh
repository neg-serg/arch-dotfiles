autoload -U colors && colors

function _zwrap() { echo "$fg[blue][$fg[white]$1$fg[blue]]$fg[default]" }

function _zFwrap(){
    apply="${1}";
    body="${2}";
    shift
    echo "$(apply)" "${body}" "$(apply)"
}

function _zgwrap(){
    side="${1}"
    body="${2}"
    shift
    echo "${side}" "${body}" "${side}"
}

function _zfwrap() {
    local tmp_name="$(echo $1|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
    local decoration="$fg[green]‒$fg[white]"
    local fancy_name="${decoration} $fg[white]${tmp_name} ${decoration}"
    echo "${fancy_name}"
}

function _zpref() { echo $(_zwrap ">>") }
function _zfg(){ echo -ne "[38;5;$1m" }
function _zdelim(){ echo -ne "$(_zfg 24)::"$(_zfg 8) }

function resolve_file {
    if [[ -f "$1" ]]; then
        echo $(readlink -f "$1")
    elif [[ "${1#/}" == "$1" ]]; then
        echo "$(pwd)/$1"
    else
        echo "${1}"
    fi
}

function not_empty_in_fact_(){
    if [[ $(echo "${1}"| tr -d '[:blank:]') != "" ]]; then
        true
    else
        false
    fi
}

function _zfile_sz(){
    sed "s/\([KMGT]\)/&i/" | {
        sed "s/\([KMGT]iB\|B\)/$fg[green]&/" || \
        numfmt --to=iec-i --suffix=B|sed "s/\([KMGT]iB\|B\)/$fg[green]&/"
    }
}

function _zsufhi(){
    { sed "s/\([KMGT]\)/$fg[green]&/" 
    builtin print -n "$fg[white]"  } | \
    tr -d '\n'
}

function draw_line(){
    [ $1 ] && linechar=$1 || linechar='─'
    [ $2 ] && color=$2 || color=${_red_}
    width=$(tput cols)

    line=$(head -c $width </dev/zero | tr '\0' 'X')
    # utf-8 characters preclude use of cut -b -$width
    line=$(echo $line | sed "s/X/$linechar/g" | sed -e "s/^\(.\{$width\}\).*/\1/")

    echo "$color$line${_nocolor_}"
}

_zex_tag(){ grep -E '^'"$1"'' <<< ${exifdata_} | cut -d ':' -f 2- | tr -d '[:blank:]' }
_zex_tag_untr(){ grep -E '^'"$1"'' <<< ${exifdata_} | cut -d ':' -f 2- }

function vid_fancy_print(){
    if [[ -f "$1" ]]; then
        exifdata_=$(exiftool "$1")
        #------------------------------------------
        local fancy_name=$(_zfwrap "$1")
        local vid_comment="$(_zex_tag 'Comment')"
        if [[ ! $(tr -d '[:blank:]'<<< ${vid_comment} ) == "" ]]; then
            local comment_str="$(_zwrap "Comment $(_zdelim) ${vid_comment}")"
        else
            local comment_str=""
        fi
        #------------------------------------------
        local img_width="$(_zex_tag 'Image Width')"
        local img_height="$(_zex_tag 'Image Height')"
        local img_size_str="$(_zwrap "Size $(_zdelim) $fg[white]${img_width}$(_zfg 24)x$fg[white]${img_height}")"
        #------------------------------------------
        local duration="$(awk -F: '/^Duration/' <<< ${exifdata_}|awk -F ':' '{print substr($0, index($0,$2))}'|tr -d '[:blank:]')"
        local duration_str="$(_zwrap "Duration $(_zdelim) $fg[white]${duration}")"
        #------------------------------------------
        local file_size="$(_zex_tag 'File Size')"
        local file_size_str="$(_zwrap "File Size $(_zdelim) $fg[white] $(_zfile_sz <<< ${file_size})")"
        #------------------------------------------
        local mime_type="$(_zex_tag 'MIME Type')"
        not_empty_in_fact_ ${mime_type} && \
        local mime_type_str="$(_zwrap "MIME Type $(_zdelim) $fg[white]${mime_type}")"
        #------------------------------------------
        local average_bitrate="$(_zex_tag 'Average Bitrate')"
        local max_bitrate="$(_zex_tag 'Max Bitrate')"
        not_empty_in_fact_ ${max_bitrate} && not_empty_in_fact_ ${average_bitrate} && \
        {
            local average_bitrate=$(_zsufhi <<< $(builtin print -n $(bc <<< "$(_zex_tag 'Average Bitrate') / 1000.")K))
            local max_bitrate=$(_zsufhi <<< $(builtin print -n $(bc <<< "$(_zex_tag 'Max Bitrate') / 1000.")K))
            local bitrate_str="$(_zwrap "Bitrate $(_zdelim) $fg[white]${average_bitrate}/${max_bitrate}")"
        }
        #------------------------------------------
        local genre="$(_zex_tag_untr 'Genre')"
        not_empty_in_fact_ ${genre} && \
        local genre_str="$(_zwrap "Genre: $(_zdelim) $fg[white]${genre}")"
        #------------------------------------------
        local video_frame_rate="$(_zex_tag 'Video Frame Rate')"
        not_empty_in_fact_ ${video_frame_rate} && \
        local vid_fps_str="$(_zwrap "FPS: $(_zdelim) $fg[white]${video_frame_rate}")"
        #------------------------------------------
        local audio_bits="$(_zex_tag 'Audio Bits Per Sample')"
        local audio_sample_rate="$(_zex_tag 'Audio Sample Rate')"
        not_empty_in_fact_ ${audio_bits} && not_empty_in_fact_ ${audio_sample_rate} && \
        local audio_qa_str="$(_zwrap "Audio: $(_zdelim) $fg[white]${audio_bits}$fg[green]bits$fg[blue]/$fg[white]$(printf "%.1f" $[${audio_sample_rate}/1000.])$fg[green]Khz")"
        #------------------------------------------
        local encoder="$(_zex_tag 'Encoder')"
        not_empty_in_fact_ ${encoder} && \
        local encoder_str="$(_zwrap "Encoder: $(_zdelim) $fg[white]${encoder}")"
        #------------------------------------------
        local wrighting_app="$(_zex_tag 'Wrighting App')"
        not_empty_in_fact_ ${wrighting_app} && \
        local writing_app_str="$(_zwrap "Wrighting App $(_zdelim) ${wrighting_app}")"
        #------------------------------------------
        local description="$(_zex_tag_untr 'Description'|par -120)"
        not_empty_in_fact_ ${description} && \
        local description_str="$(_zwrap "Description $(_zdelim) $fg[white]${description}")"
        #------------------------------------------
        local wrighting_app="$(_zex_tag 'Muxing App')"
        not_empty_in_fact_ ${muxing_app} && \
        local muxing_app_str="$(_zwrap "Muxing App $(_zdelim) ${wrighting_app}")"
        #------------------------------------------
        local doc_type="$(_zex_tag 'Doc Type'|tr '\n' ' '|sed 's/ *$//')"
        not_empty_in_fact_ ${doc_type} && \
        local doc_type_str="$(_zwrap "Doc Type $(_zdelim) $fg[white]${doc_type}")"
        #------------------------------------------
        local date_time="$(_zex_tag_untr 'Date\/Time Original')"
        not_empty_in_fact_ ${date_time} && \
        local date_time_str="$(_zwrap "Date/Time $(_zdelim) $fg[white]${date_time}")"
        #------------------------------------------
        if [[ ! $(tr -d '[:blank:]' <<< ${created_str}) == "" ]]; then
            local created_str="$(_zwrap Created $(_zdelim) ${date_time})"
        else
            local created_str=""
        fi
        #------------------------------------------
        builtin print "$(_zpref) ${fancy_name}"
        for q in ${img_size_str} \
                 ${duration_str} \
                 ${bitrate_str} \
                 ${vid_fps_str} \
                 ${audio_qa_str} \
                 ${created_str} \
                 ${file_size_str} \
                 ${mime_type_str} \
                 ${comment_str} \
                 ${wrighting_app_str} \
                 ${muxing_app_str} \
                 ${doc_type_str} \
                 ${date_time_str} \
                 ${encoder_str} \
                 ${genre_str} \
                 ${description_str} \
                 ; do
            [[ ! ${q} == "" ]] && builtin print -n "${q}"
        done
        echo
        unset exifdata_
    fi
}


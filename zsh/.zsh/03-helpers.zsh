autoload -U colors && colors

function zwrap { 
    echo "$fg[blue]⟬$fg[white]${1}$fg[blue]⟭$fg[default]" 
}

function zfwrap {
    apply="${1}"; body="${2}"; shift
    echo "$(apply)" "${body}" "$(apply)"
}

function zgwrap {
    side="${1}"; body="${2}"; shift
    echo "${side}" "${body}" "${side}"
}

function zfwrap {
    local tmp_name="$(echo $1|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
    local lhs="$fg[blue]⟬$fg[white]"
    local rhs="$fg[blue]⟭$fg[white]"
    local fancy_name="${lhs}$fg[white]${tmp_name}${rhs}"
    echo "${fancy_name}"
}

function zpref {
    echo $(zwrap "\e[38;05;25m>\e[38;05;26m>$fg[default]") 
}

function zfg {
    echo -ne "[38;5;$1m" 
}

function zdelim {
    if [[ $# == 0 ]]; then
        echo -ne "$(zfg 24)::"$(zfg 8) 
    else
        echo -ne "$(zfg $1)${2}"$(zfg 8) 
    fi
}

function resolve_file {
    if [[ -f "${1}" ]]; then
        echo $(readlink -f "${1}")
    elif [[ "${1#/}" == "$1" ]]; then
        echo "$(pwd)/${1}"
    else
        echo "${1}"
    fi
}

function not_empty {
    if [[ $(echo "${1}"| tr -d '[:blank:]') != "" ]]; then
        true
    else
        false
    fi
}

function zfile_sz {
    sed "s/\([KMGT]\)/&i/" | {
        sed "s/\([KMGT]iB\|B\)/$fg[green]&/" || \
        numfmt --to=iec-i --suffix=B|sed "s/\([KMGT]iB\|B\)/$fg[green]&/"
    }
}

function zsufhi {
    { 
        sed "s/\([KMGT]\)/$fg[green]&/"
        builtin print -n "$fg[white]"  
    } | tr -d '\n'
}

function draw_line {
    [ ${1} ] && linechar=${1} || linechar='─'
    [ ${2} ] && color=${2} || color=${_red_}
    width=$(tput cols)

    line=$(head -c "${width}" </dev/zero | tr '\0' 'X')
    # utf-8 characters preclude use of cut -b -$width
    line=$(echo "${line}" | sed "s/X/$linechar/g" | sed -e "s/^\(.\{$width\}\).*/\1/")

    echo "${color}${line}${_nocolor_}"
}

function zex_tag {
    grep -E '^'"${1}"'' <<< "${exifdata_}" \
        | cut -d ':' -f 2- \
        | tr -d '[:blank:]'
}

function zex_tag_untr {
    grep -E '^'"${1}"'' <<< "${exifdata_}" \
        | cut -d ':' -f 2-
}

function vid_fancy_print {
    if [[ -f "${1}" ]]; then
        exifdata_="$(exiftool "${1}")"
        #------------------------------------------
        local fancy_name=$(zfwrap "${1}")
        local vid_comment="$(zex_tag 'Comment')"
        if [[ ! $(tr -d '[:blank:]'<<< ${vid_comment}) == "" ]]; then
            local comment_str="$(zwrap "Comment$(zdelim)${vid_comment}")"
        else
            local comment_str=""
        fi
        #------------------------------------------
        local img_width="$(zex_tag 'Image Width')"
        local img_height="$(zex_tag 'Image Height')"
        not_empty ${img_width} && not_empty ${img_height} && \
            local img_size_str="$(zwrap "Resolution$(zdelim)$fg[white]${img_width}$(zfg 24)x$fg[white]${img_height}")"
        #------------------------------------------
        local duration="$(awk -F: '/^Duration/' <<< ${exifdata_}|awk -F ':' '{print substr($0, index($0,$2))}'|tr -d '[:blank:]')"
        local duration_str="$(zwrap "Duration$(zdelim)$fg[white]${duration}")"
        #------------------------------------------
        local file_size="$(zex_tag 'File Size')"
        local file_size_str="$(zwrap "Size$(zdelim)$fg[white]$(zfile_sz <<< ${file_size})")"
        #------------------------------------------
        local mime_type="$(zex_tag 'MIME Type')"
        not_empty ${mime_type} && \
            local mime_type_str="$(zwrap "MIME$(zdelim)$fg[white]${mime_type}")"
        #------------------------------------------
        local average_bitrate="$(zex_tag 'Average Bitrate')"
        local max_bitrate="$(zex_tag 'Max Bitrate')"
        not_empty ${max_bitrate} && \
        not_empty ${average_bitrate} && \
            {
                local average_bitrate=$(zsufhi <<< $(builtin print -n $(bc <<< "$(zex_tag 'Average Bitrate') / 1000.")K))
                local max_bitrate=$(zsufhi <<< $(builtin print -n $(bc <<< "$(zex_tag 'Max Bitrate') / 1000.")K))
                local bitrate_str="$(zwrap "Bitrate$(zdelim)$fg[white]${average_bitrate}/${max_bitrate}")"
            }
        #------------------------------------------
        local genre="$(zex_tag_untr 'Genre')"
        not_empty ${genre} && \
            local genre_str="$(zwrap "Genre$(zdelim)$fg[white]${genre}")"
        #------------------------------------------
        local video_frame_rate="$(printf "%.0f" $(zex_tag 'Video Frame Rate'))"
        not_empty ${video_frame_rate} && \
            local vid_fps_str="$(zwrap "FPS$(zdelim)$fg[white]${video_frame_rate}")"
        #------------------------------------------
        local audio_bits="$(zex_tag 'Audio Bits Per Sample')"
        local audio_sample_rate="$(zex_tag 'Audio Sample Rate')"
        not_empty ${audio_bits} && \
        not_empty ${audio_sample_rate} && \
            local audio_qa_str="$(zwrap "Audio$(zdelim)$fg[white]${audio_bits}$fg[green]bits$fg[blue]/$fg[white]$(printf "%.1f" $[${audio_sample_rate}/1000.])$fg[green]Khz")"
        #------------------------------------------
        local encoder="$(zex_tag 'Encoder')"
        not_empty ${encoder} && \
            local encoder_str="$(zwrap "Encoder$(zdelim)$fg[white]${encoder}")"
        #------------------------------------------
        local wrighting_app="$(zex_tag 'Wrighting App')"
        not_empty ${wrighting_app} && \
            local writing_app_str="$(zwrap "Wrighting App$(zdelim)${wrighting_app}")"
        #------------------------------------------
        local description="$(zex_tag_untr 'Description'|par -120)"
        not_empty ${description} && \
            local description_str="$(zwrap "Description$(zdelim)$fg[white]${description}")"
        #------------------------------------------
        local wrighting_app="$(zex_tag 'Muxing App')"
        not_empty ${muxing_app} && \
            local muxing_app_str="$(zwrap "Muxing App$(zdelim)${wrighting_app}")"
        #------------------------------------------
        local date_time="$(zex_tag_untr 'Date\/Time Original')"
        not_empty ${date_time} && \
            local date_time_str="$(zwrap "Date/Time$(zdelim)$fg[white]${date_time}")"
        #------------------------------------------
        local created_str=""
        if [[ ! $(tr -d '[:blank:]' <<< ${created_str}) == "" ]]; then
            created_str="$(zwrap Created$(zdelim)${date_time})"
        fi
        #------------------------------------------
        if (( ${#1} < 34 )); then
            echo -ne "$(zpref)${fancy_name}$(zdelim 22 ':')"
        else
            echo -e "$(zpref)${fancy_name}"
        fi
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
                 ${date_time_str} \
                 ${encoder_str} \
                 ${genre_str} \
                 ${description_str}; do
            [[ ! ${q} == "" ]] && builtin print -n "${q}"
        done
        echo
        unset exifdata_
    fi
}


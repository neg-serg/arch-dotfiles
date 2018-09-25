#!/bin/zsh

source ${ZSH}/03-helpers.zsh

autoload colors && colors

function eat () {
    prog=${0##*/}
    local pass="*"
    filename="$@"
    xclip -in -selection c < "${filename}"
    zwrap "${pass} ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

function main() {
    readonly ftype_pref="ftype-"
    readonly dircolors_location="${XDG_CONFIG_HOME}/dircolors/.dircolors"

    readonly tmp_file="$(mktemp)"
    readonly ftype_arr="/tmp/ftype_arr"
    readonly ftype_rule="/tmp/ftype_rule"

    readonly is_bold="\\(01;\|;1\\)"
    readonly is_italic="\\(03;\|;3\\)"
    readonly is_uline="\\(04;\|;4\\)"
    readonly bold_regex="/${is_bold}/"
    readonly italic_regex="/${is_italic}/"
    readonly uline_regex="/${is_uline}/"

    readonly fg_eq="38;5;" 
    readonly bg_eq="48;5;"

    egrep '^[.*]' ${1:-$dircolors_location} \
        |sed 's/#.*//' \
        |sed "s/^\.\W*/${ftype_pref}/" > "${tmp_file}"

    zwrap "-----------------------------"
    zwrap "You should handle it by hand:"
    zwrap "-----------------------------"

    local -a sed_args=(
        -e "s/${fg_eq}/fg=/"               
        -e "s/${bg_eq}/bg=/g"              
        -e "${bold_regex}s/$/,bold/"       
        -e "${italic_regex}s/$/,italic/"       
        -e "${uline_regex}s/$/,underline/" 
        -e "s/00;//"                       
        -e "s/${is_bold}//"                
        -e "s/${is_uline}//"               
        -e "s/${is_italic}//"               
        -e "s/;/,/g"                       
        -e "/\ 3[0-9][0-9]*/s/3/fg=/"      
        -e "s/, //g"
    )

    egrep "^${ftype_pref}" -v "${tmp_file}"
    egrep "^${ftype_pref}" "${tmp_file}" | sed ${sed_args} > "${ftype_arr}"

    nohup zsh -c "nvim +'Tabularize/[bf]g=.*' "${ftype_arr}" +'wq'" > /dev/null 2>&1
    sed "s/^${ftype_pref}//" "${ftype_arr}" |awk '{print "*."$1") style=ftype-"$1" ;;"}' > "${ftype_rule}"
    nohup zsh -c "nvim +'Tabularize/)\zs ' "${ftype_rule}" +'wq'" > /dev/null 2>&1

    for t in "${ftype_arr}" "${ftype_rule}"; eat "${t}"
    rm "${tmp_file}"

    cp -iv "${ftype_arr}" ~/.zsh/highlighters/ft_list.zsh

    start_line=$[$(grep -n '#.*Begining of ftype array.*@@@@' ~/.zsh/highlighters/main-highlighter.zsh|cut -f1 -d:)+1]
    end_line=$[$(grep -n '#.*End of ftype array.*@@@@' ~/.zsh/highlighters/main-highlighter.zsh|cut -f1 -d:)-1]

    if [[ "${start_line}" != "" && "${end_line}" != "" ]]; then
        # Delete highlight array from file
        sed -i "${start_line},${end_line}d" ~/.zsh/highlighters/main-highlighter.zsh > /tmp/test

        new_start_line=$[$(grep -n '#.*Begining of ftype array.*@@@@' ~/.zsh/highlighters/main-highlighter.zsh|cut -f1 -d:)]
        while read line; do
            sed -i "${new_start_line}a \\\t\t${line}" ~/.zsh/highlighters/main-highlighter.zsh
        done < "${ftype_rule}"
    fi

}

main "${1}"

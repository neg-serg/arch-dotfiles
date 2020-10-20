zleiab() {
    local -A abk=(
        'G'    '|& rg -i '
        'Z'    '|& rg -iz '
        'C'    '| wc -l'
        'E'    '| head'
        'T'    '| tail'
        'Q'    '&>/dev/null'
        'S'    '| sort -h '
        'V'    '|& v -'
        "e1"   "!-2$"
        "e2"   "!-3$"
        "e3"   "!-4$"
        "we"   "!-2$"
        "wd"   "!-3$"
        "wc"   "!-4$"
    )
    local MATCH
    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}
zle -N zleiab

inplace_mk_dirs() {
    # Press ctrl-xM to create the directory under the cursor or the selected area.
    # To select an area press ctrl-@ or ctrl-space and use the cursor.
    # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
    # directory does not exist yet -> press ctrl-XM and problem solved
    local PATHTOMKDIR
    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR
        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi
        # get marked area from buffer and eliminate whitespace
        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi
    [[ -z "${PATHTOMKDIR}" ]] && return 1
    PATHTOMKDIR=${~PATHTOMKDIR}
    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M " path already exists, doing nothing"
    else
        zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
        zle end-of-line
    fi
}

imv() {
    local src dst
    for src; do
        [[ -e ${src} ]] || { print -u2 "${src} does not exist"; continue }
        dst=${src}
        vared dst
        [[ ${src} != ${dst} ]] && mkdir -p ${dst:h} && mv -n ${src} ${dst}
    done
}

# just type '...' to get '../..'
rationalise-dot() {
    local MATCH
    if [[ $LBUFFER =~ '(^|/| |  |'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}
zle -N rationalise-dot

fg-widget() {
    stty icanon echo -inlcr < /dev/tty
    stty lnext '^V' quit '^\' susp '^Z' < /dev/tty
    zle reset-prompt
    if jobs %- >/dev/null 2>&1; then
        fg %-
    else
        fg
    fi
}
zle -N fg-widget

# Widgets for changing current working directory.
redraw-prompt() {
    emulate -L zsh
    local f
    for f in chpwd $chpwd_functions precmd $precmd_functions; do
        (( $+functions[$f] )) && $f &>/dev/null
    done
    zle .reset-prompt
    zle -R
}

cd-rotate() {
    emulate -L zsh
    while (( $#dirstack )) && ! pushd -q $1 &>/dev/null; do
        popd -q $1
    done
    if (( $#dirstack )); then
        redraw-prompt
    fi
}
cd-back() { cd-rotate +1 }
cd-forward() { cd-rotate -0 }
zle -N cd-back
zle -N cd-forward

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}
zle -N magic-abbrev-expand

no-magic-abbrev-expand() { LBUFFER+=' ' }
zle -N no-magic-abbrev-expand

special-accept-line() {
    local line=$BUFFER
    if [[ $line == "../" || $line == ".." ]]; then
        cd "$line"
        redraw-prompt
        BUFFER=
    else
        zle accept-line
    fi
}
zle -N special-accept-line

expand-or-complete-with-dots() {
    echo -n "\e[36m··\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots

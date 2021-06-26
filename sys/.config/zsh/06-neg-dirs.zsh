if [[ ! -z "${HOME}" ]]; then
    local -U neg_dirs=("${HOME}"/{1st_level,dw,src/1st_level})
    for t in {1..$#neg_dirs}; do
        typeset -x "NEGCD[${t}]=$neg_dirs[${t}]"
        bindkey "^[${t}" negcd-${t}
        eval "negcd-$t() { cd \"${NEGCD[$t]}\" && redraw-prompt }"
        eval "zle -N negcd-$t"
    done
fi

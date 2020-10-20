local -U neg_dirs=(
    "${HOME}/1st_level"
    "${HOME}/dw"
    "${HOME}/src/1st_level"
    "${HOME}/src/wrk/infrastructure"
)
for t in {1..5}; export "NEGCD[${t}]=$neg_dirs[${t}]"
for t in {1..5}; bindkey "^[${t}" negcd-${t}
negcd-1() { cd "${NEGCD[1]}" && redraw-prompt }
negcd-2() { cd "${NEGCD[2]}" && redraw-prompt }
negcd-3() { cd "${NEGCD[3]}" && redraw-prompt }
negcd-4() { cd "${NEGCD[4]}" && redraw-prompt }
zle -N negcd-1
zle -N negcd-2
zle -N negcd-3
zle -N negcd-4

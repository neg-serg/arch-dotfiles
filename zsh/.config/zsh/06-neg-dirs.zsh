local -U neg_dirs=(
    "${HOME}/1st_level"
    "${HOME}/dw"
    "${HOME}/src/1st_level"
    "${HOME}/src/wrk/infrastructure"
)
for t in {1..5}; export "NEGCD${t}=$neg_dirs[${t}]"
for t in {1..5}; bindkey "^[${t}" negcd-${t}

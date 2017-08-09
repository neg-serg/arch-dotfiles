function :fuzzy-search-and-edit:get-files() {
    local directory="$1"
    local fifo="$2"

    cd "$directory"

    command grep -r -nEHI '[[:alnum:]]' "." --exclude-dir=".git" \
        | cut -b3- \
        | command sed -ru 's/^([^:]+:[^:]+):\s*(.*)/\x1b[35m\1\x1b[0m:  \2/' \
        > "$fifo"
}

function :fuzzy-search-and-edit:abort-job() {
    local match

    read -r match
    printf "%s\n" "${match}"

    async_flush_jobs ":fuzzy-search-and-edit:worker"
}

function fuzzy-search-and-edit() {
    local dir="$(mktemp --tmpdir -d fuzzy-search-and-edit.XXXXXX)"
    local fifo="${dir}/fifo"

    mkfifo "${fifo}"

    async_job ":fuzzy-search-and-edit:worker" \
        ":fuzzy-search-and-edit:get-files" "$(pwd)" "$fifo"

    local match=$(
        fzf +x --ansi -1 < "$fifo" \
            | :fuzzy-search-and-edit:abort-job
    )

    if [ "$match" ]; then
        local file
        local line

        IFS=: read -r file line _ <<< "$match"

        "${=EDITOR}" "$file" "+$line" < /dev/tty
    fi

    rm -r "$dir"

    zle -I
}

:fuzzy-search-and-edit:completed() {
    :
}

async_start_worker ":fuzzy-search-and-edit:worker"
async_register_callback ":fuzzy-search-and-edit:worker" \
    ":fuzzy-search-and-edit:completed"

zle -N fuzzy-search-and-edit

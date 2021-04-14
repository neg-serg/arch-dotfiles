select_items_command="todoist --namespace --project-namespace list | fzf | cut -d ' ' -f 1 | tr '\n' ' '"

insert-in-buffer() {
    if [ -n "$1" ]; then
        local new_left=""
        if [ -n "$LBUFFER" ]; then
            new_left="${new_left}${LBUFFER} "
        fi
        if [ -n "$2" ]; then
            new_left="${new_left}${2} "
        fi
        new_left="${new_left}$1"
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
}

fzf-todoist-item() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    insert-in-buffer $SELECTED_ITEMS
}
zle -N fzf-todoist-item
bindkey "^Xt" fzf-todoist-item

fzf-todoist-project() {
    local SELECTED_PROJECT="$(todoist --project-namespace projects | fzf | head -n1 | cut -d ' ' -f 1)"
    insert-in-buffer "${SELECTED_PROJECT}" "-P"
}
zle -N fzf-todoist-project
bindkey "^Xp" fzf-todoist-project

fzf-todoist-labels() {
    local SELECTED_LABELS="$(todoist labels | fzf | cut -d ' ' -f 1 | tr '\n' ',' | sed -e 's/,$//')"
    insert-in-buffer "${SELECTED_LABELS}" "-L"
}
zle -N fzf-todoist-labels
bindkey "^Xl" fzf-todoist-labels

todoist-exec-with-select-task() {
    if [ -n "$2" ]; then
        BUFFER="todoist $1 $(echo "$2" | tr '\n' ' ')"
        CURSOR=$#BUFFER
        zle accept-line
    fi
}

fzf-todoist-close() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    todoist-exec-with-select-task close $SELECTED_ITEMS
}
zle -N fzf-todoist-close
bindkey "^Xc" fzf-todoist-close

# todoist open
fzf-todoist-open() {
    local SELECTED_ITEMS="$(eval ${select_items_command})"
    todoist-exec-with-select-task "show --browse" $SELECTED_ITEMS
}
zle -N fzf-todoist-open
bindkey "^Xo" fzf-todoist-open

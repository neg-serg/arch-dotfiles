# delete's a block between two characters
delete-in() {
    local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT
    read -k CHAR
    if [[ $CHAR == "w" ]];then
        zle vi-backward-word
        LSEARCH=$CURSOR
        zle vi-forward-word
        RSEARCH=$CURSOR
        RBUFFER="$BUFFER[$RSEARCH+1,${#BUFFER}]"
        LBUFFER="$LBUFFER[1,$LSEARCH]"
        return
    elif [[ $CHAR == "(" ]] || [[ $CHAR == ")" ]];then
        LCHAR="("
        RCHAR=")"
    elif [[ $CHAR == "[" ]] || [[ $CHAR == "]" ]];then
        LCHAR="["
        RCHAR="]"
    elif [[ $CHAR == "{" ]] || [[ $CHAR == "}" ]];then
        LCHAR="{"
        RCHAR="}"
    else
        LSEARCH=${#LBUFFER}
        while [[ $LSEARCH -gt 0 ]] && [[ "$LBUFFER[$LSEARCH]" != "$CHAR" ]]; do
            (( LSEARCH = $LSEARCH - 1 ))
        done
        RSEARCH=0
        while [[ $RSEARCH -lt (( ${#RBUFFER} + 1 )) ]] && [[ "$RBUFFER[$RSEARCH]" != "$CHAR" ]]; do
            (( RSEARCH = $RSEARCH + 1 ))
        done
        RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
        LBUFFER="$LBUFFER[1,$LSEARCH]"
        return
    fi
    COUNT=1
    LSEARCH=${#LBUFFER}
    while [[ $LSEARCH -gt 0 ]] && [[ $COUNT -gt 0 ]]; do
        (( LSEARCH = $LSEARCH - 1 ))
        if [[ $LBUFFER[$LSEARCH] == "$RCHAR" ]];then
            (( COUNT = $COUNT + 1 ))
        fi
        if [[ $LBUFFER[$LSEARCH] == "$LCHAR" ]];then
            (( COUNT = $COUNT - 1 ))
        fi
    done
    COUNT=1
    RSEARCH=0
    while [[ $RSEARCH -lt (( ${#RBUFFER} + 1 )) ]] && [[ $COUNT -gt 0 ]]; do
        (( RSEARCH = $RSEARCH + 1 ))
        if [[ $RBUFFER[$RSEARCH] == "$LCHAR" ]];then
            (( COUNT = $COUNT + 1 ))
        fi
        if [[ $RBUFFER[$RSEARCH] == "$RCHAR" ]];then
            (( COUNT = $COUNT - 1 ))
        fi
    done
    RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"
}
zle -N delete-in

change-in() {
    zle delete-in
    zle vi-insert
}
zle -N change-in

delete-around() {
    zle delete-in
    zle vi-backward-char
    zle vi-delete-char
    zle vi-delete-char
}
zle -N delete-around

change-around() {
    zle delete-in
    zle vi-backward-char
    zle vi-delete-char
    zle vi-delete-char
    zle vi-insert
}
zle -N change-around

bindkey -M vicmd ' ' execute-named-cmd # Space for command line mode
bindkey -M vicmd 'H' run-help
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M vicmd "ga"     what-cursor-position
bindkey -M vicmd "g~"     vi-oper-swap-case

bindkey -M vicmd "di"     delete-in
bindkey -M vicmd "ci"     change-in
bindkey -M vicmd "da"     delete-around
bindkey -M vicmd "ca"     delete-around

bindkey -M vicmd  "^J"    down-line-or-history
bindkey -M vicmd  "^K"    up-line-or-history
bindkey -M vicmd  "="     list-choices
bindkey -M vicmd  "^D"    list-choices
bindkey -M vicmd  "^R"    history-incremental-search-backward
bindkey -M vicmd  "k"     up-line-or-history
bindkey -M vicmd  "+"     vi-down-line-or-history
bindkey -M vicmd  "G"     vi-fetch-history
bindkey -M vicmd  "F"     vi-find-prev-char
bindkey -M vicmd  "T"     vi-find-prev-char-skip

bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '\ef'   forward-word                      # Alt-f
bindkey -M vicmd '\eb'   backward-word                     # Alt-b
bindkey -M vicmd '\ed'   kill-word                         # Alt-d
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDo

# add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey -M viins '^s' history-incremental-search-backward
bindkey -M vicmd '^s' history-incremental-search-backward

# Another Esc key.
bindkey -M viins '\C-@' vi-cmd-mode
bindkey -M vicmd '\C-@' vi-cmd-mode

# to delete characters beyond the starting point of the current insertion.
bindkey -M viins '\C-h' backward-delete-char
bindkey -M viins '\C-w' backward-kill-word
bindkey -M viins '\C-u' backward-kill-line

# undo/redo more than once.
bindkey -M vicmd 'u' undo
bindkey -M vicmd '\C-r' redo

# history
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M vicmd '^[k' history-beginning-search-backward
bindkey -M vicmd '^[j' history-beginning-search-forward
bindkey -M vicmd 'gg' beginning-of-history

# modification
bindkey -M vicmd 'gu' down-case-word
bindkey -M vicmd 'gU' up-case-word
bindkey -M vicmd 'g~' vi-oper-swap-case

bindkey -M vicmd '\C-t' transpose-chars
bindkey -M viins '\C-t' transpose-chars
bindkey -M vicmd '^[t' transpose-words
bindkey -M viins '^[t' transpose-words

bindkey -M viins "k" up-line-or-history
bindkey -M viins "j" down-line-or-history

# Disable - the default binding _history-complete-older is very annoying
# whenever I begin to search with the same key sequence.
bindkey -M viins -r '^[/'

# Experimental: Alternate keys to the original bindings.
bindkey -M viins '^[,' _history-complete-newer
bindkey -M viins '^[.' _history-complete-older

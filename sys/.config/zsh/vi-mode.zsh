bindkey -v

visual-mode-eol () {
    zle visual-mode;
    CURSOR=${#BUFFER};
}

prev-line-with-sudo () {
    BUFFER="sudo $(fc -lnrm "$1*" 1 2>/dev/null | head -n 1)"
    CURSOR=${#BUFFER};
}

vi-join-prev-history-line () {
    BUFFER="$(fc -lnrm "$1*" 1 2>/dev/null | head -n 1) && $BUFFER"
}

accept-twice () {
    accept-line
    accept-line
}

zle -N visual-mode-eol
zle -N prev-line-with-sudo
zle -N vi-join-prev-history-line
zle -N accept-twice

#todo: find a good binding for spell-word
#todo: find a good binding for quote-region
#Bindings left: ^Z^T^Y^O
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^K'    insert-last-word
bindkey -M viins '^S'    prev-line-with-sudo
bindkey -M viins '^J'    vi-join-prev-history-line
bindkey -M viins '^F'    emacs-forward-word
bindkey -M viins '^B'    emacs-backward-word
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^[[H'  beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^[[F'  end-of-line
bindkey -M viins "^N"    expand-or-complete
bindkey -M viins "^P"    reverse-menu-complete
bindkey -M vicmd 'gg'    beginning-of-buffer-or-history
bindkey -M vicmd 'g~'    vi-oper-swap-case
bindkey -M vicmd 'G'     end-of-buffer-or-history
bindkey -M vicmd 'Y'     vi-yank-eol
bindkey -M vicmd 'vv'    visual-line-mode
bindkey -M vicmd 'V'     visual-mode-eol
bindkey -M vicmd 'u'     undo
bindkey -M vicmd 'U'     redo
bindkey -M vicmd 'H'     run-help
bindkey -M vicmd 'dl'    delete-char
bindkey -M vicmd "^[[A"  up-line-or-search
bindkey -M vicmd "^[[B"  down-line-or-search
bindkey -M viins "^[[A"  up-line-or-search
bindkey -M viins "^[[B"  down-line-or-search
# / can't be in WORDCHARS otherwise backward-kill-word will kill whole paths
WORDCHARS=${WORDCHARS//\/}
bindkey -M viins "^W"    backward-kill-word
# ^[[3~ is the "del" key
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char
bindkey -M menuselect "^Y" accept-and-menu-complete
bindkey -M menuselect "^E" send-break
bindkey -M menuselect "^[" vi-cmd-mode
bindkey -M menuselect "^M" accept-twice

# Surrouding operators !
autoload -U select-quoted select-bracketed surround
zle -N select-quoted
zle -N select-bracketed
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

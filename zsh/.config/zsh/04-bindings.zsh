bindkey -e

bindkey "^[-" z4h-cd-forward
bindkey "^[=" z4h-cd-back

autoload up-line-or-beginning-search 
zle -N up-line-or-beginning-search
autoload down-line-or-beginning-search 
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey . rationalise-dot
bindkey "^XD" describe-key-briefly
bindkey "^Z" fg-widget
bindkey '^j' fasd-complete
bindkey "^I" expand-or-complete-with-dots
bindkey '^M' special-accept-line
bindkey " "             magic-space
bindkey ",."            zleiab
bindkey . rationalise-dot
bindkey -M isearch . self-insert # without this, typing a . aborts incremental history search
zle -N inplace_mk_dirs && bindkey '^xM' inplace_mk_dirs # load the lookup subsystem if it's available on the system

bindkey -M menuselect '^o'    accept-and-infer-next-history
bindkey -M menuselect 'h'     vi-backward-char
bindkey -M menuselect 'j'     vi-down-line-or-history
bindkey -M menuselect 'k'     vi-up-line-or-history
bindkey -M menuselect 'l'     vi-forward-char
bindkey -M menuselect 'i'     accept-and-menu-complete
bindkey -M menuselect 'o'     accept-and-infer-next-history
bindkey -M menuselect '\e^M'  accept-and-menu-complete

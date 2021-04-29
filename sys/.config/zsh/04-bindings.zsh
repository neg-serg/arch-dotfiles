bindkey -e
bindkey "^[-" cd-forward
bindkey "^[=" cd-back
autoload up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search
bindkey " " magic-abbrev-expand
bindkey . rationalise-dot
bindkey "^xD" describe-key-briefly
bindkey "^z" fg-widget
bindkey '^J' fasd-complete
bindkey '^@' fasd-complete
bindkey "^i" expand-or-complete-with-dots
bindkey '^m' special-accept-line
bindkey " "  magic-space
bindkey ",." zleiab
bindkey . rationalise-dot
bindkey -M isearch . self-insert # without this, typing a . aborts incremental history search
zle -N inplace_mk_dirs && bindkey '^xM' inplace_mk_dirs # load the lookup subsystem if it's available on the system
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect 'i' accept-and-menu-complete
bindkey -M menuselect 'o' accept-and-infer-next-history
bindkey -M menuselect '\e^M' accept-and-menu-complete
bindkey '^[[1;3D' _nothing
bindkey '^[[1;3C' _nothing
bindkey '^[[1;5A' _nothing
bindkey '^[[1;5B' _nothing

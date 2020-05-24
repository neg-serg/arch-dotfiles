bindkey -e
zmodload -i zsh/parameter

bindkey "^[-" z4h-cd-forward
bindkey "^[=" z4h-cd-back

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

bindkey . rationalise-dot

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey " "             magic-space
bindkey ",."            zleiab

bindkey -M menuselect '^o'    accept-and-infer-next-history
bindkey -M menuselect 'h'     vi-backward-char
bindkey -M menuselect 'j'     vi-down-line-or-history
bindkey -M menuselect 'k'     vi-up-line-or-history
bindkey -M menuselect 'l'     vi-forward-char
bindkey -M menuselect 'i'     accept-and-menu-complete
bindkey -M menuselect "+"     accept-and-menu-complete
bindkey -M menuselect "^[[2~" accept-and-menu-complete
bindkey -M menuselect 'o'     accept-and-infer-next-history
bindkey -M menuselect '\e^M'  accept-and-menu-complete

bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

# load the lookup subsystem if it's available on the system
zle -N inplace_mk_dirs && bindkey '^xM' inplace_mk_dirs

bindkey -M emacs "^XD" describe-key-briefly
bindkey -M emacs "^Z" fg-widget
bindkey -M vicmd "^Z" fg-widget
bindkey -M viins "^Z" fg-widget

negcd-1() { cd ~/1st_level && z4h-redraw-prompt }
negcd-2() { cd ~/dw && z4h-redraw-prompt }
negcd-3() { cd ~/src/1st_level && z4h-redraw-prompt }
negcd-4() { cd ~/src/wrk/infrastructure && z4h-redraw-prompt }

zle -N negcd-1
zle -N negcd-2
zle -N negcd-3
zle -N negcd-4

bindkey '^[1' negcd-1
bindkey '^[2' negcd-2
bindkey '^[3' negcd-3
bindkey '^[4' negcd-4
bindkey '^[5' negcd-5

bindkey -M emacs "^[w"  vi-cmd-mode
bindkey -M emacs "^X^F" vi-find-next-char
bindkey '^j' fasd-complete

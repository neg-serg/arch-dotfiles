autoload -Uz zleiab
zle -N zleiab
autoload -Uz inplace_mk_dirs
autoload -Uz imv
autoload -Uz rationalise-dot
zle -N rationalise-dot
autoload -Uz fg-widget
zle -N fg-widget
autoload -Uz redraw-prompt
autoload -Uz cd-rotate
cd-back() { cd-rotate +1 }
cd-forward() { cd-rotate -0 }
zle -N cd-back
zle -N cd-forward
autoload -Uz magic-abbrev-expand
zle -N magic-abbrev-expand
no-magic-abbrev-expand() { LBUFFER+=' ' }
zle -N no-magic-abbrev-expand
autoload -Uz special-accept-line
zle -N special-accept-line
autoload -Uz expand-or-complete-with-dots
zle -N expand-or-complete-with-dots

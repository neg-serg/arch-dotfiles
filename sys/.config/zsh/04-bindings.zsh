bindings_init(){
    bindkey -e

    typeset -gx KEYTIMEOUT=10

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
    _nothing() {}
    zle -N _nothing

    bindkey "^[" zvm_readkeys_handler
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

    source "${ZDOTDIR}/06-neg-dirs.zsh"

    -z4h-cursor-show() { [[ -t 1 ]] && echoti cnorm || echoti cnorm >"$TTY" }

    autoload -Uz -- '-z4h-move-and-kill'
    autoload -Uz -- 'z4h-forward-word'
    autoload -Uz -- 'z4h-forward-zword'
    autoload -Uz -- 'z4h-backward-word'
    autoload -Uz -- 'z4h-backward-zword'
    autoload -Uz -- 'z4h-fzf-complete'

    autoload -Uz -- '-z4h-comp-files'
    autoload -Uz -- '-z4h-comp-words'
    autoload -Uz -- '-z4h-cursor-hide'
    autoload -Uz -- '-z4h-cursor-show'
    autoload -Uz -- '-z4h-get-cursor-pos'
    autoload -Uz -- '-z4h-main-complete'
    autoload -Uz -- '-z4h-sanitize-word-prefix'
    autoload -Uz -- '-z4h-set-list-colors'
    autoload -Uz -- '-z4h-show-dots'
    autoload -Uz -- '-z4h-insert-all'

    z4h-kill-word() { -z4h-move-and-kill z4h-forward-word }
    z4h-backward-kill-word() { -z4h-move-and-kill z4h-backward-word  }
    z4h-kill-zword() { -z4h-move-and-kill z4h-forward-zword  }
    z4h-backward-kill-zword() { -z4h-move-and-kill z4h-backward-zword }

    zle -N z4h-expand
    zle -N z4h-forward-word
    zle -N z4h-kill-word
    zle -N z4h-backward-word
    zle -N z4h-backward-kill-word
    zle -N z4h-forward-zword
    zle -N z4h-kill-zword
    zle -N z4h-backward-zword
    zle -N z4h-backward-kill-zword

    zle -N z4h-fzf-complete
    zle -N z4h-fzf-history
    zle -N z4h-fzf-dir-history

    bindkey   '^[d'     z4h-kill-word                  # alt+d
    bindkey   '^[D'     z4h-kill-word                  # alt+D
    bindkey   '^[[3;5~' z4h-kill-word                  # ctrl+del
    bindkey   '^[[3;3~' z4h-kill-word                  # alt+del
    # Delete previous word.
    bindkey   '^W'      z4h-backward-kill-word         # ctrl+w
    bindkey   '^[^?'    z4h-backward-kill-word         # alt+bs
    bindkey   '^[^H'    z4h-backward-kill-word         # ctrl+alt+bs

    bindkey '^W' z4h-fzf-complete      # ctrl+w

    zle -C -- -z4h-comp-insert-all complete-word -z4h-comp-insert-all
}
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
zvm_after_init_commands=(bindings_init)

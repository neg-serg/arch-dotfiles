#!/usr/bin/zsh

bindkey -e

zmodload -i zsh/parameter
insert-last-command-output() {
    LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output

#k# Kill left-side word or everything up to next slash
bindkey '\ev' slash-backward-kill-word

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

bindkey "^[+" up-one-dir
bindkey "^[=" back-one-dir

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

zle -N grep2awk
bindkey '^X^Y' grep2awk

bindkey . rationalise-dot

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey '\ei' menu-complete  # menu completion via esc-i

# do history expansion on space
bindkey " "             magic-space
bindkey ",."            zleiab

bindkey -M emacs "^[w"  vi-cmd-mode
bindkey -M emacs "^X^F" vi-find-next-char

# accept a completion and try to complete again by using menu
# completion; very useful with completing directories
# by using 'undo' one's got a simple file browser
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect 'h'     vi-backward-char                
bindkey -M menuselect 'j'     vi-down-line-or-history         
bindkey -M menuselect 'k'     vi-up-line-or-history           
bindkey -M menuselect 'l'     vi-forward-char                 
bindkey -M menuselect 'i'     accept-and-menu-complete
bindkey -M menuselect "+"     accept-and-menu-complete
bindkey -M menuselect "^[[2~" accept-and-menu-complete
bindkey -M menuselect 'o'     accept-and-infer-next-history
bindkey -M menuselect '\e^M'  accept-and-menu-complete
# also use + and INSERT since it's easier to press repeatedly

bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

# load the lookup subsystem if it's available on the system
zrcautoload lookupinit && lookupinit
zle -N inplace_mk_dirs && bindkey '^xM' inplace_mk_dirs

bindkey -M emacs "^XD" describe-key-briefly
bindkey -M emacs "^Z" fg-widget
bindkey -M vicmd "^Z" fg-widget
bindkey -M viins "^Z" fg-widget

bindkey -s "c" ' cd -'     # A-c to do cycle throw last directory

bindkey "i" fasd-complete      # A-i to do ls++ alias
bindkey '^X^A' fasd-complete     # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f   # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d   # C-x C-d to do fasd-complete-d (only directories)

bindkey '^X^X' copy-to-clipboard

local jump_dirs=( ~/1st_level ~/dw ~/tmp ~/src/1st_level ~/vid/new)

for index in $(seq 1 $((${#jump_dirs[@]} ))); do
    bindkey -s "${index}" "cd ${jump_dirs[$index]/${HOME}/~}"
done

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

zle     -N    foc
bindkey '\ei' foc

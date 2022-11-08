# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
[[ -z "${HOME}/src/1st_level/pacaur" ]] && mkdir -p "${HOME}/src/1st_level/pacaur"
typeset -gx WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '
typeset -gx KEYTIMEOUT=6
typeset -gx ESCDELAY=1
typeset -gx FZF_DEFAULT_OPTS="
--color=bg+:#000000,bg:#000000,spinner:#3f5876,hl:#546c8a
--color=fg:#4f5d78,header:#4779B3,info:#3f5876,pointer:#005faf
--color=marker:#04141C,fg+:#8DA6B2,prompt:#005faf,hl+:#005faf
--info=inline
--multi
--prompt='❯> ' --pointer='•' --marker='✓'
--bind 'ctrl-space:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | xclip -i)'
--bind 'ctrl-t:accept'
--bind 'tab:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'ctrl-j:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'alt-d:change-prompt(Directories> )+reload(fd . -t d)'
--bind 'alt-f:change-prompt(Files> )+reload(fd . -t f)'
--bind 'ctrl-v:execute(echo {+} | xargs -o nvim)'"
typeset -gx FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
typeset -gx FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
typeset -gx FZF_COMPLETION_TRIGGER='~~'
[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }

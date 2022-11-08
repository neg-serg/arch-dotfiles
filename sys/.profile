export PATH=/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin
unset SSH_ASKPASS
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
export INPUTRC=${XDG_CONFIG_HOME}/inputrc
export BROWSER="firefox"
export EXA_COLORS="da=00;38;5;250:uu=0:gu=0"
export LS_COLORS GREP_COLORS
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '
export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export STEAM_RUNTIME=1
export FZF_DEFAULT_OPTS="
--color=bg+:#184454,bg:#000000,spinner:#395573,hl:#4779B3
--color=fg:#617287,header:#4779B3,info:#2b768d,pointer:#395573
--color=marker:#395573,fg+:#e5ebf1,prompt:#2b768d,hl+:#4779B3
--info=inline
--multi
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind 'ctrl-space:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | xclip -i)'
--bind 'ctrl-t:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'ctrl-j:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'ctrl-v:execute(echo {+} | xargs -o nvim)'"
export FZF_TMUX=1
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

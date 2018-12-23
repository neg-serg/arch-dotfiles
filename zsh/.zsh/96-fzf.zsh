export SKIM_DEFAULT_OPTIONS="${SKIM_DEFAULT_OPTS} --color=16 --ansi --tabstop=4 "
export SKIM_DEFAULT_COMMAND='rg --files --hidden --follow -g'

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"
export FZF_TMUX=1

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

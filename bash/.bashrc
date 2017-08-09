PS1="┌─[ \[\e[34;1m\]\w\[;\e[0m\] ]\n└─╼ "
export HISTCONTROL=erasedups:ignorespace
export HISTIGNORE="&:pwd:cd:~:[bf]g:history *:l:l[wsla]:lla:exit:\:q"

source ~/.shrc

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -s "/home/neg/.scm_breeze/scm_breeze.sh" ] && source "/home/neg/.scm_breeze/scm_breeze.sh"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

path_dirs=(
    /usr/bin
    ${HOME}/bin
    {/usr/local,}/{s,}bin
	/usr/bin/{site,vendor,core}_perl
    /opt/go/bin
    /home/neg/.cargo/bin
)
export PATH=${(j_:_)path_dirs}

for q in nvim vim vis vi;
    { [[ -n ${commands}[(I)${q}] ]] \
    && export EDITOR=${q}; break }

if which nvimpager >/dev/null; then
    export PAGER="nvimpager"
fi

for q in nvim vim vis vi; {
    [[ -n ${commands}[(I)${q}] ]] && export VISUAL=${q}; break 
}

alias less=${PAGER}
alias zless=${PAGER}

export LESSCHARSET=UTF-8
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)" # begin blinking
export LESS_TERMCAP_md="$(tput bold)"               # begin bold
export LESS_TERMCAP_me="$(tput sgr0)"               # end mode
export LESS_TERMCAP_so="$(tput bold; tput setaf 6)" # begin standout - info box
export LESS_TERMCAP_se="$(tput sgr0)"               # end standout
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)" # begin underline
export LESS_TERMCAP_ue="$(tput sgr0)"               # end underline

export HISTFILE=${ZDOTDIR}/zsh_history
export SAVEHIST=100000 # useful for setopt append_history
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"
export HISTCONTROL=ignoreboth:erasedups # ignoreboth (= ignoredups + ignorespace)

export TIMEFMT="[37m[34m⟬[37m[37m%J[34m⟭[39m[34m⟬[37m%U[34m⟭[39m[34m⟬[37muser %S[34m⟭[39m[34m⟬[37msystem %P[34m⟭[39m[34m⟬[37mcpu %*E total[34m⟭[39m[34m[39m[34m⟬[37mMem: %M kb max[34m⟭[39m"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export LS_COLORS
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

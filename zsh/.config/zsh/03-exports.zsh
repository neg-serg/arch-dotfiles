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

export HISTFILE=${ZDOTDIR}/zsh_history
export SAVEHIST=100000 # useful for setopt append_history
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"
export HISTCONTROL=ignoreboth:erasedups # ignoreboth (= ignoredups + ignorespace)

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie

export TIMEFMT="[37m[34m⟬[37m[37m%J[34m⟭[39m[34m⟬[37m%U[34m⟭[39m[34m⟬[37muser %S[34m⟭[39m[34m⟬[37msystem %P[34m⟭[39m[34m⟬[37mcpu %*E total[34m⟭[39m[34m[39m[34m⟬[37mMem: %M kb max[34m⟭[39m"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export LS_COLORS
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

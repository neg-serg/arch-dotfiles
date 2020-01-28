source "${ZDOTDIR}/03-helpers.zsh"
source "${ZDOTDIR}/03-xdg_vars.zsh"

path_dirs=(
    /usr/bin
    ${HOME}/bin
    {/usr/local,}/{s,}bin
	/usr/bin/{site,vendor,core}_perl
    /opt/go/bin
    /home/neg/.cargo/bin
)

whence ruby >/dev/null && \
    path_dirs+=$($(whence ruby) -e 'puts Gem.user_dir')/bin

export PATH=${(j_:_)path_dirs}

unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export AURDEST=$(readlink -f "${HOME}/tmp/pacaur")

export PYTHONIOENCODING='utf-8'
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

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

export INPUTRC="${XDG_CONFIG_HOME}/inputrc"
export BROWSER="firefox"

export VAGRANT_HOME="/zero/vagrant"
export PERLBREW_ROOT=${HOME}/.perl5

export LESSCHARSET=UTF-8
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)" # begin blinking
export LESS_TERMCAP_md="$(tput bold)"               # begin bold
export LESS_TERMCAP_me="$(tput sgr0)"               # end mode
export LESS_TERMCAP_so="$(tput bold; tput setaf 6)" # begin standout - info box
export LESS_TERMCAP_se="$(tput sgr0)"               # end standout
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)" # begin underline
export LESS_TERMCAP_ue="$(tput sgr0)"               # end underline

export TEXINPUTS=".:${XDG_DATA_HOME}/texmf//:"

export HISTFILE=${ZDOTDIR}/zsh_history
export SAVEHIST=100000 # useful for setopt append_history
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"
export HISTCONTROL=ignoreboth:erasedups # ignoreboth (= ignoredups + ignorespace)

local -a timefmt_=(
    "$(zwrap "$(zfwrap "%J")")"
    "$(zwrap "%U")"
    "$(zwrap "user %S")"
    "$(zwrap "system %P")"
    "$(zwrap "cpu %*E total")"
    "$(zwrap "-||-")"
    "$(zwrap "Mem: %M kb max")"
)
export TIMEFMT="${timefmt_[@]}"
export COLORTERM="yes"
export LS_COLORS
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=/opt/go
export GOMAXPROCS=8
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export OSSLIBDIR=/usr/lib/oss

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"

(( 0 != 0 )) && {
    if which drip > /dev/null 2>&1; then
        export DRIP_SHUTDOWN=30
        export JAVACMD=$(which drip)
    fi
}

export PULSE_LATENCY_MSEC=60
export STEAM_RUNTIME=1
export AUTOPAIR_INHIBIT_INIT=1

(){
    local _home="/mnt/home"
    local _dev="/one/dev"
    hash -d q=${_dev}
    hash -d d="${_home}/doc"
    hash -d torrent="${_home}/torrent"
    hash -d v="${_home}/vid/new"
    hash -d {z,s}="${_dev}/src"
    hash -d p='/home/neg/pic'
}

export QT_QPA_PLATFORMTHEME="qt5ct"

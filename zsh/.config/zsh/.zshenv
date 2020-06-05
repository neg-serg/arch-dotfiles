# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DOWNLOAD_DIR="$HOME/dw"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_DESKTOP_DIR="$HOME/.local/desktop"
export XDG_TEMPLATES_DIR="$HOME/1st_level/templates"
export XDG_DOCUMENTS_DIR="$HOME/doc/"
export XDG_PICTURES_DIR="$HOME/pic"
export XDG_VIDEOS_DIR="$HOME/vid"
export XDG_PUBLICSHARE_DIR="$HOME/1st_level/upload/share"
export XINITRC="$XDG_CONFIG_HOME"/xinit/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/xinit/xserverrc

[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }

export XDG_CURRENT_DESKTOP="KDE"
export KDE_SESSION_VERSION="5"

unset SSH_ASKPASS

export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

export BROWSER="firefox"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

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

export MPV_HOME="${XDG_CONFIG_HOME}/mpv"
export KEYTIMEOUT=5
export ESCDELAY=1
export GOPATH=/opt/go
export STEAM_RUNTIME=1
export QT_QPA_PLATFORMTHEME="qt5ct"
export AURDEST=$(readlink -f "${HOME}/tmp/pacaur")

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on
-Dswing.aatext=true
-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
-Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
export TASKDATA="$XDG_DATA_HOME"/task
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc

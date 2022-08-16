# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
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
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export RUSTC_WRAPPER=sccache
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export PYLINTHOME="$XDG_CONFIG_HOME"/pylint
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export QT_QPA_PLATFORMTHEME="qt5ct"
export MPV_HOME="${XDG_CONFIG_HOME}/mpv"
export GOPATH=/opt/go
[[ -z "${HOME}/src/1st_level/pacaur" ]] && mkdir -p "${HOME}/src/1st_level/pacaur"
export AURDEST=$(realpath "${HOME}/src/1st_level/pacaur")
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
export BROWSER="firefox"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '
export KEYTIMEOUT=6
export ESCDELAY=1
if [[ ! $TMUX =~ ".*nwim.*" ]]; then
    export FZF_TMUX=1
else
    export FZF_TMUX=0
fi
export FZF_DEFAULT_OPTS="
--color=bg+:#000000,bg:#000000,spinner:#3f5876,hl:#546c8a
--color=fg:#4f5d78,header:#4779B3,info:#3f5876,pointer:#005faf
--color=marker:#04141C,fg+:#8DA6B2,prompt:#005faf,hl+:#005faf
--info=inline
--multi
--prompt='❯> ' --pointer='•' --marker='✓'
--bind 'ctrl-space:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | xclip -i)'
--bind 'ctrl-t:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'ctrl-j:execute(echo {+} | xargs -o ~/bin/v)+abort'
--bind 'ctrl-v:execute(echo {+} | xargs -o nvim)'"
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_COMPLETION_TRIGGER='~~'
[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }
export LIBSEAT_BACKEND=logind
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export DISPLAY=:0

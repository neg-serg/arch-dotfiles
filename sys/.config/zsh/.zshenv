# Skip the not really helping Ubuntu global compinit
skip_global_compinit=1
typeset -gx ZDOTDIR="$XDG_CONFIG_HOME/zsh"
typeset -gx XDG_CONFIG_HOME="$HOME/.config"
typeset -gx XDG_STATE_HOME="$HOME/.local/state"
typeset -gx XDG_DATA_HOME="$HOME/.local/share"
typeset -gx XDG_CACHE_HOME="$HOME/.cache"
typeset -gx XDG_DOWNLOAD_DIR="$HOME/dw"
typeset -gx XDG_MUSIC_DIR="$HOME/music"
typeset -gx XDG_DESKTOP_DIR="$HOME/.local/desktop"
typeset -gx XDG_TEMPLATES_DIR="$HOME/1st_level/templates"
typeset -gx XDG_DOCUMENTS_DIR="$HOME/doc/"
typeset -gx XDG_PICTURES_DIR="$HOME/pic"
typeset -gx XDG_VIDEOS_DIR="$HOME/vid"
typeset -gx XDG_PUBLICSHARE_DIR="$HOME/1st_level/upload/share"
typeset -gx XINITRC="$XDG_CONFIG_HOME"/xinit/xinitrc
typeset -gx XSERVERRC="$XDG_CONFIG_HOME"/xinit/xserverrc
typeset -gx CARGO_HOME="$XDG_DATA_HOME"/cargo
typeset -gx CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
typeset -gx CCACHE_DIR="$XDG_CACHE_HOME"/ccache
typeset -gx RUSTC_WRAPPER=sccache
typeset -gx GHCUP_USE_XDG_DIRS=true
typeset -gx HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
typeset -gx NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
typeset -gx NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
typeset -gx WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
typeset -gx PYLINTHOME="$XDG_CONFIG_HOME"/pylint
typeset -gx XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
typeset -gx GNUPGHOME="$XDG_DATA_HOME"/gnupg
typeset -gx PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
typeset -gx QT_QPA_PLATFORMTHEME="qt5ct"
typeset -gx MPV_HOME="${XDG_CONFIG_HOME}/mpv"
typeset -gx GOPATH=/opt/go
[[ -z "${HOME}/src/1st_level/pacaur" ]] && mkdir -p "${HOME}/src/1st_level/pacaur"
typeset -gx AURDEST=$(realpath "${HOME}/src/1st_level/pacaur")
typeset -gx GREP_COLOR='37;45'
typeset -gx GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
typeset -gx BROWSER="firefox"
typeset -gx WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '
typeset -gx KEYTIMEOUT=6
typeset -gx ESCDELAY=1
if [[ ! $TMUX =~ ".*nwim.*" ]]; then
    typeset -gx FZF_TMUX=1
else
    typeset -gx FZF_TMUX=0
fi
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
typeset -gx LIBSEAT_BACKEND=logind
typeset -gx XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
typeset -gx XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
typeset -gx _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
typeset -gx TERMINFO="$XDG_DATA_HOME"/terminfo
typeset -gx TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
typeset -gx DISPLAY=:0

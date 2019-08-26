[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }

export XDG_VTNR=1
systemctl --user set-environment XDG_VTNR=1

export ZSHDIR=${HOME}/.zsh
export BIN_HOME=${HOME}/bin
export SCRIPT_HOME=${BIN_HOME}/scripts

export PATH="${PATH}:${HOME}/.rvm/bin"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DOWNLOAD_DIR="${HOME}/dw"
export XDG_MUSIC_DIR="${HOME}/music"
export XDG_DESKTOP_DIR="${HOME}/.local/desktop"
export XDG_TEMPLATES_DIR="${HOME}/1st_level/templates"
export XDG_DOCUMENTS_DIR="${HOME}/doc/"
export XDG_PICTURES_DIR="${HOME}/pic"
export XDG_VIDEOS_DIR="${HOME}/vid"
export XDG_PUBLICSHARE_DIR="${HOME}/1st_level/upload/share"

unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export PYTHONIOENCODING='utf-8'
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

export VISUAL="oni"

export INPUTRC=${XDG_CONFIG_HOME}/inputrc

export BROWSER="waterfox"

export NCURSES_ASSUMED_COLORS=3,0
export NCURSES_NO_MAGIC_COOKIES=1
export NCURSES_NO_PADDING=1

export LESSCHARSET=UTF-8

export COLORTERM="yes"

export LS_COLORS GREP_COLORS
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOMAXPROCS=8
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export PULSE_LATENCY_MSEC=60

export SXHKD_FIFO="/tmp/sxhkd_fifo"
export SXHKD_SHELL="zsh"

_gen_fzf_default_opts() {
    local color01="$(xrescat color215)"
    local color04="$(xrescat color15)"
    local color06="#e5ebf1"
    local color0A="$(xrescat color22)"
    local color0C="$(xrescat color4)"
    local color0D="$(xrescat color12)"

    export FZF_DEFAULT_OPTS="--color=bg+:${color01},bg:#000000,spinner:${color0C},hl:${color0D} --color=fg:${color04},header:${color0D},info:${color0A},pointer:${color0C} --color=marker:${color0C},fg+:${color06},prompt:${color0A},hl+:${color0D}"
}

_gen_fzf_default_opts

export FZF_TMUX=1

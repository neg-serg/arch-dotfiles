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

export BROWSER="firefox"

export ACKRC="${XDG_CONFIG_HOME}/ackrc"
export GIMP2_DIRECTORY=${XDG_CONFIG_HOME}/gimp-2.8
export CLIVE_CONFIG="${XDG_CONFIG_HOME}/cliverc"

export VAGRANT_HOME="/mnt/home/vagrant"

export NCURSES_ASSUMED_COLORS=3,0
export NCURSES_NO_MAGIC_COOKIES=1
export NCURSES_NO_PADDING=1

export PERLBREW_ROOT=${HOME}/.perl5

export X_OSD_COLOR='#00ffff'

export LESSCHARSET=UTF-8

export PWS="${XDG_DATA_HOME}/safe/pws"
export TEXINPUTS=".:${XDG_DATA_HOME}/texmf//:"

export COLORTERM="yes"

export ACK_COLOR_MATCH="cyan bold"
export ACK_COLOR_FILENAME="cyan bold on_black"
export ACK_COLOR_LINENO="bold green"
export LS_COLORS GREP_COLORS

export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

# dirstack handling
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${HOME}/.zsh/.99-zdirs

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=${HOME}/bin/go
export GOMAXPROCS=8
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"

export PULSE_LATENCY_MSEC=60
export NVIM_TUI_ENABLE_TRUE_COLOR=0

export STEAM_RUNTIME=1

export SXHKD_FIFO="/tmp/sxhkd_fifo"
export SXHKD_SHELL="zsh"

export VIDEO_PLAYER_="mpv"

export AUTOPAIR_INHIBIT_INIT=1

source ~/.zsh/00-common.zsh
source ~/.zsh/03-xdg_vars.zsh

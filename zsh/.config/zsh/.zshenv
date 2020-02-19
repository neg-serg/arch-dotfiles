export SHELL=zsh

[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export XDG_VTNR=1
systemctl --user set-environment XDG_VTNR=1

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

export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

export BROWSER="firefox"
export LESSCHARSET=UTF-8
export COLORTERM="yes"
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export VAGRANT_HOME="/zero/vagrant"
export PERLBREW_ROOT=${HOME}/.perl5

export MPV_HOME="${XDG_CONFIG_HOME}/mpv"
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export GOPATH=/opt/go
export STEAM_RUNTIME=1
export AUTOPAIR_INHIBIT_INIT=1
export QT_QPA_PLATFORMTHEME="qt5ct"

export SXHKD_FIFO="/tmp/sxhkd_fifo"
export SXHKD_SHELL="zsh"

export AURDEST=$(readlink -f "${HOME}/tmp/pacaur")

export FZF_DEFAULT_OPTS="--color=bg+:#184454,bg:#000000,spinner:#395573,hl:#4779B3 --color=fg:#617287,header:#4779B3,info:#2b768d,pointer:#395573 --color=marker:#395573,fg+:#e5ebf1,prompt:#2b768d,hl+:#4779B3 --bind='ctrl-t:execute(~/bin/v {})+abort'"
export FZF_TMUX=1
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

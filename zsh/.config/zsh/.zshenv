[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ${HOME}/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs "${tmp_loc}" ${HOME}/tmp }

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

export ZSHDIR="${XDG_CONFIG_HOME}/zsh"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

unset SSH_ASKPASS

export PYTHONIOENCODING='utf-8'
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

export INPUTRC=${XDG_CONFIG_HOME}/inputrc
export BROWSER="firefox"
export LESSCHARSET=UTF-8
export COLORTERM="yes"
export LS_COLORS GREP_COLORS
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

export MPV_HOME="${XDG_CONFIG_HOME}/mpv"
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export SXHKD_FIFO="/tmp/sxhkd_fifo"
export SXHKD_SHELL="zsh"

export FZF_DEFAULT_OPTS="--bind='ctrl-t:execute(/bin/nvim {})+abort'"
if [[ ! -z ${DISPLAY} ]]; then
    gen_fzf_default_opts() {
        local color01="$(xrescat color215 || echo '#184454')"
        local color04="$(xrescat color15 || echo '#617287')"
        local color06="#e5ebf1"
        local color0A="$(xrescat color22 || echo '#2b768d')"
        local color0C="$(xrescat color4 || echo '#395573')"
        local color0D="$(xrescat color12 || echo '#4779B3')"

        export FZF_DEFAULT_OPTS="--color=bg+:${color01},bg:#000000,spinner:${color0C},hl:${color0D} --color=fg:${color04},header:${color0D},info:${color0A},pointer:${color0C} --color=marker:${color0C},fg+:${color06},prompt:${color0A},hl+:${color0D} --bind='ctrl-t:execute(~/bin/v {})+abort'"
    }
    gen_fzf_default_opts; unfunction gen_fzf_default_opts
fi

export FZF_TMUX=1
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

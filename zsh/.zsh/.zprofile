if [[ -o LOGIN  ]]; then
    setterm -bfreq 0 # disable annoying pc speaker
    if [[ "${TERM}" = "linux" ]]; then
        local run_yaft=0
        if hash yaft 2> /dev/null; then
            if [[ ${run_yaft} == 1 ]]; then
                yaft
            fi
        fi

        echo -en "\e]P0000000" #black
        echo -en "\e]P83d3d3d" #darkgrey
        echo -en "\e]P18c4665" #darkred
        echo -en "\e]P9bf4d80" #red
        echo -en "\e]P2287373" #darkgreen
        echo -en "\e]PA53a6a6" #green
        echo -en "\e]P37c7c99" #brown
        echo -en "\e]PB9e9ecb" #yellow
        echo -en "\e]P4395573" #darkblue
        echo -en "\e]PC477ab3" #blue
        echo -en "\e]P55e468c" #darkmagenta
        echo -en "\e]PD7e62b3" #magenta
        echo -en "\e]P631658c" #darkcyan
        echo -en "\e]PE6096bf" #cyan
        echo -en "\e]P7899ca1" #lightgrey
        echo -en "\e]PFc0c0c0" #white
    fi
    (( $#commands[tmux]  )) && tmux list-sessions 2>/dev/null
fi

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
    local color00='#0b1c2c'
    local color01='#223b54'
    local color02='#405c79'
    local color03='#627e99'
    local color04='#aabcce'
    local color05='#cbd6e2'
    local color06='#e5ebf1'
    local color07='#f7f9fb'
    local color08='#bf8b56'
    local color09='#bfbf56'
    local color0A='#8bbf56'
    local color0B='#56bf8b'
    local color0C='#568bbf'
    local color0D='#8b56bf'
    local color0E='#bf568b'
    local color0F='#bf5656'

    export FZF_DEFAULT_OPTS="--color=bg+:$color01,bg:#000000,spinner:$color0C,hl:$color0D --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
}

_gen_fzf_default_opts

export FZF_TMUX=1

export PATH=/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin

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

unset SSH_ASKPASS

export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
export INPUTRC=${XDG_CONFIG_HOME}/inputrc
export BROWSER="firefox"
export PERLBREW_ROOT=${HOME}/.perl5
export EXA_COLORS="da=00;38;5;250:uu=0:gu=0"
export LS_COLORS GREP_COLORS
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '
export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=${HOME}/bin/go

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

export TODOIST_API_KEY=a90db957033648e8216d95791401d7fbf1503bdd

export STEAM_RUNTIME=1

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

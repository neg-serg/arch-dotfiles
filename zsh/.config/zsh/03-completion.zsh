zstyle ':acceptline:*' rehash true
# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'
# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:corrections' format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%})"
zstyle ':completion:*:descriptions' format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%}%{${reset_color}%}"
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:-tilde-:*' group-order 'named-directories'
# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:history-words' list false
# activate menu                            
zstyle ':completion:*:history-words' menu yes
# ignore duplicate entries                 
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' stop yes
# match uppercase from lowercase           
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# separate matches into groups          
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=5
zstyle ':completion:*:messages' format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' verbose true
zstyle ':completion:*:-command-:*:' verbose false
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:' prompt 'correct to: %e'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*:(mv|cp|file|mp|mpv):*' ignored-patterns '(#i)*.(url|mht)'
zstyle ':completion:*:*:(mp|mpv):*' tag-order files
zstyle ':completion:*:*:(mp|mpv):*' file-sort name
zstyle ':completion:*:*:(mp|mpv):*' menu select auto
zstyle ':completion:*:*:mp:*' file-patterns '(#i)*.(rmvb|mkv|vob|ts|mp4|m4a|iso|wmv|webm|flv|ogv|avi|mpg|mpeg|iso|nrg|mp3|flac|rm|wv|m4v):files:mplayer\ play *(-/):directories:directories'
zstyle ':completion:*:default' \
    select-prompt \
    "%{${fg[cyan]}%}Match %{${fg_bold[cyan]}%}%m%{${fg_no_bold[cyan]}%}  Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[blue]}%}  %p%{${reset_color}%}"
    zstyle ':completion:*:default' \
    list-prompt \
    "%{${fg[cyan]}%}Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[cyan]}%}  Continue?%{${reset_color}%}"
    zstyle ':completion:*:warnings' \
    format \
    "- %{${fg_no_bold[blue]}%}no match%{${reset_color}%} - %{${fg_no_bold[cyan]}%}%d%{${reset_color}%}"
zstyle ':completion:*:default' list-colors ${${(s.:.)LS_COLORS}%ec=*}
zstyle ':completion:*' list-colors "ma=48;5;7;38;5;16;1"
zstyle ':completion:*:options' list-colors '=^(-- *)=00;38;5;75'
zstyle ':completion:*' squeeze-slashes true # e.g. ls foo//bar -> ls foo/bar
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}%%:*}#\[}%\]}) ||
_ssh_hosts=()
hosts=($HOST "$_ssh_hosts[@]" $_ssh_config_hosts[@] localhost)
zstyle ':completion:*:hosts' hosts ${hosts}
# highlight the original input.
zstyle ':completion:*:original' list-colors "=*=$color[blue];$color[bold]"
# colorize username completion
zstyle ':completion:*:*:*:*:users' list-colors "=*=$color[blue];$color[bg-black]"
# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    mailman mailnull mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
zstyle ':completion:*:wine:*' file-patterns '(#i)*.(exe):exe'
# highlight parameters with uncommon names
zstyle ':completion:*:parameters' list-colors "=[^a-zA-Z]*=$color[cyan]"
# highlight aliases 
zstyle ':completion:*:aliases' list-colors "=*=$color[green]"
# highlight the original input.
zstyle ':completion:*:original' list-colors "=*=$color[blue];$color[bold]"
# highlight words like 'esac' or 'end'
zstyle ':completion:*:reserved-words' list-colors "=*=$color[blue]"
# colorize processlist for 'kill'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[cyan]=$color[yellow]=$color[green]"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:zathura:*' tag-order files
zstyle ':completion:*:*:zathura:*' file-patterns '*(/)|*.{pdf,djvu}'
# make them a little less short, after all (mostly adds -l option to the whatis calll)
zstyle ':completion:*:command-descriptions' command '_call_whatis -l -s 1 -r .\*; _call_whatis -l -s 6 -r .\* 2>/dev/null'
zstyle ':completion:*:*:task:*' verbose yes # taskwarrior
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u' # taskwarrior
zstyle ':completion:*:*:task:*' group-name '' # taskwarrior
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'

# run rehash on completion so new installed program are found automatically:
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1
}
## correction
setopt correct
zstyle -e ':completion:*' completer '
    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
        _last_try="$HISTNO$BUFFER$CURSOR"
        reply=(_complete _match _ignored _prefix _files)
    else
        if [[ $words[1] == (rm|mv) ]] ; then
            reply=(_complete _files)
        else
            reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
        fi
    fi'

[[ -d "${ZDOTDIR}/cache" ]] && zstyle ':completion:*' use-cache yes && \
    zstyle ':completion::complete:*' cache-path "${ZDOTDIR}/cache/"

autoload -U select-word-style backward-kill-word-match backward-word-match forward-word-match
select-word-style shell

zle -N backward-kill-word-match
zle -N backward-word-match
zle -N forward-word-match

# for backward-kill, all but / are word chars (ie, delete word up to last directory)
zstyle ':zle:backward-kill-word*' word-style standard
zstyle ':zle:*kill*' word-chars '*?_-.[]~=&;!#$%^(){}<>'

expand-or-complete-with-dots() {
    echo -n "\e[36m··\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_cd # if a command is issued that can't be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt auto_pushd # make cd push the old directory onto the directory stack.
setopt c_bases  # print $(( [#16] 0xff ))
setopt completeinword # not just at the end
setopt extendedglob # enable extended globbing
setopt glob_star_short # */** -> **
setopt hash_list_all  # whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt interactivecomments # allow interactive comments
setopt interactivecomments # allow interactive comments after '#' in command line
setopt longlistjobs # display PID when suspending processes as well
setopt magicequalsubst # ~ substitution and tab completion after a = (for --x=filename args)
setopt nobeep # get rid of beeps
setopt no_bg_nice # don't nice background jobs
setopt noflowcontrol # no c-s/c-q output freezing
setopt noglobdots  # * shouldn't match dotfiles. ever.
setopt nohup  # don't send SIGHUP to background processes when the shell exits.
setopt no_monitor # do not notify about bg task ending
setopt nonomatch # try to avoid the 'zsh: no matches found...'
setopt no_notify # do not notify about bg task ending
setopt noshwordsplit  # use zsh style word splitting
setopt notify  # report the status of backgrounds jobs immediately
setopt transient_rprompt # only show the rprompt on the current prompt
setopt prompt_subst # set the prompt
setopt pushd_ignore_dups # don't push the same dir twice.
setopt pushdminus # pushd -N goes to Nth dir in stack
setopt pushdsilent # do not print dirstack after each cd/pushd
setopt pushdtohome # pushd with no args pushes to home
setopt multios # support multiple redirections
setopt rm_star_wait # most Massively Useful Option ever! protects you from "you shoot yourself in the foot".
setopt pushd_silent # do not print directory stack
setopt short_loops # short loops support
setopt correct # use autocorrection

setopt append_history # this is default, but set for share_history
setopt extended_history # save each command's beginning timestamp and the duration to the history file
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt histignorealldups # remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space # reduce whitespace in history
setopt histignorespace # remove command lines from the history list when the first character on the line is a space
setopt hist_verify # don't execute, just expand history
setopt inc_append_history # add comamnds as they are typed, don't wait until shell exit
setopt share_history # import new commands from the history file also in other zsh-session
unsetopt hist_beep # Don't beep when a widget tries to access an history entry which isn't there.
setopt hist_fcntl_lock # Use the OS's locking mechanism instead of ZSH's
setopt hist_find_no_dups # When searching in the history do not show dups multiple times
setopt hist_no_store # Don't add the "history" command to the history when it's called
setopt hist_reduce_blanks # Don't store blank lines in the history

watch=(notme root) # watch for everyone but me and root
typeset -U path cdpath fpath manpath # automatically remove duplicates from these arrays

export PATH=/usr/bin:$HOME/bin:/usr/local/bin:/sbin:/bin:/usr/bin/core_perl:/opt/go/bin:/opt/cuda/bin
export EDITOR="nvim"
export VISUAL="${EDITOR}"
export PAGER="slit"
export READNULLCMD="highlight"
export MANPAGER="nvim +Man!"

export TIMEFMT="[37m[34m⟬[37m[37m%J[34m⟭[39m[34m⟬[37m%U[34m⟭[39m[34m⟬[37muser %S[34m⟭[39m[34m⟬[37msystem %P[34m⟭[39m[34m⟬[37mcpu %*E total[34m⟭[39m[34m[39m[34m⟬[37mMem: %M kb max[34m⟭[39m"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export LS_COLORS

export HISTFILE=${ZDOTDIR}/zsh_history
export SAVEHIST=10000000
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTORY_IGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"

_zpcompinit_custom() {
    setopt extendedglob local_options
    autoload -Uz compinit
    local zcd=${ZDOTDIR:-$HOME}/.zcompdump
    local zcdc="$zcd.zwc"
    # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
    # in the background as this is doesn't affect the current session
    if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
        else
            compinit -C -d "$zcd"
            { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
    fi
}

zmodload -i zsh/complist
autoload -Uz history-search-end
autoload -Uz split-shell-arguments
autoload -Uz lookupinit

fasd_init() {
    if [[ -x =fasd ]]; then
        (( $+functions[compdef] )) && {
        # zsh word mode completion
        _fasd_zsh_word_complete() {
            [ "$2" ] && local _fasd_cur="$2"
            [ -z "$_fasd_cur" ] && local _fasd_cur="${words[CURRENT]}"
            local fnd="${_fasd_cur//,/ }"
            local typ=${1:-e}
            fasd --query $typ "$fnd" 2>> "/dev/null" | \
            sort -nr | sed 's/^[^ ]*[ ]*//' | while read -r line; do
                compadd -U -V fasd "$line"
            done
            compstate[insert]=menu # no expand
        }
        _fasd_zsh_word_complete_f() { _fasd_zsh_word_complete f ; }
        _fasd_zsh_word_complete_d() { _fasd_zsh_word_complete d ; }
        _fasd_zsh_word_complete_trigger() {
            local _fasd_cur="${words[CURRENT]}"
            eval $(fasd --word-complete-trigger _fasd_zsh_word_complete $_fasd_cur)
        }
        # define zle widgets
        zle -C fasd-complete complete-word _generic
        zstyle ':completion:fasd-complete:*' completer _fasd_zsh_word_complete
        zstyle ':completion:fasd-complete:*' menu-select

        zle -C fasd-complete-f complete-word _generic
        zstyle ':completion:fasd-complete-f:*' completer _fasd_zsh_word_complete_f
        zstyle ':completion:fasd-complete-f:*' menu-select

        zle -C fasd-complete-d complete-word _generic
        zstyle ':completion:fasd-complete-d:*' completer _fasd_zsh_word_complete_d
        zstyle ':completion:fasd-complete-d:*' menu-select
        }
    fi
}

dircolors_init() {
    [[ -f "${XDG_CONFIG_HOME}/dircolors/dircolors" ]] && \
    eval $(dircolors "${XDG_CONFIG_HOME}/dircolors/dircolors")
}

chpwd() {
    [[ -x =fasd ]] && {
        [[ "${PWD}" -ef "${HOME}" ]] || fasd -A "${PWD}"
    }
}

# Find history events by search pattern and list them by date.
h() {
    emulate -L zsh
    local usage help ident format_l format_s first_char remain first last
    usage='USAGE: whatwhen [options] <searchstring> <search range>'
    #  help='Use' \`'whatwhen -h'\'' for further explanations.' # no idea why this doesn't work --obreitwi, 21-06-10 17:37:19
    ident=${(l,${#${:-Usage: }},, ,)}
    format_l="${ident}%s\t\t\t%s\n"
    format_s="${format_l//(\\t)##/\\t}"
    # Make the first char of the word to search for case
    # insensitive; e.g. [aA]
    first_char=[${(L)1[1]}${(U)1[1]}]
    remain=${1[2,-1]}
    # Default search range is `-1000'.
    first=${2:-\-1000}
    # Optional, just used for `<first> <last>' given.
    last=$3
    case $1 in
        ("")
            printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (-h)
            printf '%s\n\n' ${usage}
            print 'OPTIONS:'
            printf $format_l '-h' 'show help text'
            print '\f'
            print 'SEARCH RANGE:'
            printf $format_l "'0'" 'the whole history,'
            printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
            printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
            printf '\n%s\n' 'EXAMPLES:'
            printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -1000 by default.'
            printf $format_l 'whatwhen zsh -250'
            printf $format_l 'whatwhen foo 1 99'
        ;;
        (\?)
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (*)
            # -l list results on stout rather than invoking $EDITOR.
            # -i Print dates as in YYYY-MM-DD.
            # -m Search for a - quoted - pattern within the history.
            fc -li -m "*${first_char}${remain}*" $first $last
        ;;
    esac
}

zle_highlight=(region:bg=228)

zsh-defer _zpcompinit_custom
zsh-defer fasd_init
zsh-defer dircolors_init

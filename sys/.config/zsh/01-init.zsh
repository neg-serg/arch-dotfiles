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
setopt pushdtohome #pushd with no args pushes to home

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

watch=(notme root) # watch for everyone but me and root
typeset -U path cdpath fpath manpath # automatically remove duplicates from these arrays

export PATH=/usr/bin:$HOME/bin:/usr/local/bin:/sbin:/bin:/usr/bin/core_perl:/opt/go/bin
export EDITOR="nvim"
export VISUAL="${EDITOR}"
export PAGER="page -q 90000"
export READNULLCMD=${PAGER}
export MANPAGER="page -C -e 'au User PageDisconnect sleep 100m|%y p|enew! |bd! #|pu p|set ft=man'"
export MANWIDTH=999

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

zsh-defer _zpcompinit_custom
zsh-defer fasd_init
zsh-defer dircolors_init

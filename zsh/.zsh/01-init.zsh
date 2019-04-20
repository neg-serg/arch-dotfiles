# autoload wrapper - use this one instead of autoload directly
# We need to define this function as early as this, because autoloading
# 'is-at-least()' needs it.
function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( ffound = 0 ))
    for fdir in ${fpath} ; do
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 ))
    done

    (( ffound == 0 )) && return 1
    autoload -U ${ffile} || return 1
    return 0
}

# Speeds up load time
DISABLE_UPDATE_PROMPT=true

# Perform compinit only once a day.
autoload -Uz compinit

setopt EXTENDEDGLOB
for dump in ${HOME}/.zcompdump(#qN.m1); do
    compinit
    if [[ -s "${dump}" && (! -s "${dump}.zwc" || "${dump}" -nt "${dump}.zwc") ]]; then
        zcompile "${dump}"
    fi
done
unsetopt EXTENDEDGLOB
compinit -C

zrcautoload colors && colors

eval $(keychain --eval --quiet id_rsa)

zle_highlight+=(suffix:fg=blue)

unset MAILCHECK

{
    stty eof  2> /dev/null  # stty eof ''
    stty ixany
    stty ixoff -ixon # Disable XON/XOFF flow control; this is required to make C-s work in Vim.
} &!

function stty_setup(){
    stty time 0 2> /dev/null
    stty min 0 2> /dev/null
    stty line 6 2> /dev/null
    stty speed 38400 &> /dev/null
}

[[ $- =~ i ]] && stty_setup &!

[[ -f ~/.config/dircolors/.dircolors ]] && eval $(dircolors ~/.config/dircolors/.dircolors)

ulimit -c 0 # No core dumps for now

setopt append_history # this is default, but set for share_history
setopt share_history # import new commands from the history file also in other zsh-session
setopt extended_history # save each command's beginning timestamp and the duration to the history file
setopt histignorealldups # remove command lines from the history list when the first character on the line is a space

setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_verify # don't execute, just expand history
setopt hist_ignore_space # reduce whitespace in history
setopt inc_append_history # add comamnds as they are typed, don't wait until shell exit

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace 
# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd 

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob # ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^^ ^ ^ ^ ^
setopt longlistjobs # display PID when suspending processes as well
setopt nonomatch # try to avoid the 'zsh: no matches found...'
setopt notify  # report the status of backgrounds jobs immediately
setopt hash_list_all  # whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt completeinword # not just at the end
setopt nohup  # don't send SIGHUP to background processes when the shell exits.
setopt auto_pushd # make cd push the old directory onto the directory stack.
setopt pushdminus # pushd -N goes to Nth dir in stack
setopt pushdsilent # do not print dirstack after each cd/pushd
setopt pushdtohome #pushd with no args pushes to home
setopt pushd_ignore_dups # don't push the same dir twice.
setopt nobeep # get rid of beeps
setopt noglobdots  # * shouldn't match dotfiles. ever.
setopt noshwordsplit  # use zsh style word splitting
setopt noflowcontrol # no c-s/c-q output freezing

setopt c_bases  # print $(( [#16] 0xff ))
setopt prompt_subst # set the prompt
# make sure to use right prompt only when not running a command
setopt transient_rprompt # only show the rprompt on the current prompt
setopt interactivecomments # allow interactive comments
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word

setopt extendedglob # enable extended globbing
setopt interactivecomments # allow interactive comments after '#' in command line

# ~ substitution and tab completion after a = (for --x=filename args)
setopt magicequalsubst
# setopt glob_star_short # */** -> **

# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

fpath=(
    ${HOME}/.zsh/zsh-completions/src 
    ~/.zsh/compdef 
    ${HOME}/.zsh/zle 
    ${fpath}
)

zrcautoload zmv # who needs mmv or rename?
zrcautoload history-search-end
zrcautoload split-shell-arguments

zrcautoload zed # use ZLE editor to edit a file or function

for mod in complist deltochar mathfunc ; do
    zmodload -i zsh/${mod} 2>/dev/null || print "Notice: no ${mod} available :("
done

# autoload zsh modules when they are referenced
zmodload -a  zsh/stat    zstat
zmodload -a  zsh/zpty    zpty
zmodload -ap zsh/mapfile mapfile

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0 # important for a live-cd-system
limit -s

# Keeps track of the last used working directory and automatically jumps
# into it for new shells.
export ZSH=~/.zsh

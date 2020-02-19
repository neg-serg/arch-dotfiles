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
setopt no_bg_nice # don't nice background jobs
setopt no_notify # do not notify about bg task ending
setopt no_monitor # do not notify about bg task ending

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

# Perform compinit only once a day.
autoload -Uz compinit
for dump in ${HOME}/.zcompdump(#qN.m1); do
    compinit
    if [[ -s "${dump}" && (! -s "${dump}.zwc" || "${dump}" -nt "${dump}.zwc") ]]; then
        zcompile "${dump}"
    fi
done
compinit -C

eval $(keychain --eval --quiet id_rsa)

autoload -Uz colors
zle_highlight+=(suffix:fg=blue)
unset MAILCHECK
{
    stty eof  2> /dev/null  # stty eof ''
} &!

stty_setup() {
    stty time 0 2> /dev/null
    stty min 0 2> /dev/null
    stty line 6 2> /dev/null
    stty speed 38400 &> /dev/null
}

[[ $- =~ i ]] && stty_setup &!

[[ -f ~/.config/dircolors/.dircolors ]] && eval $(dircolors ~/.config/dircolors/.dircolors)

# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

autoload -Uz history-search-end
autoload -Uz split-shell-arguments
autoload -Uz lookupinit

for mod in complist deltochar mathfunc ; do
    zmodload -i zsh/${mod} 2>/dev/null || print "Notice: no ${mod} available :("
done

# Use hard limits, except for a smaller stack and no core dumps
unlimit
ulimit -c 0 # No core dumps for now
limit stack 8192
limit core 0 # important for a live-cd-system
limit -s

eval "$(/usr/bin/direnv hook zsh)"

fasd_cache="${XDG_CACHE_HOME}/fasd-init-cache"
if [ "$(command -v fasd)" -nt "${fasd_cache}" -o ! -s "${fasd_cache}" ]; then
    fasd --init auto >| "${fasd_cache}"
fi
source "${fasd_cache}"
unset fasd_cache

export FZF_DEFAULT_OPTS="--bind='ctrl-t:execute(/bin/nvim {})+abort'"
if [[ ! -z ${DISPLAY} ]]; then
    gen_fzf_default_opts() {
        local color01="$(/usr/bin/xrescat color215 || echo '#184454')"
        local color04="$(/usr/bin/xrescat color15 || echo '#617287')"
        local color06="#e5ebf1"
        local color0A="$(/usr/bin/xrescat color22 || echo '#2b768d')"
        local color0C="$(/usr/bin/xrescat color4 || echo '#395573')"
        local color0D="$(/usr/bin/xrescat color12 || echo '#4779B3')"

        export FZF_DEFAULT_OPTS="--color=bg+:${color01},bg:#000000,spinner:${color0C},hl:${color0D} --color=fg:${color04},header:${color0D},info:${color0A},pointer:${color0C} --color=marker:${color0C},fg+:${color06},prompt:${color0A},hl+:${color0D} --bind='ctrl-t:execute(~/bin/v {})+abort'"
    }
    gen_fzf_default_opts; unfunction gen_fzf_default_opts
fi

export FZF_TMUX=1
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

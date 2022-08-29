source $HOME/.profile
# Make sure the terminal type we're using is supported (tmux-256color doesn't
# work everywhere yet)
if ! infocmp $TERM > /dev/null 2>&1; then
  if [[ "$TERM" = "tmux-256color" ]]; then
    export TERM="screen-256color"
  else
    export TERM="xterm-256color"
  fi
fi

shopt -qs autocd # cd without typing cd
shopt -qs cdspell # Auto-correct directory typos
shopt -qs checkhash # Check hash before executing
shopt -s checkwinsize # Check window size after each command, and update $LINES and $COLUMNS
shopt -s cmdhist # Save all lines of multiline commands
shopt -qs direxpand # Expand directory names when doing file completion
shopt -qs dirspell # Fix typos for directories in completion
shopt -qs dotglob # Include filenames that begin with '.' in filename expansion
shopt -qs extglob # Extended pattern matching
shopt -qs extquote # Allow escape sequencing within ${parameter} expansions
shopt -qs globstar # Support ** for expansion
shopt -qs histappend histreedit histverify
shopt -qs hostcomplete
shopt -s nocaseglob nocasematch

alias utc='date -u'
alias mv='mv -i'
alias ls='ls --color=auto -pFhv --quoting-style=shell-escape'
alias la='ls --color=auto -ApFhv'
alias ll='ls --color=auto -AlpFhv'

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
# vim: ft=sh

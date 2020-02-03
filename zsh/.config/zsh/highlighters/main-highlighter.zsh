
ZSH_HIGHLIGHT_STYLES+=(
    default                         none
    unknown-token                   none
    suffix-alias                    fg=024,underline
    reserved-word                   fg=004
    alias                           fg=024
    builtin                         fg=024
    function                        fg=024,underline
    command                         fg=024

    precommand                      fg=024,underline 
    path                            fg=248
    path_prefix                     none
    path_approx                     fg=white
    # path_pathseparator
    # path_prefix_pathseparator

    hashed-command                   fg=024
    globbing                         fg=110
    history-expansion                fg=blue
    single-hyphen-option             fg=61
    double-hyphen-option             fg=61
    comment                          fg=56
    arg0                             fg=024
    named-fd                         none
    rc-quote                         cyan
    redirection                      none
    commandseparator                 none
    command-substitution             none
    command-substitution-delimiter   magenta
    process-substitution             none
    process-substitution-delimiter   magenta

    back-quoted-argument            fg=244,bold
    single-quoted-argument          fg=244
    double-quoted-argument          fg=244
    dollar-double-quoted-argument   fg=004,bold
    back-double-quoted-argument     fg=244,bold
    back-dollar-quoted-argument     fg=244,bold
    assign                          fg=38,bold
)
ZSH_HIGHLIGHT_STYLES+=($(< ${ZDOTDIR}/highlighters/ft_list.zsh))

# Whether the highlighter should be called or not.
_zsh_highlight_highlighter_main_predicate()
{
  # may need to remove path_prefix highlighting when the line ends
  [[ $WIDGET == zle-line-finish ]] || _zsh_highlight_buffer_modified
}

# Helper to deal with tokens crossing line boundaries.
_zsh_highlight_main_add_region_highlight() {
  integer start=$1 end=$2
  shift 2

  if (( in_alias )); then
    [[ $1 == unknown-token ]] && alias_style=unknown-token
    return
  fi

  # The calculation was relative to $buf but region_highlight is relative to $BUFFER.
  (( start += buf_offset ))
  (( end += buf_offset ))

  list_highlights+=($start $end $1)
}

_zsh_highlight_main_add_many_region_highlights() {
  for 1 2 3; do
    _zsh_highlight_main_add_region_highlight $1 $2 $3
  done
}

_zsh_highlight_main_calculate_fallback() {
  local -A fallback_of; fallback_of=(
      alias arg0
      suffix-alias arg0
      builtin arg0
      function arg0
      command arg0
      precommand arg0
      hashed-command arg0
      arg0_\* arg0

      path_prefix path
      # The path separator fallback won't ever be used, due to the optimisation
      # in _zsh_highlight_main_highlighter_highlight_path_separators().
      path_pathseparator path
      path_prefix_pathseparator path_prefix

      single-quoted-argument{-unclosed,}
      double-quoted-argument{-unclosed,}
      dollar-quoted-argument{-unclosed,}
      back-quoted-argument{-unclosed,}

      command-substitution{-quoted,,-unquoted,}
      command-substitution-delimiter{-quoted,,-unquoted,}

      command-substitution{-delimiter,}
      process-substitution{-delimiter,}
      back-quoted-argument{-delimiter,}
  )
  local needle=$1 value
  reply=($1)
  while [[ -n ${value::=$fallback_of[(k)$needle]} ]]; do
    unset "fallback_of[$needle]" # paranoia against infinite loops
    reply+=($value)
    needle=$value
  done
}

# Get the type of a command.
#
# Uses the zsh/parameter module if available to avoid forks, and a
# wrapper around 'type -w' as fallback.
#
# If $2 is 0, do not consider aliases.
#
# The result will be stored in REPLY.
_zsh_highlight_main__type() {
  integer -r aliases_allowed=${2-1}
  # We won't cache replies of anything that exists as an alias at all, to
  # ensure the cached value is correct regardless of $aliases_allowed.
  #
  # ### We probably _should_ cache them in a cache that's keyed on the value of
  # ### $aliases_allowed, on the assumption that aliases are the common case.
  integer may_cache=1

  # Cache lookup
  if (( $+_zsh_highlight_main__command_type_cache )); then
    REPLY=$_zsh_highlight_main__command_type_cache[(e)$1]
    if [[ -n "$REPLY" ]]; then
      return
    fi
  fi

  # Main logic
  if (( $#options_to_set )); then
    setopt localoptions $options_to_set;
  fi
  unset REPLY
  if zmodload -e zsh/parameter; then
    if (( $+aliases[(e)$1] )); then
      may_cache=0
    fi
    if (( $+aliases[(e)$1] )) && (( aliases_allowed )); then
      REPLY=alias
    elif [[ $1 == *.* && -n ${1%.*} ]] && (( $+saliases[(e)${1##*.}] )); then
      REPLY='suffix alias'
    elif (( $reswords[(Ie)$1] )); then
      REPLY=reserved
    elif (( $+functions[(e)$1] )); then
      REPLY=function
    elif (( $+builtins[(e)$1] )); then
      REPLY=builtin
    elif (( $+commands[(e)$1] )); then
      REPLY=command
    # None of the special hashes had a match, so fall back to 'type -w', for
    # forward compatibility with future versions of zsh that may add new command
    # types.
    #
    # zsh 5.2 and older have a bug whereby running 'type -w ./sudo' implicitly
    # runs 'hash ./sudo=/usr/local/bin/./sudo' (assuming /usr/local/bin/sudo
    # exists and is in $PATH).  Avoid triggering the bug, at the expense of
    # falling through to the $() below, incurring a fork.  (Issue #354.)
    #
    # The first disjunct mimics the isrelative() C call from the zsh bug.
    elif {  [[ $1 != */* ]] || is-at-least 5.3 } &&
         # Add a subshell to avoid a zsh upstream bug; see issue #606.
         # ### Remove the subshell when we stop supporting zsh 5.7.1 (I assume 5.8 will have the bugfix).
         ! (builtin type -w -- "$1") >/dev/null 2>&1; then
      REPLY=none
    fi
  fi
  if ! (( $+REPLY )); then
    # zsh/parameter not available or had no matches.
    #
    # Note that 'type -w' will run 'rehash' implicitly.
    #
    # We 'unalias' in a subshell, so the parent shell is not affected.
    #
    # The colon command is there just to avoid a command substitution that
    # starts with an arithmetic expression [«((…))» as the first thing inside
    # «$(…)»], which is area that has had some parsing bugs before 5.6
    # (approximately).
    REPLY="${$(:; (( aliases_allowed )) || unalias -- "$1" 2>/dev/null; LC_ALL=C builtin type -w -- "$1" 2>/dev/null)##*: }"
    if [[ $REPLY == 'alias' ]]; then
      may_cache=0
    fi
  fi

  # Cache population
  if (( may_cache )) && (( $+_zsh_highlight_main__command_type_cache )); then
    _zsh_highlight_main__command_type_cache[(e)$1]=$REPLY
  fi
  [[ -n $REPLY ]]
  return $?
}

# Checks whether $1 is something that can be run.
#
# Return 0 if runnable, 1 if not runnable, 2 if trouble.
_zsh_highlight_main__is_runnable() {
  if _zsh_highlight_main__type "$1"; then
    [[ $REPLY != none ]]
  else
    return 2
  fi
}

# Check whether the first argument is a redirection operator token.
# Report result via the exit code.
_zsh_highlight_main__is_redirection() {
  # A redirection operator token:
  # - starts with an optional single-digit number;
  # - then, has a '<' or '>' character;
  # - is not a process substitution [<(...) or >(...)].
  # - is not a numeric glob <->
  [[ $1 == (<0-9>|)(\<|\>)* ]] && [[ $1 != (\<|\>)$'\x28'* ]] && [[ $1 != *'<'*'-'*'>'* ]]
}

# Resolve alias.
#
# Takes a single argument.
#
# The result will be stored in REPLY.
_zsh_highlight_main__resolve_alias() {
  if zmodload -e zsh/parameter; then
    REPLY=${aliases[$arg]}
  else
    REPLY="${"$(alias -- $arg)"#*=}"
  fi
}

# Check that the top of $braces_stack has the expected value.  If it does, set
# the style according to $2; otherwise, set style=unknown-token.
#
# $1: character expected to be at the top of $braces_stack
# $2: optional assignment to style it if matches
# return value is 0 if there is a match else 1
_zsh_highlight_main__stack_pop() {
  if [[ $braces_stack[1] == $1 ]]; then
    braces_stack=${braces_stack:1}
    if (( $+2 )); then
      style=$2
    fi
    return 0
  else
    style=unknown-token
    return 1
  fi
}

# Main syntax highlighting function.
_zsh_highlight_highlighter_main_paint()
{
  setopt localoptions extendedglob

  # At the PS3 prompt and in vared, highlight nothing.
  #
  # (We can't check this in _zsh_highlight_highlighter_main_predicate because
  # if the predicate returns false, the previous value of region_highlight
  # would be reused.)
  if [[ $CONTEXT == (select|vared) ]]; then
    return
  fi

  typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
  typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
  local -a options_to_set reply # used in callees
  local REPLY

  # $flags_with_argument is a set of letters, corresponding to the option letters
  # that would be followed by a colon in a getopts specification.
  local flags_with_argument
  # $flags_sans_argument is a set of letters, corresponding to the option letters
  # that wouldn't be followed by a colon in a getopts specification.
  local flags_sans_argument
  # $precommand_options maps precommand name to values of $flags_with_argument and
  # $flags_sans_argument for that precommand, joined by a colon.  (The value is NOT
  # a getopt(3) spec, although it resembles one.)
  #
  # Currently, setting $flags_sans_argument is only important for commands that
  # have a non-empty $flags_with_argument; see test-data/precommand4.zsh.
  local -A precommand_options
  precommand_options=(
    # Precommand modifiers as of zsh 5.6.2 cf. zshmisc(1).
    '-' ''
    'builtin' ''
    'command' :pvV
    'exec' a:cl
    'noglob' ''
    # 'time' and 'nocorrect' shouldn't be added here; they're reserved words, not precommands.

    'doas' aCu:Lns # as of OpenBSD's doas(1) dated September 4, 2016
    'nice' n: # as of current POSIX spec
    'pkexec' '' # doesn't take short options; immune to #121 because it's usually not passed --option flags
    # Argumentless flags that can't be followed by a command: -e -h -K -k -V -v
    'sudo' Cgprtu:AEHPSbilns # as of sudo 1.8.21p2
    'stdbuf' ioe:
    'eatmydata' ''
    'catchsegv' ''
    'nohup' ''
    'setsid' :wc
    # As of OpenSSH 8.1p1; -k is deliberately left out since it may not be followed by a command
    'ssh-agent' aEPt:csDd
    # suckless-tools v44
    # Argumentless flags that can't be followed by a command: -v
    'tabbed' gnprtTuU:cdfhs
  )

  if [[ $zsyh_user_options[ignorebraces] == on || ${zsyh_user_options[ignoreclosebraces]:-off} == on ]]; then
    local right_brace_is_recognised_everywhere=false
  else
    local right_brace_is_recognised_everywhere=true
  fi

  if [[ $zsyh_user_options[pathdirs] == on ]]; then
    options_to_set+=( PATH_DIRS )
  fi

  ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
    '|' '||' ';' '&' '&&'
    '|&'
    '&!' '&|'
    # ### 'case' syntax, but followed by a pattern, not by a command
    # ';;' ';&' ';|'
  )

  # Tokens that, at (naively-determined) "command position", are followed by
  # a de jure command position.  All of these are reserved words.
  ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW=(
    $'\x7b' # block
    $'\x28' # subshell
    '()' # anonymous function
    'while'
    'until'
    'if'
    'then'
    'elif'
    'else'
    'do'
    'time'
    'coproc'
    '!' # reserved word; unrelated to $histchars[1]
  )

  if (( $+X_ZSH_HIGHLIGHT_DIRS_BLACKLIST )); then
    print >&2 'zsh-syntax-highlighting: X_ZSH_HIGHLIGHT_DIRS_BLACKLIST is deprecated. Please use ZSH_HIGHLIGHT_DIRS_BLACKLIST.'
    ZSH_HIGHLIGHT_DIRS_BLACKLIST=($X_ZSH_HIGHLIGHT_DIRS_BLACKLIST)
    unset X_ZSH_HIGHLIGHT_DIRS_BLACKLIST
  fi

  _zsh_highlight_main_highlighter_highlight_list -$#PREBUFFER '' 1 "$PREBUFFER$BUFFER"

  # end is a reserved word
  local start end_ style
  for start end_ style in $reply; do
    (( start >= end_ )) && { print -r -- >&2 "zsh-syntax-highlighting: BUG: _zsh_highlight_highlighter_main_paint: start($start) >= end($end_)"; return }
    (( end_ <= 0 )) && continue
    (( start < 0 )) && start=0 # having start<0 is normal with e.g. multiline strings
    _zsh_highlight_main_calculate_fallback $style
    _zsh_highlight_add_highlight $start $end_ $reply
  done
}

# $1 is the offset of $4 from the parent buffer. Added to the returned highlights.
# $2 is the initial braces_stack (for a closing paren).
# $3 is 1 if $4 contains the end of $BUFFER, else 0.
# $4 is the buffer to highlight.
# Returns:
# $REPLY: $buf[REPLY] is the last character parsed.
# $reply is an array of region_highlight additions.
# exit code is 0 if the braces_stack is empty, 1 otherwise.
_zsh_highlight_main_highlighter_highlight_list()
{
  integer start_pos end_pos=0 buf_offset=$1 has_end=$3
  # alias_style is the style to apply to an alias once in_alias=0
  #     Usually 'alias' but set to 'unknown-token' if any word expanded from
  #     the alias would be highlighted as unknown-token
  local alias_style arg buf=$4 highlight_glob=true style
  local in_array_assignment=false # true between 'a=(' and the matching ')'
  # in_alias is equal to the number of shifts needed until arg=args[1] pops an
  #     arg from BUFFER and not added by an alias.
  integer in_alias=0 len=$#buf
  local -a match mbegin mend list_highlights
  # seen_alias is a map of aliases already seen to avoid loops like alias a=b b=a
  local -A seen_alias
  # Pattern for parameter names
  readonly parameter_name_pattern='([A-Za-z_][A-Za-z0-9_]*|[0-9]+)'
  list_highlights=()

  # "R" for round
  # "Q" for square
  # "Y" for curly
  # "T" for [[ ]]
  # "S" for $( )
  # "D" for do/done
  # "$" for 'end' (matches 'foreach' always; also used with cshjunkiequotes in repeat/while)
  # "?" for 'if'/'fi'; also checked by 'elif'/'else'
  # ":" for 'then'
  local braces_stack=$2

  # State machine
  #
  # The states are:
  # - :start:      Command word
  # - :start_of_pipeline:      Start of a 'pipeline' as defined in zshmisc(1).
  #                Only valid when :start: is present
  # - :sudo_opt:   A leading-dash option to a precommand, whether it takes an
  #                argument or not.  (Example: sudo's "-u" or "-i".)
  # - :sudo_arg:   The argument to a precommand's leading-dash option,
  #                when given as a separate word; i.e., "foo" in "-u foo" (two
  #                words) but not in "-ufoo" (one word).
  # - :regular:    "Not a command word", and command delimiters are permitted.
  #                Mainly used to detect premature termination of commands.
  # - :always:     The word 'always' in the «{ foo } always { bar }» syntax.
  #
  # When the kind of a word is not yet known, $this_word / $next_word may contain
  # multiple states.  For example, after "sudo -i", the next word may be either
  # another --flag or a command name, hence the state would include both ':start:'
  # and ':sudo_opt:'.
  #
  # The tokens are always added with both leading and trailing colons to serve as
  # word delimiters (an improvised array); [[ $x == *':foo:'* ]] and x=${x//:foo:/}
  # will DTRT regardless of how many elements or repetitions $x has.
  #
  # Handling of redirections: upon seeing a redirection token, we must stall
  # the current state --- that is, the value of $this_word --- for two iterations
  # (one for the redirection operator, one for the word following it representing
  # the redirection target).  Therefore, we set $in_redirection to 2 upon seeing a
  # redirection operator, decrement it each iteration, and stall the current state
  # when it is non-zero.  Thus, upon reaching the next word (the one that follows
  # the redirection operator and target), $this_word will still contain values
  # appropriate for the word immediately following the word that preceded the
  # redirection operator.
  #
  # The "the previous word was a redirection operator" state is not communicated
  # to the next iteration via $next_word/$this_word as usual, but via
  # $in_redirection.  The value of $next_word from the iteration that processed
  # the operator is discarded.
  #
  local this_word next_word=':start::start_of_pipeline:'
  integer in_redirection
  # Processing buffer
  local proc_buf="$buf"
  local -a args
  if [[ $zsyh_user_options[interactivecomments] == on ]]; then
    args=(${(zZ+c+)buf})
  else
    args=(${(z)buf})
  fi
  while (( $#args )); do
    arg=$args[1]
    shift args
    if (( in_alias )); then
      (( in_alias-- ))
      if (( in_alias == 0 )); then
        seen_alias=()
        # start_pos and end_pos are of the alias (previous $arg) here
        _zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
      fi
    fi

    # Initialize this_word and next_word.
    if (( in_redirection == 0 )); then
      this_word=$next_word
      next_word=':regular:'
    else
      # Stall $next_word.
      (( --in_redirection ))
    fi

    # Initialize per-"simple command" [zshmisc(1)] variables:
    #
    #   $style               how to highlight $arg
    #   $in_array_assignment boolean flag for "between '(' and ')' of array assignment"
    #   $highlight_glob      boolean flag for "'noglob' is in effect"
    #
    style=unknown-token
    if [[ $this_word == *':start:'* ]]; then
      in_array_assignment=false
      if [[ $arg == 'noglob' ]]; then
        highlight_glob=false
      fi
    fi

    if (( in_alias == 0 )); then
      # Compute the new $start_pos and $end_pos, skipping over whitespace in $buf.
      [[ "$proc_buf" = (#b)(#s)(([ $'\t']|\\$'\n')#)* ]]
      # The first, outer parenthesis
      integer offset="${#match[1]}"
      (( start_pos = end_pos + offset ))
      (( end_pos = start_pos + $#arg ))

      # Compute the new $proc_buf. We advance it
      # (chop off characters from the beginning)
      # beyond what end_pos points to, by skipping
      # as many characters as end_pos was advanced.
      #
      # end_pos was advanced by $offset (via start_pos)
      # and by $#arg. Note the `start_pos=$end_pos`
      # below.
      #
      # As for the [,len]. We could use [,len-start_pos+offset]
      # here, but to make it easier on eyes, we use len and
      # rely on the fact that Zsh simply handles that. The
      # length of proc_buf is len-start_pos+offset because
      # we're chopping it to match current start_pos, so its
      # length matches the previous value of start_pos.
      #
      # Why [,-1] is slower than [,length] isn't clear.
      proc_buf="${proc_buf[offset + $#arg + 1,len]}"
    fi

    # Handle the INTERACTIVE_COMMENTS option.
    #
    # We use the (Z+c+) flag so the entire comment is presented as one token in $arg.
    if [[ $zsyh_user_options[interactivecomments] == on && $arg[1] == $histchars[3] ]]; then
      if [[ $this_word == *(':regular:'|':start:')* ]]; then
        style=comment
      else
        style=unknown-token # prematurely terminated
      fi
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
      # Stall this arg
      in_redirection=1
      continue
    fi

    if [[ $this_word == *':start:'* ]] && ! (( in_redirection )); then
      # Expand aliases.
      # An alias is ineligible for expansion while it's being expanded (see #652/#653).
      _zsh_highlight_main__type "$arg" "$(( ! ${+seen_alias[$arg]} ))"
      local res="$REPLY"
      if [[ $res == "alias" ]]; then
        # Mark insane aliases as unknown-token (cf. #263).
        if [[ $arg == ?*=* ]]; then
          (( in_alias == 0 )) && in_alias=1
          _zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
          continue
        fi
        seen_alias[$arg]=1
        _zsh_highlight_main__resolve_alias $arg
        local -a alias_args
        # Elision is desired in case alias x=''
        if [[ $zsyh_user_options[interactivecomments] == on ]]; then
          alias_args=(${(zZ+c+)REPLY})
        else
          alias_args=(${(z)REPLY})
        fi
        args=( $alias_args $args )
        if (( in_alias == 0 )); then
          alias_style=alias
          # Add one because we will in_alias-- on the next loop iteration so
          # this iteration should be considered in in_alias as well
          (( in_alias += $#alias_args + 1 ))
        else
          # This arg is already included in the count, so no need to + 1.
          (( in_alias += $#alias_args ))
        fi
        (( in_redirection++ )) # Stall this arg
        continue
      else
        _zsh_highlight_main_highlighter_expand_path $arg
        _zsh_highlight_main__type "$REPLY" 0
        res="$REPLY"
      fi
    fi

    # Analyse the current word.
    if _zsh_highlight_main__is_redirection $arg ; then
      if (( in_redirection == 1 )); then
        # The condition excludes the case that BUFFER='{foo}>&2' and we're on the '>&'.
        _zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
      else
        in_redirection=2
        _zsh_highlight_main_add_region_highlight $start_pos $end_pos redirection
      fi
      continue
    elif [[ $arg == '{'${~parameter_name_pattern}'}' ]] && _zsh_highlight_main__is_redirection $args[1]; then
      # named file descriptor: {foo}>&2
      in_redirection=3
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos named-fd
      continue
    fi

    # Expand parameters.
    #
    # ### For now, expand just '$foo' or '${foo}', possibly with braces, but with
    # ### no other features of the parameter expansion syntax.  (No ${(x)foo},
    # ### no ${foo[x]}, no ${foo:-x}.)
    () {
      # That's not entirely correct --- if the parameter's value happens to be a reserved
      # word, the parameter expansion will be highlighted as a reserved word --- but that
      # incorrectness is outweighed by the usability improvement of permitting the use of
      # parameters that refer to commands, functions, and builtins.
      local -a match mbegin mend
      local MATCH; integer MBEGIN MEND
      local parameter_name
      if [[ $arg[1] == '$' ]] && [[ ${arg[2]} == '{' ]] && [[ ${arg[-1]} == '}' ]]; then
        parameter_name=${${arg:2}%?}
      elif [[ $arg[1] == '$' ]]; then
        parameter_name=${arg:1}
      fi
      if [[ $res == none ]] && zmodload -e zsh/parameter &&
         [[ ${parameter_name} =~ ^${~parameter_name_pattern}$ ]] &&
         (( ${+parameters[(e)${MATCH}]} )) && [[ ${parameters[(e)$MATCH]} != *special* ]]
         then
        # Set $arg.
        case ${(tP)MATCH} in
          (*array*|*assoc*)
            local -a words; words=( ${(P)MATCH} )
            arg=${words[1]}
            ;;
          (*)
            # scalar, presumably
            arg=${(P)MATCH}
            ;;
        esac
        _zsh_highlight_main__type "$arg" 0
        res=$REPLY
      fi
    }

    # Parse the sudo command line
    if (( ! in_redirection )); then
      if [[ $this_word == *':sudo_opt:'* ]]; then
        if [[ -n $flags_with_argument ]] &&
           { [[ -n $flags_sans_argument ]] && [[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument] ]] ||
             [[ $arg == '-'[$flags_with_argument] ]] }; then
          # Flag that requires an argument
          this_word=${this_word//:start:/}
          next_word=':sudo_arg:'
        elif [[ -n $flags_with_argument ]] &&
             { [[ -n $flags_sans_argument ]] && [[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument]* ]] ||
               [[ $arg == '-'[$flags_with_argument]* ]] }; then
          # Argument attached in the same word
          this_word=${this_word//:start:/}
          next_word+=':start:'
          next_word+=':sudo_opt:'
        elif [[ -n $flags_sans_argument ]] &&
             [[ $arg == '-'[$flags_sans_argument]# ]]; then
          # Flag that requires no argument
          this_word=':sudo_opt:'
          next_word+=':start:'
          next_word+=':sudo_opt:'
        elif [[ $arg == '-'* ]]; then
          # Unknown flag.  We don't know whether it takes an argument or not,
          # so modify $next_word as we do for flags that require no argument.
          # With that behaviour, if the flag in fact takes no argument we'll
          # highlight the inner command word correctly, and if it does take an
          # argument we'll highlight the command word correctly if the argument
          # was given in the same shell word as the flag (as in '-uphy1729' or
          # '--user=phy1729' without spaces).
          this_word=':sudo_opt:'
          next_word+=':start:'
          next_word+=':sudo_opt:'
        else
          # Not an option flag; nothing to do.  (If the command line is
          # syntactically valid, ${this_word//:sudo_opt:/} should be
          # non-empty now.)
          this_word=${this_word//:sudo_opt:/}
        fi
      elif [[ $this_word == *':sudo_arg:'* ]]; then
        next_word+=':sudo_opt:'
        next_word+=':start:'
      fi
   fi

   # The Great Fork: is this a command word?  Is this a non-command word?
   if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
     if _zsh_highlight_main__stack_pop T || _zsh_highlight_main__stack_pop Q; then
       # Missing closing square bracket(s)
       style=unknown-token
     elif [[ $this_word == *':regular:'* ]]; then
       # This highlights empty commands (semicolon follows nothing) as an error.
       # Zsh accepts them, though.
       style=commandseparator
     else
       style=unknown-token
     fi
     if [[ $arg == ';' ]] && $in_array_assignment; then
       # literal newline inside an array assignment
       next_word=':regular:'
     else
       next_word=':start:'
       highlight_glob=true
       if [[ $arg != '|' && $arg != '|&' ]]; then
         next_word+=':start_of_pipeline:'
       fi
     fi
   elif ! (( in_redirection)) && [[ $this_word == *':always:'* && $arg == 'always' ]]; then
     # try-always construct
     style=reserved-word # de facto a reserved word, although not de jure
     next_word=':start:' # only left brace is allowed, apparently
   elif ! (( in_redirection)) && [[ $this_word == *':start:'* ]]; then # $arg is the command word
     if (( ${+precommand_options[$arg]} )) && _zsh_highlight_main__is_runnable $arg; then
      style=precommand
      flags_with_argument=${precommand_options[$arg]%:*}
      flags_sans_argument=${precommand_options[$arg]#*:}
      next_word=${next_word//:regular:/}
      next_word+=':sudo_opt:'
      next_word+=':start:'
     else
      case $res in
        reserved)       # reserved word
                        style=reserved-word
                        # Match braces and handle special cases.
                        case $arg in
                          (time|nocorrect)
                            next_word=${next_word//:regular:/}
                            next_word+=':start:'
                            ;;
                          ($'\x7b')
                            braces_stack='Y'"$braces_stack"
                            ;;
                          ($'\x7d')
                            # We're at command word, so no need to check $right_brace_is_recognised_everywhere
                            _zsh_highlight_main__stack_pop 'Y' reserved-word
                            if [[ $style == reserved-word ]]; then
                              next_word+=':always:'
                            fi
                            ;;
                          ($'\x5b\x5b')
                            braces_stack='T'"$braces_stack"
                            ;;
                          ('do')
                            braces_stack='D'"$braces_stack"
                            ;;
                          ('done')
                            _zsh_highlight_main__stack_pop 'D' reserved-word
                            ;;
                          ('if')
                            braces_stack=':?'"$braces_stack"
                            ;;
                          ('then')
                            _zsh_highlight_main__stack_pop ':' reserved-word
                            ;;
                          ('elif')
                            if [[ ${braces_stack[1]} == '?' ]]; then
                              braces_stack=':'"$braces_stack"
                            else
                              style=unknown-token
                            fi
                            ;;
                          ('else')
                            if [[ ${braces_stack[1]} == '?' ]]; then
                              :
                            else
                              style=unknown-token
                            fi
                            ;;
                          ('fi')
                            _zsh_highlight_main__stack_pop '?'
                            ;;
                          ('foreach')
                            braces_stack='$'"$braces_stack"
                            ;;
                          ('end')
                            _zsh_highlight_main__stack_pop '$' reserved-word
                            ;;
                          ('repeat')
                            # skip the repeat-count word
                            in_redirection=2
                            # The redirection mechanism assumes $this_word describes the word
                            # following the redirection.  Make it so.
                            #
                            # That word can be a command word with shortloops (`repeat 2 ls`)
                            # or a command separator (`repeat 2; ls` or `repeat 2; do ls; done`).
                            #
                            # The repeat-count word will be handled like a redirection target.
                            this_word=':start::regular:'
                            ;;
                          ('!')
                            if [[ $this_word != *':start_of_pipeline:'* ]]; then
                              style=unknown-token
                            else
                              # '!' reserved word at start of pipeline; style already set above
                            fi
                            ;;
                        esac
                        ;;
        'suffix alias') style=suffix-alias;;
        alias)          :;;
        builtin)        style=builtin
                        [[ $arg == $'\x5b' ]] && braces_stack='Q'"$braces_stack"
                        ;;
        function)       style=function;;
        command)        style=command;;
        hashed)         style=hashed-command;;
        none)           if _zsh_highlight_main_highlighter_check_assign; then
                          _zsh_highlight_main_add_region_highlight $start_pos $end_pos assign
                          local i=$(( arg[(i)=] + 1 ))
                          if [[ $arg[i] == '(' ]]; then
                            in_array_assignment=true
                          else
                            # assignment to a scalar parameter.
                            # (For array assignments, the command doesn't start until the ")" token.)
                            # 
                            # Discard  :start_of_pipeline:, if present, as '!' is not valid
                            # after assignments.
                            next_word+=':start:'
                            if (( i <= $#arg )); then
                              () {
                                local highlight_glob=false
                                [[ $zsyh_user_options[globassign] == on ]] && highlight_glob=true
                                _zsh_highlight_main_highlighter_highlight_argument $i
                              }
                            fi
                          fi
                          continue
                        elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                          style=history-expansion
                        elif [[ $arg[0,1] == $histchars[2,2] ]]; then
                          style=history-expansion
                        elif [[ $arg[1,2] == '((' ]]; then
                          # Arithmetic evaluation.
                          #
                          # Note: prior to zsh-5.1.1-52-g4bed2cf (workers/36669), the ${(z)...}
                          # splitter would only output the '((' token if the matching '))' had
                          # been typed.  Therefore, under those versions of zsh, BUFFER="(( 42"
                          # would be highlighted as an error until the matching "))" are typed.
                          #
                          # We highlight just the opening parentheses, as a reserved word; this
                          # is how [[ ... ]] is highlighted, too.
                          _zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) reserved-word
                          if [[ $arg[-2,-1] == '))' ]]; then
                            _zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos reserved-word
                          fi
                          continue
                        elif [[ $arg == '()' ]]; then
                          # anonymous function
                          style=reserved-word
                        elif [[ $arg == $'\x28' ]]; then
                          # subshell
                          style=reserved-word
                          braces_stack='R'"$braces_stack"
                        elif [[ $arg == $'\x29' ]]; then
                          # end of subshell or command substitution
                          if _zsh_highlight_main__stack_pop 'S'; then
                            REPLY=$start_pos
                            reply=($list_highlights)
                            return 0
                          fi
                          _zsh_highlight_main__stack_pop 'R' reserved-word
                        else
                          if _zsh_highlight_main_highlighter_check_path $arg; then
                            style=$REPLY
                          else
                            style=unknown-token
                          fi
                        fi
                        ;;
        *)              _zsh_highlight_main_add_region_highlight $start_pos $end_pos arg0_$res
                        continue
                        ;;
      esac
     fi
     if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} ]]; then
      next_word=':start::start_of_pipeline:'
     fi
   else # $arg is a non-command word
      case $arg in
        $'\x29') # subshell or end of array assignment
                 if $in_array_assignment; then
                   style=assign
                   in_array_assignment=false
                   next_word+=':start:'
                 elif (( in_redirection )); then
                   style=unknown-token
                 else
                   if _zsh_highlight_main__stack_pop 'S'; then
                     REPLY=$start_pos
                     reply=($list_highlights)
                     return 0
                   fi
                   _zsh_highlight_main__stack_pop 'R' reserved-word
                 fi;;
        $'\x28\x29') # possibly a function definition
                 if (( in_redirection )) || $in_array_assignment; then
                   style=unknown-token
                 else
                   if [[ $zsyh_user_options[multifuncdef] == on ]] || false # TODO: or if the previous word was a command word
                   then
                     next_word+=':start::start_of_pipeline:'
                   fi
                   style=reserved-word
                 fi
                 ;;
#--[ Begining of ftype array ]------@@@@
		*.old) style=ftype-old ;;
		*.in) style=ftype-in ;;
		*.am) style=ftype-am ;;
		*.pcap) style=ftype-pcap ;;
		*.dump) style=ftype-dump ;;
		*.dmp) style=ftype-dmp ;;
		*.cap) style=ftype-cap ;;
		*.old) style=ftype-old ;;
		*.in) style=ftype-in ;;
		*.am) style=ftype-am ;;
		*.tcc) style=ftype-tcc ;;
		*.sx) style=ftype-sx ;;
		*.S) style=ftype-S ;;
		*.s) style=ftype-s ;;
		*.hxx) style=ftype-hxx ;;
		*.hpp) style=ftype-hpp ;;
		*.hh) style=ftype-hh ;;
		*.H) style=ftype-H ;;
		*.h++) style=ftype-h++ ;;
		*.h) style=ftype-h ;;
		*.ftn) style=ftype-ftn ;;
		*.for) style=ftype-for ;;
		*.f) style=ftype-f ;;
		*.el) style=ftype-el ;;
		*.clj) style=ftype-clj ;;
		*.scala) style=ftype-scala ;;
		*.pas) style=ftype-pas ;;
		*.swift) style=ftype-swift ;;
		*.rst) style=ftype-rst ;;
		*.rs) style=ftype-rs ;;
		*.ml) style=ftype-ml ;;
		*.ii) style=ftype-ii ;;
		*.go) style=ftype-go ;;
		*.erl) style=ftype-erl ;;
		*.cxx) style=ftype-cxx ;;
		*.cs) style=ftype-cs ;;
		*.cpp) style=ftype-cpp ;;
		*.cp) style=ftype-cp ;;
		*.cc) style=ftype-cc ;;
		*.C) style=ftype-C ;;
		*.c++) style=ftype-c++ ;;
		*.c) style=ftype-c ;;
		*.timer) style=ftype-timer ;;
		*.target) style=ftype-target ;;
		*.swap) style=ftype-swap ;;
		*.socket) style=ftype-socket ;;
		*.snapshot) style=ftype-snapshot ;;
		*.service) style=ftype-service ;;
		*.path) style=ftype-path ;;
		*.mount) style=ftype-mount ;;
		*.device) style=ftype-device ;;
		*.desktop) style=ftype-desktop ;;
		*.automount) style=ftype-automount ;;
		*.sms) style=ftype-sms ;;
		*.sav) style=ftype-sav ;;
		*.rom) style=ftype-rom ;;
		*.nes) style=ftype-nes ;;
		*.nds) style=ftype-nds ;;
		*.j64) style=ftype-j64 ;;
		*.ggl) style=ftype-ggl ;;
		*.gg) style=ftype-gg ;;
		*.gel) style=ftype-gel ;;
		*.gbc) style=ftype-gbc ;;
		*.gba) style=ftype-gba ;;
		*.gb) style=ftype-gb ;;
		*.fm2) style=ftype-fm2 ;;
		*.cdi) style=ftype-cdi ;;
		*.atr) style=ftype-atr ;;
		*.adf) style=ftype-adf ;;
		*.a78) style=ftype-a78 ;;
		*.A64) style=ftype-A64 ;;
		*.a64) style=ftype-a64 ;;
		*.a52) style=ftype-a52 ;;
		*.a00) style=ftype-a00 ;;
		*.32x) style=ftype-32x ;;
		*.ttf) style=ftype-ttf ;;
		*.pfb) style=ftype-pfb ;;
		*.pfa) style=ftype-pfa ;;
		*.pcf) style=ftype-pcf ;;
		*.otf) style=ftype-otf ;;
		*.gsf) style=ftype-gsf ;;
		*.fon) style=ftype-fon ;;
		*.dfont) style=ftype-dfont ;;
		*.bdf) style=ftype-bdf ;;
		*.srt) style=ftype-srt ;;
		*.ogx) style=ftype-ogx ;;
		*.axv) style=ftype-axv ;;
		*.ass) style=ftype-ass ;;
		*.anx) style=ftype-anx ;;
		*.wmv) style=ftype-wmv ;;
		*.webm) style=ftype-webm ;;
		*.VOB) style=ftype-VOB ;;
		*.vob) style=ftype-vob ;;
		*.ts) style=ftype-ts ;;
		*.sample) style=ftype-sample ;;
		*.rmvb) style=ftype-rmvb ;;
		*.rm) style=ftype-rm ;;
		*.qt) style=ftype-qt ;;
		*.ogv) style=ftype-ogv ;;
		*.ogm) style=ftype-ogm ;;
		*.nuv) style=ftype-nuv ;;
		*.mpg) style=ftype-mpg ;;
		*.mpeg) style=ftype-mpeg ;;
		*.mp4v) style=ftype-mp4v ;;
		*.mp4) style=ftype-mp4 ;;
		*.MOV) style=ftype-MOV ;;
		*.mov) style=ftype-mov ;;
		*.mkv) style=ftype-mkv ;;
		*.m4v) style=ftype-m4v ;;
		*.m2v) style=ftype-m2v ;;
		*.m2ts) style=ftype-m2ts ;;
		*.gl) style=ftype-gl ;;
		*.flv) style=ftype-flv ;;
		*.fli) style=ftype-fli ;;
		*.flc) style=ftype-flc ;;
		*.divx) style=ftype-divx ;;
		*.AVI) style=ftype-AVI ;;
		*.avi) style=ftype-avi ;;
		*.asf) style=ftype-asf ;;
		*.wvc) style=ftype-wvc ;;
		*.wv) style=ftype-wv ;;
		*.spl) style=ftype-spl ;;
		*.sid) style=ftype-sid ;;
		*.S3M) style=ftype-S3M ;;
		*.s3m) style=ftype-s3m ;;
		*.oga) style=ftype-oga ;;
		*.mod) style=ftype-mod ;;
		*.m4) style=ftype-m4 ;;
		*.fcm) style=ftype-fcm ;;
		*.dat) style=ftype-dat ;;
		*.xspf) style=ftype-xspf ;;
		*.pls) style=ftype-pls ;;
		*.m3u8) style=ftype-m3u8 ;;
		*.m3u) style=ftype-m3u ;;
		*.cue) style=ftype-cue ;;
		*.wma) style=ftype-wma ;;
		*.wav) style=ftype-wav ;;
		*.spx) style=ftype-spx ;;
		*.ra) style=ftype-ra ;;
		*.ogg) style=ftype-ogg ;;
		*.oga) style=ftype-oga ;;
		*.mpc) style=ftype-mpc ;;
		*.mp3) style=ftype-mp3 ;;
		*.mp2) style=ftype-mp2 ;;
		*.mka) style=ftype-mka ;;
		*.midi) style=ftype-midi ;;
		*.mid) style=ftype-mid ;;
		*.m4r) style=ftype-m4r ;;
		*.m4b) style=ftype-m4b ;;
		*.m4a) style=ftype-m4a ;;
		*.flac) style=ftype-flac ;;
		*.dsf) style=ftype-dsf ;;
		*.dff) style=ftype-dff ;;
		*.axa) style=ftype-axa ;;
		*.au) style=ftype-au ;;
		*.ape) style=ftype-ape ;;
		*.alac) style=ftype-alac ;;
		*.aiff) style=ftype-aiff ;;
		*.aac) style=ftype-aac ;;
		*.st5) style=ftype-st5 ;;
		*.sha1) style=ftype-sha1 ;;
		*.sfv) style=ftype-sfv ;;
		*.par) style=ftype-par ;;
		*.md5) style=ftype-md5 ;;
		*.gpg) style=ftype-gpg ;;
		*.ffp) style=ftype-ffp ;;
		*.yml) style=ftype-yml ;;
		*.yml) style=ftype-yml ;;
		*.yaml) style=ftype-yaml ;;
		*.xml) style=ftype-xml ;;
		*.ttl) style=ftype-ttl ;;
		*.torrent) style=ftype-torrent ;;
		*.toml) style=ftype-toml ;;
		*.textile) style=ftype-textile ;;
		*.tex) style=ftype-tex ;;
		*.reg) style=ftype-reg ;;
		*.rdf) style=ftype-rdf ;;
		*.rc) style=ftype-rc ;;
		*.qml) style=ftype-qml ;;
		*.owl) style=ftype-owl ;;
		*.ovpn) style=ftype-ovpn ;;
		*.nt) style=ftype-nt ;;
		*.nix) style=ftype-nix ;;
		*.nfo) style=ftype-nfo ;;
		*.n3) style=ftype-n3 ;;
		*.latex) style=ftype-latex ;;
		*.json) style=ftype-json ;;
		*.jidgo) style=ftype-jidgo ;;
		*.ini) style=ftype-ini ;;
		*.icls) style=ftype-icls ;;
		*.conf) style=ftype-conf ;;
		*.cfg) style=ftype-cfg ;;
		*.aux) style=ftype-aux ;;
		*.deny) style=ftype-deny ;;
		*.allow) style=ftype-allow ;;
		*.vcd) style=ftype-vcd ;;
		*.nrg) style=ftype-nrg ;;
		*.mdf) style=ftype-mdf ;;
		*.ISO) style=ftype-ISO ;;
		*.iso) style=ftype-iso ;;
		*.img) style=ftype-img ;;
		*.dmg) style=ftype-dmg ;;
		*.zwc) style=ftype-zwc ;;
		*.zsh) style=ftype-zsh ;;
		*.Xresources) style=ftype-Xresources ;;
		*.Xmodmap) style=ftype-Xmodmap ;;
		*.xinitrc) style=ftype-xinitrc ;;
		*.Xauthority) style=ftype-Xauthority ;;
		*.urlview) style=ftype-urlview ;;
		*.ttytterrc) style=ftype-ttytterrc ;;
		*.tcsh) style=ftype-tcsh ;;
		*.snippets) style=ftype-snippets ;;
		*.sh*) style=ftype-sh* ;;
		*.sh) style=ftype-sh ;;
		*.profile) style=ftype-profile ;;
		*.ksh) style=ftype-ksh ;;
		*.fish) style=ftype-fish ;;
		*.dash) style=ftype-dash ;;
		*.csh) style=ftype-csh ;;
		*.bash_profile) style=ftype-bash_profile ;;
		*.bash_logout) style=ftype-bash_logout ;;
		*.bash_history) style=ftype-bash_history ;;
		*.bash) style=ftype-bash ;;
		*.vimrc) style=ftype-vimrc ;;
		*.vimp) style=ftype-vimp ;;
		*.viminfo) style=ftype-viminfo ;;
		*.vim) style=ftype-vim ;;
		*.tk) style=ftype-tk ;;
		*.theme) style=ftype-theme ;;
		*.tfnt) style=ftype-tfnt ;;
		*.tfm) style=ftype-tfm ;;
		*.tdy) style=ftype-tdy ;;
		*.tdesktop-theme) style=ftype-tdesktop-theme ;;
		*.tdesktop-pallete) style=ftype-tdesktop-pallete ;;
		*.tcl) style=ftype-tcl ;;
		*.t) style=ftype-t ;;
		*.sug) style=ftype-sug ;;
		*.sty) style=ftype-sty ;;
		*.signature) style=ftype-signature ;;
		*.sed) style=ftype-sed ;;
		*.ru) style=ftype-ru ;;
		*.rc) style=ftype-rc ;;
		*.rb) style=ftype-rb ;;
		*.rasi) style=ftype-rasi ;;
		*.py) style=ftype-py ;;
		*.pod) style=ftype-pod ;;
		*.pm) style=ftype-pm ;;
		*.PL) style=ftype-PL ;;
		*.pl) style=ftype-pl ;;
		*.pid) style=ftype-pid ;;
		*.php) style=ftype-php ;;
		*.pfa) style=ftype-pfa ;;
		*.pc) style=ftype-pc ;;
		*.patch) style=ftype-patch ;;
		*.irb) style=ftype-irb ;;
		*.erb) style=ftype-erb ;;
		*.diff) style=ftype-diff ;;
		*.attheme) style=ftype-attheme ;;
		*.scss) style=ftype-scss ;;
		*.scm) style=ftype-scm ;;
		*.sass) style=ftype-sass ;;
		*.ps) style=ftype-ps ;;
		*.pacnew) style=ftype-pacnew ;;
		*.offlineimaprc) style=ftype-offlineimaprc ;;
		*.nfo) style=ftype-nfo ;;
		*.netrc) style=ftype-netrc ;;
		*.muttrc) style=ftype-muttrc ;;
		*.mutt) style=ftype-mutt ;;
		*.mtx) style=ftype-mtx ;;
		*.msmtprc) style=ftype-msmtprc ;;
		*.mi) style=ftype-mi ;;
		*.mfasl) style=ftype-mfasl ;;
		*.mf) style=ftype-mf ;;
		*.map) style=ftype-map ;;
		*.lua) style=ftype-lua ;;
		*.log) style=ftype-log ;;
		*.lisp) style=ftype-lisp ;;
		*.lesshst) style=ftype-lesshst ;;
		*.less) style=ftype-less ;;
		*.lam) style=ftype-lam ;;
		*.jsp) style=ftype-jsp ;;
		*.jsm) style=ftype-jsm ;;
		*.js) style=ftype-js ;;
		*.jnlp) style=ftype-jnlp ;;
		*.jhtm) style=ftype-jhtm ;;
		*.java) style=ftype-java ;;
		*.info) style=ftype-info ;;
		*.htoprc) style=ftype-htoprc ;;
		*.html) style=ftype-html ;;
		*.htm) style=ftype-htm ;;
		*.hs) style=ftype-hs ;;
		*.hgrc) style=ftype-hgrc ;;
		*.hgignore) style=ftype-hgignore ;;
		*.gitignore) style=ftype-gitignore ;;
		*.git) style=ftype-git ;;
		*.fonts) style=ftype-fonts ;;
		*.fehbg) style=ftype-fehbg ;;
		*.example) style=ftype-example ;;
		*.ex) style=ftype-ex ;;
		*.etx) style=ftype-etx ;;
		*.epsi) style=ftype-epsi ;;
		*.epsf) style=ftype-epsf ;;
		*.eps) style=ftype-eps ;;
		*.eps3) style=ftype-eps3 ;;
		*.eps2) style=ftype-eps2 ;;
		*.enc) style=ftype-enc ;;
		*.e) style=ftype-e ;;
		*.dir_colors) style=ftype-dir_colors ;;
		*.csv) style=ftype-csv ;;
		*.css) style=ftype-css ;;
		*.cs) style=ftype-cs ;;
		*.coffee) style=ftype-coffee ;;
		*.awk) style=ftype-awk ;;
		*.asoundrc) style=ftype-asoundrc ;;
		*.asm) style=ftype-asm ;;
		*.agda) style=ftype-agda ;;
		*.xlsx) style=ftype-xlsx ;;
		*.xlsm) style=ftype-xlsm ;;
		*.xls) style=ftype-xls ;;
		*.xla) style=ftype-xla ;;
		*.txt) style=ftype-txt ;;
		*.sqlite) style=ftype-sqlite ;;
		*.sql) style=ftype-sql ;;
		*.rtf) style=ftype-rtf ;;
		*.pptx) style=ftype-pptx ;;
		*.ppt) style=ftype-ppt ;;
		*.pdf) style=ftype-pdf ;;
		*.pages) style=ftype-pages ;;
		*.org) style=ftype-org ;;
		*.odt) style=ftype-odt ;;
		*.ods) style=ftype-ods ;;
		*.odp) style=ftype-odp ;;
		*.odm) style=ftype-odm ;;
		*.odb) style=ftype-odb ;;
		*.odb) style=ftype-odb ;;
		*.mobi) style=ftype-mobi ;;
		*.mkd) style=ftype-mkd ;;
		*.mfasl) style=ftype-mfasl ;;
		*.mf) style=ftype-mf ;;
		*.mdf) style=ftype-mdf ;;
		*.mdb) style=ftype-mdb ;;
		*.md) style=ftype-md ;;
		*.markdown) style=ftype-markdown ;;
		*.lit) style=ftype-lit ;;
		*.ldf) style=ftype-ldf ;;
		*.gnumeric) style=ftype-gnumeric ;;
		*.fb2) style=ftype-fb2 ;;
		*.epub) style=ftype-epub ;;
		*.dvi) style=ftype-dvi ;;
		*.dotm) style=ftype-dotm ;;
		*.dot) style=ftype-dot ;;
		*.docx) style=ftype-docx ;;
		*.docm) style=ftype-docm ;;
		*.doc) style=ftype-doc ;;
		*.djvu) style=ftype-djvu ;;
		*.djv) style=ftype-djv ;;
		*.db) style=ftype-db ;;
		*.chrt) style=ftype-chrt ;;
		*.chm) style=ftype-chm ;;
		*.cbz) style=ftype-cbz ;;
		*.tmp) style=ftype-tmp ;;
		*.temp) style=ftype-temp ;;
		*.swp) style=ftype-swp ;;
		*.pyc) style=ftype-pyc ;;
		*.part) style=ftype-part ;;
		*.o) style=ftype-o ;;
		*.log) style=ftype-log ;;
		*.incomplete) style=ftype-incomplete ;;
		*.class) style=ftype-class ;;
		*.cache) style=ftype-cache ;;
		*.blg) style=ftype-blg ;;
		*.bck) style=ftype-bck ;;
		*.bbl) style=ftype-bbl ;;
		*.bak) style=ftype-bak ;;
		*.aux) style=ftype-aux ;;
		*.added) style=ftype-added ;;
		*.pub) style=ftype-pub ;;
		*.pem) style=ftype-pem ;;
		*.key) style=ftype-key ;;
		*.ico) style=ftype-ico ;;
		*.icns) style=ftype-icns ;;
		*.gif) style=ftype-gif ;;
		*.yuv) style=ftype-yuv ;;
		*.xwd) style=ftype-xwd ;;
		*.xcf) style=ftype-xcf ;;
		*.webp) style=ftype-webp ;;
		*.svgz) style=ftype-svgz ;;
		*.svg) style=ftype-svg ;;
		*.png) style=ftype-png ;;
		*.pcx) style=ftype-pcx ;;
		*.mng) style=ftype-mng ;;
		*.eps) style=ftype-eps ;;
		*.emf) style=ftype-emf ;;
		*.dl) style=ftype-dl ;;
		*.CR2) style=ftype-CR2 ;;
		*.cgm) style=ftype-cgm ;;
		*.bpg) style=ftype-bpg ;;
		*.xpm) style=ftype-xpm ;;
		*.tiff) style=ftype-tiff ;;
		*.tif) style=ftype-tif ;;
		*.xbm) style=ftype-xbm ;;
		*.tga) style=ftype-tga ;;
		*.psd) style=ftype-psd ;;
		*.ppm) style=ftype-ppm ;;
		*.pgm) style=ftype-pgm ;;
		*.pbm) style=ftype-pbm ;;
		*.indd) style=ftype-indd ;;
		*.bmp) style=ftype-bmp ;;
		*.JPG) style=ftype-JPG ;;
		*.jpg) style=ftype-jpg ;;
		*.jpeg) style=ftype-jpeg ;;
		*.vmdk) style=ftype-vmdk ;;
		*.vdi) style=ftype-vdi ;;
		*.qcow2) style=ftype-qcow2 ;;
		*.qcow) style=ftype-qcow ;;
		*.xpi) style=ftype-xpi ;;
		*.war) style=ftype-war ;;
		*.udeb) style=ftype-udeb ;;
		*.sar) style=ftype-sar ;;
		*.rpm) style=ftype-rpm ;;
		*.pkg) style=ftype-pkg ;;
		*.msi) style=ftype-msi ;;
		*.jar) style=ftype-jar ;;
		*.jad) style=ftype-jad ;;
		*.gem) style=ftype-gem ;;
		*.egg) style=ftype-egg ;;
		*.ear) style=ftype-ear ;;
		*.deb) style=ftype-deb ;;
		*.cab) style=ftype-cab ;;
		*.arj) style=ftype-arj ;;
		*.apk) style=ftype-apk ;;
		*.zoo) style=ftype-zoo ;;
		*.ZIP) style=ftype-ZIP ;;
		*.zip) style=ftype-zip ;;
		*.Z) style=ftype-Z ;;
		*.z) style=ftype-z ;;
		*.xz) style=ftype-xz ;;
		*.tzo) style=ftype-tzo ;;
		*.tz) style=ftype-tz ;;
		*.txz) style=ftype-txz ;;
		*.tlz) style=ftype-tlz ;;
		*.tgz) style=ftype-tgz ;;
		*.tbz2) style=ftype-tbz2 ;;
		*.tbz) style=ftype-tbz ;;
		*.taz) style=ftype-taz ;;
		*.tar) style=ftype-tar ;;
		*.t7z) style=ftype-t7z ;;
		*.rz) style=ftype-rz ;;
		*.rar) style=ftype-rar ;;
		*.lzma) style=ftype-lzma ;;
		*.lzh) style=ftype-lzh ;;
		*.lz4) style=ftype-lz4 ;;
		*.lz) style=ftype-lz ;;
		*.lrz) style=ftype-lrz ;;
		*.lha) style=ftype-lha ;;
		*.klwp) style=ftype-klwp ;;
		*.gz) style=ftype-gz ;;
		*.dz) style=ftype-dz ;;
		*.cpio) style=ftype-cpio ;;
		*.bz2) style=ftype-bz2 ;;
		*.bz) style=ftype-bz ;;
		*.arj) style=ftype-arj ;;
		*.arc) style=ftype-arc ;;
		*.alz) style=ftype-alz ;;
		*.alp) style=ftype-alp ;;
		*.ace) style=ftype-ace ;;
		*.7z) style=ftype-7z ;;
		*.cmd) style=ftype-cmd ;;
		*.bat) style=ftype-bat ;;
		*.exe) style=ftype-exe ;;
		*.com) style=ftype-com ;;
		*.btm) style=ftype-btm ;;
		*.bin) style=ftype-bin ;;
#--[ End of ftype array ]------@@@@
        *)       if false; then
                 elif [[ $arg = $'\x7d' ]] && $right_brace_is_recognised_everywhere; then
                   # Parsing rule: {
                   #
                   #     Additionally, `tt(})' is recognized in any position if neither the
                   #     tt(IGNORE_BRACES) option nor the tt(IGNORE_CLOSE_BRACES) option is set.
                   if (( in_redirection )) || $in_array_assignment; then
                     style=unknown-token
                   else
                     _zsh_highlight_main__stack_pop 'Y' reserved-word
                     if [[ $style == reserved-word ]]; then
                       next_word+=':always:'
                     fi
                   fi
                 elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                   style=history-expansion
                 elif [[ $arg == $'\x5d\x5d' ]] && _zsh_highlight_main__stack_pop 'T' reserved-word; then
                   :
                 elif [[ $arg == $'\x5d' ]] && _zsh_highlight_main__stack_pop 'Q' builtin; then
                   :
                 else
                   _zsh_highlight_main_highlighter_highlight_argument 1 $(( 1 != in_redirection ))
                   continue
                 fi
                 ;;
      esac
    fi
    _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
  done
  (( in_alias == 1 )) && in_alias=0 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
  [[ "$proc_buf" = (#b)(#s)(([[:space:]]|\\$'\n')#) ]]
  REPLY=$(( end_pos + ${#match[1]} - 1 ))
  reply=($list_highlights)
  return $(( $#braces_stack > 0 ))
}

# Check if $arg is variable assignment
_zsh_highlight_main_highlighter_check_assign()
{
    setopt localoptions extended_glob
    [[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]] ||
      [[ $arg == [0-9]##(|[+])=* ]]
}

_zsh_highlight_main_highlighter_highlight_path_separators()
{
  local pos style_pathsep
  style_pathsep=$1_pathseparator
  reply=()
  [[ -z "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" || "$ZSH_HIGHLIGHT_STYLES[$1]" == "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" ]] && return 0
  for (( pos = start_pos; $pos <= end_pos; pos++ )) ; do
    if [[ $BUFFER[pos] == / ]]; then
      reply+=($((pos - 1)) $pos $style_pathsep)
    fi
  done
}

# Check if $1 is a path.
# If yes, return 0 and in $REPLY the style to use.
# Else, return non-zero (and the contents of $REPLY is undefined).
_zsh_highlight_main_highlighter_check_path()
{
  _zsh_highlight_main_highlighter_expand_path "$1"
  local expanded_path="$REPLY" tmp_path

  REPLY=path

  # [[ -d $expanded_path ]] && return 0
  [[ -z $expanded_path ]] && return 1
  [[ -L $expanded_path ]] && return 0
  [[ -e $expanded_path ]] && return 0

  # Check if this is a blacklisted path
  if [[ $expanded_path[1] == / ]]; then
    tmp_path=$expanded_path
  else
    tmp_path=$PWD/$expanded_path
  fi
  tmp_path=$tmp_path:a

  while [[ $tmp_path != / ]]; do
    [[ -n "${(M)X_ZSH_HIGHLIGHT_DIRS_BLACKLIST:#$tmp_path}" ]] && return 1
    tmp_path=$tmp_path:h
  done

  # Search the path in CDPATH
  local cdpath_dir
  for cdpath_dir in $cdpath ; do
    [[ -e "$cdpath_dir/$expanded_path" ]] && return 0
  done

  # If dirname($1) doesn't exist, neither does $1.
  [[ ! -d ${expanded_path:h} ]] && return 1

  # If this word ends the buffer, check if it's the prefix of a valid path.
  if (( has_end && (len == end_pos) )) &&
     [[ $WIDGET != zle-line-finish ]]; then
    local -a tmp
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && REPLY=path_prefix && return 0
  fi

  # It's not a path.
  return 1
}

# Highlight an argument and possibly special chars in quotes starting at $1 in $arg
# This command will at least highlight $1 to end_pos with the default style
# If $2 is set to 0, the argument cannot be highlighted as an option.
_zsh_highlight_main_highlighter_highlight_argument()
{
  local base_style=default i=$1 option_eligible=${2:-1} path_eligible=1 ret start style
  local -a highlights

  local -a match mbegin mend
  local MATCH; integer MBEGIN MEND

  case "$arg[i]" in
    '%')
      if [[ $arg[i+1] == '?' ]]; then
        (( i += 2 ))
      fi
      ;;
    '-')
      if (( option_eligible )); then
        if [[ $arg[i+1] == - ]]; then
          base_style=double-hyphen-option
        else
          base_style=single-hyphen-option
        fi
        path_eligible=0
      fi
      ;;
    '=')
      if [[ $arg[i+1] == $'\x28' ]]; then
        (( i += 2 ))
        _zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
        ret=$?
        (( i += REPLY ))
        highlights+=(
          $(( start_pos + $1 - 1 )) $(( start_pos + i )) process-substitution
          $(( start_pos + $1 - 1 )) $(( start_pos + $1 + 1 )) process-substitution-delimiter
          $reply
        )
        if (( ret == 0 )); then
          highlights+=($(( start_pos + i - 1 )) $(( start_pos + i )) process-substitution-delimiter)
        fi
      fi
  esac

  for (( ; i <= $#arg ; i += 1 )); do
    case "$arg[$i]" in
      "\\") (( i += 1 )); continue;;
      "'")
        _zsh_highlight_main_highlighter_highlight_single_quote $i
        (( i = REPLY ))
        highlights+=($reply)
        ;;
      '"')
        _zsh_highlight_main_highlighter_highlight_double_quote $i
        (( i = REPLY ))
        highlights+=($reply)
        ;;
      '`')
        _zsh_highlight_main_highlighter_highlight_backtick $i
        (( i = REPLY ))
        highlights+=($reply)
        ;;
      '$')
        if [[ $arg[i+1] != "'" ]]; then
          path_eligible=0
        fi
        if [[ $arg[i+1] == "'" ]]; then
          _zsh_highlight_main_highlighter_highlight_dollar_quote $i
          (( i = REPLY ))
          highlights+=($reply)
          continue
       elif [[ $arg[i+1] == $'\x28' ]]; then
          start=$i
          (( i += 2 ))
          _zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
          ret=$?
          (( i += REPLY ))
          highlights+=(
            $(( start_pos + start - 1)) $(( start_pos + i )) command-substitution-unquoted
            $(( start_pos + start - 1)) $(( start_pos + start + 1)) command-substitution-delimiter-unquoted
            $reply
          )
          if (( ret == 0 )); then
            highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) command-substitution-delimiter-unquoted)
          fi
          continue
        fi
        while [[ $arg[i+1] == [\^=~#+] ]]; do
          (( i += 1 ))
        done
        if [[ $arg[i+1] == [*@#?$!-] ]]; then
          (( i += 1 ))
        fi;;
      [\<\>])
        if [[ $arg[i+1] == $'\x28' ]]; then # \x28 = open paren
          start=$i
          (( i += 2 ))
          _zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
          ret=$?
          (( i += REPLY ))
          highlights+=(
            $(( start_pos + start - 1)) $(( start_pos + i )) process-substitution
            $(( start_pos + start - 1)) $(( start_pos + start + 1 )) process-substitution-delimiter
            $reply
          )
          if (( ret == 0 )); then
            highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) process-substitution-delimiter)
          fi
          continue
        fi
        ;|
      *)
        if $highlight_glob && [[ ${arg[$i]} =~ ^[*?] || ${arg:$i-1} =~ ^\<[0-9]*-[0-9]*\> ]]; then
          highlights+=($(( start_pos + i - 1 )) $(( start_pos + i + $#MATCH - 1)) globbing)
          (( i += $#MATCH - 1 ))
          path_eligible=0
        else
          continue
        fi
        ;;
    esac
  done

  if (( path_eligible )) && _zsh_highlight_main_highlighter_check_path $arg[$1,-1]; then
    base_style=$REPLY
    _zsh_highlight_main_highlighter_highlight_path_separators $base_style
    highlights+=($reply)
  fi

  highlights=($(( start_pos + $1 - 1 )) $end_pos $base_style $highlights)
  _zsh_highlight_main_add_many_region_highlights $highlights
}

# Quote Helper Functions
#
# $arg is expected to be set to the current argument
# $start_pos is expected to be set to the start of $arg in $BUFFER
# $1 is the index in $arg which starts the quote
# $REPLY is returned as the end of quote index in $arg
# $reply is returned as an array of region_highlight additions

# Highlight single-quoted strings
_zsh_highlight_main_highlighter_highlight_single_quote()
{
  local arg1=$1 i q=\' style
  i=$arg[(ib:arg1+1:)$q]
  reply=()

  if [[ $zsyh_user_options[rcquotes] == on ]]; then
    while [[ $arg[i+1] == "'" ]]; do
      reply+=($(( start_pos + i - 1 )) $(( start_pos + i + 1 )) rc-quote)
      (( i++ ))
      i=$arg[(ib:i+1:)$q]
    done
  fi

  if [[ $arg[i] == "'" ]]; then
    style=single-quoted-argument
  else
    # If unclosed, i points past the end
    (( i-- ))
    style=single-quoted-argument-unclosed
  fi
  reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style $reply)
  REPLY=$i
}

# Highlight special chars inside double-quoted strings
_zsh_highlight_main_highlighter_highlight_double_quote()
{
  local -a breaks match mbegin mend saved_reply
  local MATCH; integer last_break=$(( start_pos + $1 - 1 )) MBEGIN MEND
  local i j k ret style
  reply=()

  for (( i = $1 + 1 ; i <= $#arg ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      '"') break;;
      '`') saved_reply=($reply)
           _zsh_highlight_main_highlighter_highlight_backtick $i
           (( i = REPLY ))
           reply=($saved_reply $reply)
           continue
           ;;
      '$' ) style=dollar-double-quoted-argument
            # Look for an alphanumeric parameter name.
            if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]] ; then
              (( k += $#MATCH )) # highlight the parameter name
              (( i += $#MATCH )) # skip past it
            elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]] ; then
              (( k += $#MATCH )) # highlight the parameter name and braces
              (( i += $#MATCH )) # skip past it
            elif [[ $arg[i+1] == '$' ]]; then
              # $$ - pid
              (( k += 1 )) # highlight both dollar signs
              (( i += 1 )) # don't consider the second one as introducing another parameter expansion
            elif [[ $arg[i+1] == [-#*@?] ]]; then
              # $#, $*, $@, $?, $- - like $$ above
              (( k += 1 )) # highlight both dollar signs
              (( i += 1 )) # don't consider the second one as introducing another parameter expansion
            elif [[ $arg[i+1] == $'\x28' ]]; then
              breaks+=( $last_break $(( start_pos + i - 1 )) )
              (( i += 2 ))
              saved_reply=($reply)
              _zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
              ret=$?
              (( i += REPLY ))
              last_break=$(( start_pos + i ))
              reply=(
                $saved_reply
                $j $(( start_pos + i )) command-substitution-quoted
                $j $(( j + 2 )) command-substitution-delimiter-quoted
                $reply
              )
              if (( ret == 0 )); then
                reply+=($(( start_pos + i - 1 )) $(( start_pos + i )) command-substitution-delimiter-quoted)
              fi
              continue
            else
              continue
            fi
            ;;
      "\\") style=back-double-quoted-argument
            if [[ \\\`\"\$${histchars[1]} == *$arg[$i+1]* ]]; then
              (( k += 1 )) # Color following char too.
              (( i += 1 )) # Skip parsing the escaped char.
            else
              continue
            fi
            ;;
      ($histchars[1]) # ! - may be a history expansion
            if [[ $arg[i+1] != ('='|$'\x28'|$'\x7b'|[[:blank:]]) ]]; then
              style=history-expansion
            else
              continue
            fi
            ;;
      *) continue ;;

    esac
    reply+=($j $k $style)
  done

  if [[ $arg[i] == '"' ]]; then
    style=double-quoted-argument
  else
    # If unclosed, i points past the end
    (( i-- ))
    style=double-quoted-argument-unclosed
  fi
  (( last_break != start_pos + i )) && breaks+=( $last_break $(( start_pos + i )) )
  saved_reply=($reply)
  reply=()
  for 1 2 in $breaks; do
    (( $1 != $2 )) && reply+=($1 $2 $style)
  done
  reply+=($saved_reply)
  REPLY=$i
}

# Highlight special chars inside dollar-quoted strings
_zsh_highlight_main_highlighter_highlight_dollar_quote()
{
  local -a match mbegin mend
  local MATCH; integer MBEGIN MEND
  local i j k style
  local AA
  integer c
  reply=()

  for (( i = $1 + 2 ; i <= $#arg ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      "'") break;;
      "\\") style=back-dollar-quoted-argument
            for (( c = i + 1 ; c <= $#arg ; c += 1 )); do
              [[ "$arg[$c]" != ([0-9xXuUa-fA-F]) ]] && break
            done
            AA=$arg[$i+1,$c-1]
            # Matching for HEX and OCT values like \0xA6, \xA6 or \012
            if [[    "$AA" =~ "^(x|X)[0-9a-fA-F]{1,2}"
                  || "$AA" =~ "^[0-7]{1,3}"
                  || "$AA" =~ "^u[0-9a-fA-F]{1,4}"
                  || "$AA" =~ "^U[0-9a-fA-F]{1,8}"
               ]]; then
              (( k += $#MATCH ))
              (( i += $#MATCH ))
            else
              if (( $#arg > $i+1 )) && [[ $arg[$i+1] == [xXuU] ]]; then
                # \x not followed by hex digits is probably an error
                style=unknown-token
              fi
              (( k += 1 )) # Color following char too.
              (( i += 1 )) # Skip parsing the escaped char.
            fi
            ;;
      *) continue ;;

    esac
    reply+=($j $k $style)
  done

  if [[ $arg[i] == "'" ]]; then
    style=dollar-quoted-argument
  else
    # If unclosed, i points past the end
    (( i-- ))
    style=dollar-quoted-argument-unclosed
  fi
  reply=($(( start_pos + $1 - 1 )) $(( start_pos + i )) $style $reply)
  REPLY=$i
}

# Highlight backtick substitutions
_zsh_highlight_main_highlighter_highlight_backtick()
{
  # buf is the contents of the backticks with a layer of backslashes removed.
  # last is the index of arg for the start of the string to be copied into buf.
  #     It is either one past the beginning backtick or one past the last backslash.
  # offset is a count of consumed \ (the delta between buf and arg).
  # offsets is an array indexed by buf offset of when the delta between buf and arg changes.
  #     It is sparse, so search backwards to the last value
  local buf highlight style=back-quoted-argument-unclosed style_end
  local -i arg1=$1 end_ i=$1 last offset=0 start subshell_has_end=0
  local -a highlight_zone highlights offsets
  reply=()

  last=$(( arg1 + 1 ))
  # Remove one layer of backslashes and find the end
  while i=$arg[(ib:i+1:)[\\\\\`]]; do # find the next \ or `
    if (( i > $#arg )); then
      buf=$buf$arg[last,i]
      offsets[i-arg1-offset]='' # So we never index past the end
      (( i-- ))
      subshell_has_end=$(( has_end && (start_pos + i == len) ))
      break
    fi

    if [[ $arg[i] == '\' ]]; then
      (( i++ ))
      # POSIX XCU 2.6.3
      if [[ $arg[i] == ('$'|'`'|'\') ]]; then
        buf=$buf$arg[last,i-2]
        (( offset++ ))
        # offsets is relative to buf, so adjust by -arg1
        offsets[i-arg1-offset]=$offset
      else
        buf=$buf$arg[last,i-1]
      fi
    else # it's an unquoted ` and this is the end
      style=back-quoted-argument
      style_end=back-quoted-argument-delimiter
      buf=$buf$arg[last,i-1]
      offsets[i-arg1-offset]='' # So we never index past the end
      break
    fi
    last=$i
  done

  _zsh_highlight_main_highlighter_highlight_list 0 '' $subshell_has_end $buf

  # Munge the reply to account for removed backslashes
  for start end_ highlight in $reply; do
    start=$(( start_pos + arg1 + start + offsets[(Rb:start:)?*] ))
    end_=$(( start_pos + arg1 + end_ + offsets[(Rb:end_:)?*] ))
    highlights+=($start $end_ $highlight)
    if [[ $highlight == back-quoted-argument-unclosed && $style == back-quoted-argument ]]; then
      # An inner backtick command substitution is unclosed, but this level is closed
      style_end=unknown-token
    fi
  done

  reply=(
    $(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style
    $(( start_pos + arg1 - 1 )) $(( start_pos + arg1 )) back-quoted-argument-delimiter
    $highlights
  )
  if (( $#style_end )); then
    reply+=($(( start_pos + i - 1)) $(( start_pos + i )) $style_end)
  fi
  REPLY=$i
}

# Called with a single positional argument.
# Perform filename expansion (tilde expansion) on the argument and set $REPLY to the expanded value.
#
# Does not perform filename generation (globbing).
_zsh_highlight_main_highlighter_expand_path()
{
  (( $# == 1 )) || print -r -- >&2 "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument"

  # The $~1 syntax normally performs filename generation, but not when it's on the right-hand side of ${x:=y}.
  setopt localoptions nonomatch
  unset REPLY
  : ${REPLY:=${(Q)${~1}}}
}

# -------------------------------------------------------------------------------------------------
# Main highlighter initialization
# -------------------------------------------------------------------------------------------------

_zsh_highlight_main__precmd_hook() {
  _zsh_highlight_main__command_type_cache=()
}

autoload -Uz add-zsh-hook
if add-zsh-hook precmd _zsh_highlight_main__precmd_hook 2>/dev/null; then
  # Initialize command type cache
  typeset -gA _zsh_highlight_main__command_type_cache
else
  print -r -- >&2 'zsh-syntax-highlighting: Failed to load add-zsh-hook. Some speed optimizations will not be used.'
  # Make sure the cache is unset
  unset _zsh_highlight_main__command_type_cache
fi
typeset -ga ZSH_HIGHLIGHT_DIRS_BLACKLIST

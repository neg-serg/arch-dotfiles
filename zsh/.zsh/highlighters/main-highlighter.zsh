#!/bin/zsh

ZSH_HIGHLIGHT_STYLES+=(
    default                         none
    unknown-token                   none
    suffix-alias                    fg=green,underline
    reserved-word                   fg=004
    alias                           fg=green
    builtin                         fg=green
    function                        fg=green,underline
    command                         fg=green

    precommand                      fg=green,underline 
    path                            fg=white
    path_prefix                     none
    path_approx                     fg=white
    # path_pathseparator
    # path_prefix_pathseparator

    hashed-command                  fg=green
    globbing                        fg=110
    history-expansion               fg=blue
    single-hyphen-option            fg=244
    double-hyphen-option            fg=244
    comment                         fg=221
    arg0                            fg=green
    rc-quote                        cyan
    # redirection                   none
    # commandseparator              none

    back-quoted-argument            fg=024,bold
    single-quoted-argument          fg=024
    double-quoted-argument          fg=024
    dollar-double-quoted-argument   fg=004,bold
    back-double-quoted-argument     fg=024,bold
    back-dollar-quoted-argument     fg=024,bold
    assign                          fg=222,bold
)
ZSH_HIGHLIGHT_STYLES+=($(< ~/.zsh/highlighters/ft_list.zsh))

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

  if (( $+argv[2] )); then
    # Caller specified inheritance explicitly.
  else
    # Automate inheritance.
    typeset -A fallback_of; fallback_of=(
        alias arg0
        suffix-alias arg0
        builtin arg0
        function arg0
        command arg0
        precommand arg0
        hashed-command arg0
        path_prefix path
        # The path separator fallback won't ever be used, due to the optimisation
        # in _zsh_highlight_main_highlighter_highlight_path_separators().
        path_pathseparator path
        path_prefix_pathseparator path_prefix

        single-quoted-argument{-unclosed,}
        double-quoted-argument{-unclosed,}
        dollar-single-quoted-argument{-unclosed,}
        back-quoted-argument{-unclosed,}
    )
    local needle=$1 value
    while [[ -n ${value::=$fallback_of[$needle]} ]]; do
      unset "fallback_of[$needle]" # paranoia against infinite loops
      argv+=($value)
      needle=$value
    done
  fi

  # The calculation was relative to $PREBUFFER$BUFFER, but region_highlight is
  # relative to $BUFFER.
  (( start -= $#PREBUFFER ))
  (( end -= $#PREBUFFER ))

  (( start >= end )) && { print -r -- >&2 "zsh-syntax-highlighting: BUG: _zsh_highlight_main_add_region_highlight: start($start) >= end($end)"; return }
  (( end <= 0 )) && return
  (( start < 0 )) && start=0 # having start<0 is normal with e.g. multiline strings
  _zsh_highlight_add_highlight $start $end "$@"
}

_zsh_highlight_main_add_many_region_highlights() {
  for 1 2 3; do
    _zsh_highlight_main_add_region_highlight $1 $2 $3
  done
}

# Get the type of a command.
#
# Uses the zsh/parameter module if available to avoid forks, and a
# wrapper around 'type -w' as fallback.
#
# Takes a single argument.
#
# The result will be stored in REPLY.
_zsh_highlight_main__type() {
  if (( $+_zsh_highlight_main__command_type_cache )); then
    REPLY=$_zsh_highlight_main__command_type_cache[(e)$1]
    if [[ -n "$REPLY" ]]; then
      return
    fi
  fi
  if (( $#options_to_set )); then
    setopt localoptions $options_to_set;
  fi
  unset REPLY
  if zmodload -e zsh/parameter; then
    if (( $+aliases[(e)$1] )); then
      REPLY=alias
    elif (( $+saliases[(e)${1##*.}] )); then
      REPLY='suffix alias'
    elif (( $reswords[(Ie)$1] )); then
      REPLY=reserved
    elif (( $+functions[(e)$1] )); then
      REPLY=function
    elif (( $+builtins[(e)$1] )); then
      REPLY=builtin
    elif (( $+commands[(e)$1] )); then
      REPLY=command
    # zsh 5.2 and older have a bug whereby running 'type -w ./sudo' implicitly
    # runs 'hash ./sudo=/usr/local/bin/./sudo' (assuming /usr/local/bin/sudo
    # exists and is in $PATH).  Avoid triggering the bug, at the expense of
    # falling through to the $() below, incurring a fork.  (Issue #354.)
    #
    # The first disjunct mimics the isrelative() C call from the zsh bug.
    elif {  [[ $1 != */* ]] || is-at-least 5.3 } &&
         ! builtin type -w -- $1 >/dev/null 2>&1; then
      REPLY=none
    fi
  fi
  if ! (( $+REPLY )); then
    # Note that 'type -w' will run 'rehash' implicitly.
    REPLY="${$(LC_ALL=C builtin type -w -- $1 2>/dev/null)##*: }"
  fi
  if (( $+_zsh_highlight_main__command_type_cache )); then
    _zsh_highlight_main__command_type_cache[(e)$1]=$REPLY
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
# $2: assignment to execute it if matches
_zsh_highlight_main__stack_pop() {
  if [[ $braces_stack[1] == $1 ]]; then
    braces_stack=${braces_stack:1}
    eval "$2"
  else
    style=unknown-token
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

  ## Variable declarations and initializations
  local start_pos=0 end_pos highlight_glob=true arg style
  local in_array_assignment=false # true between 'a=(' and the matching ')'
  typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
  typeset -a ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
  typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
  local -a options_to_set # used in callees
  local buf="$PREBUFFER$BUFFER"
  integer len="${#buf}"
  integer pure_buf_len=$(( len - ${#PREBUFFER} ))   # == $#BUFFER, used e.g. in *_check_path

  # "R" for round
  # "Q" for square
  # "Y" for curly
  # "D" for do/done
  # "$" for 'end' (matches 'foreach' always; also used with cshjunkiequotes in repeat/while)
  # "?" for 'if'/'fi'; also checked by 'elif'/'else'
  # ":" for 'then'
  local braces_stack

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
    ';;' ';&' ';|'
  )
  ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS=(
    'builtin' 'command' 'exec' 'nocorrect' 'noglob' 'sudo' 's'
    'pkexec' # immune to #121 because it's usually not passed --option flags
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

  local -a match mbegin mend

  # State machine
  #
  # The states are:
  # - :start:      Command word
  # - :sudo_opt:   A leading-dash option to sudo (such as "-u" or "-i")
  # - :sudo_arg:   The argument to a sudo leading-dash option that takes one,
  #                when given as a separate word; i.e., "foo" in "-u foo" (two
  #                words) but not in "-ufoo" (one word).
  # - :regular:    "Not a command word", and command delimiters are permitted.
  #                Mainly used to detect premature termination of commands.
  # - :always:     The word 'always' in the «{ foo } always { bar }» syntax.
  #
  # When the kind of a word is not yet known, $this_word / $next_word may contain
  # multiple states.  For example, after "sudo -i", the next word may be either
  # another --flag or a command name, hence the state would include both :start:
  # and :sudo_opt:.
  #
  # The tokens are always added with both leading and trailing colons to serve as
  # word delimiters (an improvised array); [[ $x == *:foo:* ]] and x=${x//:foo:/}
  # will DTRT regardless of how many elements or repetitions $x has..
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
  local this_word=':start:' next_word
  integer in_redirection
  # Processing buffer
  local proc_buf="$buf"
  local -a args
  if [[ $zsyh_user_options[interactivecomments] == on ]]; then
    args=(${(zZ+c+)buf})
  else
    args=(${(z)buf})
  fi
  for arg in $args; do
    # Initialize $next_word.
    if (( in_redirection )); then
      (( --in_redirection ))
    fi
    if (( in_redirection == 0 )); then
      # Initialize $next_word to its default value.
      next_word=':regular:'
    else
      # Stall $next_word.
    fi

    # Initialize per-"simple command" [zshmisc(1)] variables:
    #
    #   $already_added       (see next paragraph)
    #   $style               how to highlight $arg
    #   $in_array_assignment boolean flag for "between '(' and ')' of array assignment"
    #   $highlight_glob      boolean flag for "'noglob' is in effect"
    #
    # $already_added is set to 1 to disable adding an entry to region_highlight
    # for this iteration.  Currently, that is done for "" and $'' strings,
    # which add the entry early so escape sequences within the string override
    # the string's color.
    integer already_added=0
    style=unknown-token
    if [[ $this_word == *':start:'* ]]; then
      in_array_assignment=false
      if [[ $arg == 'noglob' ]]; then
        highlight_glob=false
      fi
    fi

    # Compute the new $start_pos and $end_pos, skipping over whitespace in $buf.
    if [[ $arg == ';' ]] ; then
      # We're looking for either a semicolon or a newline, whichever comes
      # first.  Both of these are rendered as a ";" (SEPER) by the ${(z)..}
      # flag.
      #
      # We can't use the (Z+n+) flag because that elides the end-of-command
      # token altogether, so 'echo foo\necho bar' (two commands) becomes
      # indistinguishable from 'echo foo echo bar' (one command with three
      # words for arguments).
      local needle=$'[;\n]'
      integer offset=$(( ${proc_buf[(i)$needle]} - 1 ))
      (( start_pos += offset ))
      (( end_pos = start_pos + $#arg ))
    else
      # The line was:
      #
      # integer offset=$(((len-start_pos)-${#${proc_buf##([[:space:]]|\\[[:space:]])#}}))
      #
      # - len-start_pos is length of current proc_buf; basically: initial length minus where
      #   we are, and proc_buf is chopped to the "where we are" (compare the "previous value
      #   of start_pos" below, and the len-(start_pos-offset) = len-start_pos+offset)
      # - what's after main minus sign is: length of proc_buf without spaces at the beginning
      # - so what the line actually did, was computing length of the spaces!
      # - this can be done via (#b) flag, like below
      if [[ "$proc_buf" = (#b)(#s)(([[:space:]]|\\[[:space:]])##)* ]]; then
          # The first, outer parenthesis
          integer offset="${#match[1]}"
      else
          integer offset=0
      fi
      ((start_pos+=offset))
      ((end_pos=$start_pos+${#arg}))
    fi

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
      already_added=1
      start_pos=$end_pos
      continue
    fi

    # Analyse the current word.
    if _zsh_highlight_main__is_redirection $arg ; then
      if (( in_redirection )); then
        _zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
        already_added=1
      else
        in_redirection=2
      fi
    fi

    # Special-case the first word after 'sudo'.
    if (( ! in_redirection )); then
      if [[ $this_word == *':sudo_opt:'* ]] && [[ $arg != -* ]]; then
        this_word=${this_word//:sudo_opt:/}
      fi
    fi

    # Parse the sudo command line
    if (( ! in_redirection )); then
      if [[ $this_word == *':sudo_opt:'* ]]; then
        case "$arg" in
          # Flag that requires an argument
          '-'[Cgprtu]) this_word=${this_word//:start:/};
                       next_word=':sudo_arg:';;
          # This prevents misbehavior with sudo -u -otherargument
          '-'*)        this_word=${this_word//:start:/};
                       next_word+=':start:';
                       next_word+=':sudo_opt:';;
          *)           ;;
        esac
      elif [[ $this_word == *':sudo_arg:'* ]]; then
        next_word+=':sudo_opt:'
        next_word+=':start:'
      fi
   fi

   # The Great Fork: is this a command word?  Is this a non-command word?
   if [[ $this_word == *':always:'* && $arg == 'always' ]]; then
     # try-always construct
     style=reserved-word # de facto a reserved word, although not de jure
     next_word=':start:'
   elif [[ $this_word == *':start:'* ]] && (( in_redirection == 0 )); then # $arg is the command word
     if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]]; then
      style=precommand
     elif [[ "$arg" = "sudo" ]] && { _zsh_highlight_main__type sudo; [[ -n $REPLY && $REPLY != "none" ]] }; then
      style=precommand
      next_word=${next_word//:regular:/}
      next_word+=':sudo_opt:'
      next_word+=':start:'
     else
      _zsh_highlight_main_highlighter_expand_path $arg
      local expanded_arg="$REPLY"
      _zsh_highlight_main__type ${expanded_arg}
      local res="$REPLY"
      () {
        # Special-case: command word is '$foo', like that, without braces or anything.
        #
        # That's not entirely correct --- if the parameter's value happens to be a reserved
        # word, the parameter expansion will be highlighted as a reserved word --- but that
        # incorrectness is outweighed by the usability improvement of permitting the use of
        # parameters that refer to commands, functions, and builtins.
        local -a match mbegin mend
        local MATCH; integer MBEGIN MEND
        if [[ $res == none ]] && (( ${+parameters} )) &&
           [[ ${arg[1]} == \$ ]] && [[ ${arg:1} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+)$ ]] &&
           (( ${+parameters[(e)${MATCH}]} )) && [[ ${parameters[(e)$MATCH]} != *special* ]]
           then
          _zsh_highlight_main__type ${(P)MATCH}
          res=$REPLY
        fi
      }
      case $res in
        reserved)       # reserved word
                        style=reserved-word
                        #
                        # Match braces.
                        case $arg in
                          ($'\x7b')
                            braces_stack='Y'"$braces_stack"
                            ;;
                          ($'\x7d')
                            # We're at command word, so no need to check $right_brace_is_recognised_everywhere
                            _zsh_highlight_main__stack_pop 'Y' style=reserved-word
                            if [[ $style == reserved-word ]]; then
                              next_word+=':always:'
                            fi
                            ;;
                          ('do')
                            braces_stack='D'"$braces_stack"
                            ;;
                          ('done')
                            _zsh_highlight_main__stack_pop 'D' style=reserved-word
                            ;;
                          ('if')
                            braces_stack=':?'"$braces_stack"
                            ;;
                          ('then')
                            _zsh_highlight_main__stack_pop ':' style=reserved-word
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
                            _zsh_highlight_main__stack_pop '?' ""
                            ;;
                          ('foreach')
                            braces_stack='$'"$braces_stack"
                            ;;
                          ('end')
                            _zsh_highlight_main__stack_pop '$' style=reserved-word
                            ;;
                        esac
                        ;;
        'suffix alias') style=suffix-alias;;
        alias)          () {
                          integer insane_alias
                          case $arg in
                            # Issue #263: aliases with '=' on their LHS.
                            #
                            # There are three cases:
                            #
                            # - Unsupported, breaks 'alias -L' output, but invokable:
                            ('='*) :;;
                            # - Unsupported, not invokable:
                            (*'='*) insane_alias=1;;
                            # - The common case:
                            (*) :;;
                          esac
                          if (( insane_alias )); then
                            style=unknown-token
                          else
                            # The common case.
                            style=alias
                            _zsh_highlight_main__resolve_alias $arg
                            local alias_target="$REPLY"
                            [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$alias_target"} && -z ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]] && ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS+=($arg)
                          fi
                        }
                        ;;
        builtin)        style=builtin;;
        function)       style=function;;
        command)        style=command;;
        hashed)         style=hashed-command;;
        none)           if _zsh_highlight_main_highlighter_check_assign; then
                          style=assign
                          if [[ $arg[-1] == '(' ]]; then
                            in_array_assignment=true
                          else
                            # assignment to a scalar parameter.
                            # (For array assignments, the command doesn't start until the ")" token.)
                            next_word+=':start:'
                          fi
                        elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                          style=history-expansion
                        elif [[ $arg[0,1] == $histchars[2,2] ]]; then
                          style=history-expansion
                        elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                          if [[ $this_word == *':regular:'* ]]; then
                            # This highlights empty commands (semicolon follows nothing) as an error.
                            # Zsh accepts them, though.
                            style=commandseparator
                          else
                            style=unknown-token
                          fi
                        elif (( in_redirection == 2 )); then
                          style=redirection
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
                          style=reserved-word
                          _zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) $style
                          already_added=1
                          if [[ $arg[-2,-1] == '))' ]]; then
                            _zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos $style
                            already_added=1
                          fi
                        elif [[ $arg == '()' ]]; then
                          # anonymous function
                          style=reserved-word
                        elif [[ $arg == $'\x28' ]]; then
                          # subshell
                          style=reserved-word
                          braces_stack='R'"$braces_stack"
                        elif [[ $arg == $'\x29' ]]; then
                          # end of subshell
                          _zsh_highlight_main__stack_pop 'R' style=reserved-word
                        else
                          if _zsh_highlight_main_highlighter_check_path; then
                            style=$REPLY
                          else
                            style=unknown-token
                          fi
                        fi
                        ;;
        *)              _zsh_highlight_main_add_region_highlight $start_pos $end_pos arg0_$res arg0
                        already_added=1
                        ;;
      esac
     fi
   fi
   if (( ! already_added )) && [[ $style == unknown-token ]] && # not handled by the 'command word' codepath
      { (( in_redirection )) || [[ $this_word == *':regular:'* ]] || [[ $this_word == *':sudo_opt:'* ]] || [[ $this_word == *':sudo_arg:'* ]] }
   then # $arg is a non-command word
      case $arg in
        $'\x29') # subshell or end of array assignment
                 if $in_array_assignment; then
                   style=assign
                   in_array_assignment=false
                   next_word+=':start:'
                 else
                   _zsh_highlight_main__stack_pop 'R' style=reserved-word
                 fi;;
        $'\x28\x29') # possibly a function definition
                 if [[ $zsyh_user_options[multifuncdef] == on ]] || false # TODO: or if the previous word was a command word
                 then
                   next_word+=':start:'
                 fi
                 style=reserved-word
                 ;;
#--[ Begining of ftype array ]------@@@@
		*.old)               style=ftype-old ;;
		*.in)                style=ftype-in ;;
		*.am)                style=ftype-am ;;
		*.pcap)              style=ftype-pcap ;;
		*.dump)              style=ftype-dump ;;
		*.dmp)               style=ftype-dmp ;;
		*.cap)               style=ftype-cap ;;
		*.old)               style=ftype-old ;;
		*.in)                style=ftype-in ;;
		*.am)                style=ftype-am ;;
		*.tcc)               style=ftype-tcc ;;
		*.sx)                style=ftype-sx ;;
		*.S)                 style=ftype-S ;;
		*.s)                 style=ftype-s ;;
		*.hxx)               style=ftype-hxx ;;
		*.hpp)               style=ftype-hpp ;;
		*.hh)                style=ftype-hh ;;
		*.H)                 style=ftype-H ;;
		*.h++)               style=ftype-h++ ;;
		*.h)                 style=ftype-h ;;
		*.ftn)               style=ftype-ftn ;;
		*.for)               style=ftype-for ;;
		*.f)                 style=ftype-f ;;
		*.el)                style=ftype-el ;;
		*.clj)               style=ftype-clj ;;
		*.scala)             style=ftype-scala ;;
		*.pas)               style=ftype-pas ;;
		*.swift)             style=ftype-swift ;;
		*.rst)               style=ftype-rst ;;
		*.rs)                style=ftype-rs ;;
		*.ml)                style=ftype-ml ;;
		*.ii)                style=ftype-ii ;;
		*.go)                style=ftype-go ;;
		*.erl)               style=ftype-erl ;;
		*.cxx)               style=ftype-cxx ;;
		*.cs)                style=ftype-cs ;;
		*.cpp)               style=ftype-cpp ;;
		*.cp)                style=ftype-cp ;;
		*.cc)                style=ftype-cc ;;
		*.C)                 style=ftype-C ;;
		*.c++)               style=ftype-c++ ;;
		*.c)                 style=ftype-c ;;
		*.timer)             style=ftype-timer ;;
		*.target)            style=ftype-target ;;
		*.swap)              style=ftype-swap ;;
		*.socket)            style=ftype-socket ;;
		*.snapshot)          style=ftype-snapshot ;;
		*.service)           style=ftype-service ;;
		*.path)              style=ftype-path ;;
		*.mount)             style=ftype-mount ;;
		*.device)            style=ftype-device ;;
		*.automount)         style=ftype-automount ;;
		*.desktop)           style=ftype-desktop ;;
		*.sms)               style=ftype-sms ;;
		*.sav)               style=ftype-sav ;;
		*.rom)               style=ftype-rom ;;
		*.nes)               style=ftype-nes ;;
		*.nds)               style=ftype-nds ;;
		*.j64)               style=ftype-j64 ;;
		*.ggl)               style=ftype-ggl ;;
		*.gg)                style=ftype-gg ;;
		*.gel)               style=ftype-gel ;;
		*.gbc)               style=ftype-gbc ;;
		*.gba)               style=ftype-gba ;;
		*.gb)                style=ftype-gb ;;
		*.cdi)               style=ftype-cdi ;;
		*.atr)               style=ftype-atr ;;
		*.a78)               style=ftype-a78 ;;
		*.A64)               style=ftype-A64 ;;
		*.a64)               style=ftype-a64 ;;
		*.a52)               style=ftype-a52 ;;
		*.a00)               style=ftype-a00 ;;
		*.32x)               style=ftype-32x ;;
		*.fm2)               style=ftype-fm2 ;;
		*.adf)               style=ftype-adf ;;
		*.ttf)               style=ftype-ttf ;;
		*.pfb)               style=ftype-pfb ;;
		*.pfa)               style=ftype-pfa ;;
		*.pcf)               style=ftype-pcf ;;
		*.otf)               style=ftype-otf ;;
		*.gsf)               style=ftype-gsf ;;
		*.fon)               style=ftype-fon ;;
		*.dfont)             style=ftype-dfont ;;
		*.bdf)               style=ftype-bdf ;;
		*.srt)               style=ftype-srt ;;
		*.ass)               style=ftype-ass ;;
		*.ogx)               style=ftype-ogx ;;
		*.axv)               style=ftype-axv ;;
		*.anx)               style=ftype-anx ;;
		*.wmv)               style=ftype-wmv ;;
		*.webm)              style=ftype-webm ;;
		*.VOB)               style=ftype-VOB ;;
		*.vob)               style=ftype-vob ;;
		*.ts)                style=ftype-ts ;;
		*.sample)            style=ftype-sample ;;
		*.rmvb)              style=ftype-rmvb ;;
		*.rm)                style=ftype-rm ;;
		*.qt)                style=ftype-qt ;;
		*.ogv)               style=ftype-ogv ;;
		*.ogm)               style=ftype-ogm ;;
		*.nuv)               style=ftype-nuv ;;
		*.mpg)               style=ftype-mpg ;;
		*.mpeg)              style=ftype-mpeg ;;
		*.mp4v)              style=ftype-mp4v ;;
		*.mp4)               style=ftype-mp4 ;;
		*.MOV)               style=ftype-MOV ;;
		*.mov)               style=ftype-mov ;;
		*.mkv)               style=ftype-mkv ;;
		*.m4v)               style=ftype-m4v ;;
		*.m2v)               style=ftype-m2v ;;
		*.m2ts)              style=ftype-m2ts ;;
		*.gl)                style=ftype-gl ;;
		*.flv)               style=ftype-flv ;;
		*.fli)               style=ftype-fli ;;
		*.flc)               style=ftype-flc ;;
		*.divx)              style=ftype-divx ;;
		*.AVI)               style=ftype-AVI ;;
		*.avi)               style=ftype-avi ;;
		*.asf)               style=ftype-asf ;;
		*.wvc)               style=ftype-wvc ;;
		*.wv)                style=ftype-wv ;;
		*.spl)               style=ftype-spl ;;
		*.sid)               style=ftype-sid ;;
		*.S3M)               style=ftype-S3M ;;
		*.s3m)               style=ftype-s3m ;;
		*.oga)               style=ftype-oga ;;
		*.mod)               style=ftype-mod ;;
		*.m4)                style=ftype-m4 ;;
		*.fcm)               style=ftype-fcm ;;
		*.dat)               style=ftype-dat ;;
		*.xspf)              style=ftype-xspf ;;
		*.pls)               style=ftype-pls ;;
		*.m3u8)              style=ftype-m3u8 ;;
		*.m3u)               style=ftype-m3u ;;
		*.cue)               style=ftype-cue ;;
		*.wma)               style=ftype-wma ;;
		*.wav)               style=ftype-wav ;;
		*.spx)               style=ftype-spx ;;
		*.ra)                style=ftype-ra ;;
		*.ogg)               style=ftype-ogg ;;
		*.oga)               style=ftype-oga ;;
		*.mpc)               style=ftype-mpc ;;
		*.mp3)               style=ftype-mp3 ;;
		*.mp2)               style=ftype-mp2 ;;
		*.mka)               style=ftype-mka ;;
		*.midi)              style=ftype-midi ;;
		*.mid)               style=ftype-mid ;;
		*.m4r)               style=ftype-m4r ;;
		*.m4b)               style=ftype-m4b ;;
		*.m4a)               style=ftype-m4a ;;
		*.axa)               style=ftype-axa ;;
		*.au)                style=ftype-au ;;
		*.aac)               style=ftype-aac ;;
		*.ape)               style=ftype-ape ;;
		*.aiff)              style=ftype-aiff ;;
		*.dff)               style=ftype-dff ;;
		*.dsf)               style=ftype-dsf ;;
		*.flac)              style=ftype-flac ;;
		*.alac)              style=ftype-alac ;;
		*.st5)               style=ftype-st5 ;;
		*.sha1)              style=ftype-sha1 ;;
		*.sfv)               style=ftype-sfv ;;
		*.par)               style=ftype-par ;;
		*.md5)               style=ftype-md5 ;;
		*.gpg)               style=ftype-gpg ;;
		*.ffp)               style=ftype-ffp ;;
		*.reg)               style=ftype-reg ;;
		*.yml)               style=ftype-yml ;;
		*.yml)               style=ftype-yml ;;
		*.json)              style=ftype-json ;;
		*.toml)              style=ftype-toml ;;
		*.ini)               style=ftype-ini ;;
		*.nix)               style=ftype-nix ;;
		*.ovpn)              style=ftype-ovpn ;;
		*.conf)              style=ftype-conf ;;
		*.cfg)               style=ftype-cfg ;;
		*.yaml)              style=ftype-yaml ;;
		*.qml)               style=ftype-qml ;;
		*.xml)               style=ftype-xml ;;
		*.ttl)               style=ftype-ttl ;;
		*.torrent)           style=ftype-torrent ;;
		*.textile)           style=ftype-textile ;;
		*.aux)               style=ftype-aux ;;
		*.rdf)               style=ftype-rdf ;;
		*.rc)                style=ftype-rc ;;
		*.owl)               style=ftype-owl ;;
		*.nt)                style=ftype-nt ;;
		*.nfo)               style=ftype-nfo ;;
		*.n3)                style=ftype-n3 ;;
		*.latex)             style=ftype-latex ;;
		*.tex)               style=ftype-tex ;;
		*.jidgo)             style=ftype-jidgo ;;
		*.icls)              style=ftype-icls ;;
		*.deny)              style=ftype-deny ;;
		*.allow)             style=ftype-allow ;;
		*.vcd)               style=ftype-vcd ;;
		*.nrg)               style=ftype-nrg ;;
		*.mdf)               style=ftype-mdf ;;
		*.ISO)               style=ftype-ISO ;;
		*.iso)               style=ftype-iso ;;
		*.img)               style=ftype-img ;;
		*.dmg)               style=ftype-dmg ;;
		*.snippets)          style=ftype-snippets ;;
		*.Xresources)        style=ftype-Xresources ;;
		*.Xmodmap)           style=ftype-Xmodmap ;;
		*.xinitrc)           style=ftype-xinitrc ;;
		*.Xauthority)        style=ftype-Xauthority ;;
		*.urlview)           style=ftype-urlview ;;
		*.ttytterrc)         style=ftype-ttytterrc ;;
		*.profile)           style=ftype-profile ;;
		*.bash_profile)      style=ftype-bash_profile ;;
		*.bash_logout)       style=ftype-bash_logout ;;
		*.zsh)               style=ftype-zsh ;;
		*.tcsh)              style=ftype-tcsh ;;
		*.sh*)               style=ftype-sh* ;;
		*.sh)                style=ftype-sh ;;
		*.ksh)               style=ftype-ksh ;;
		*.fish)              style=ftype-fish ;;
		*.dash)              style=ftype-dash ;;
		*.csh)               style=ftype-csh ;;
		*.bash_history)      style=ftype-bash_history ;;
		*.bash)              style=ftype-bash ;;
		*.rasi)              style=ftype-rasi ;;
		*.vimrc)             style=ftype-vimrc ;;
		*.vimp)              style=ftype-vimp ;;
		*.viminfo)           style=ftype-viminfo ;;
		*.vim)               style=ftype-vim ;;
		*.attheme)           style=ftype-attheme ;;
		*.tdesktop-pallete)  style=ftype-tdesktop-pallete ;;
		*.tdesktop-theme)    style=ftype-tdesktop-theme ;;
		*.theme)             style=ftype-theme ;;
		*.tfnt)              style=ftype-tfnt ;;
		*.tfm)               style=ftype-tfm ;;
		*.tdy)               style=ftype-tdy ;;
		*.tk)                style=ftype-tk ;;
		*.tcl)               style=ftype-tcl ;;
		*.t)                 style=ftype-t ;;
		*.sug)               style=ftype-sug ;;
		*.sty)               style=ftype-sty ;;
		*.signature)         style=ftype-signature ;;
		*.sed)               style=ftype-sed ;;
		*.ru)                style=ftype-ru ;;
		*.rb)                style=ftype-rb ;;
		*.irb)               style=ftype-irb ;;
		*.erb)               style=ftype-erb ;;
		*.rc)                style=ftype-rc ;;
		*.py)                style=ftype-py ;;
		*.pod)               style=ftype-pod ;;
		*.pm)                style=ftype-pm ;;
		*.PL)                style=ftype-PL ;;
		*.pl)                style=ftype-pl ;;
		*.pid)               style=ftype-pid ;;
		*.php)               style=ftype-php ;;
		*.pfa)               style=ftype-pfa ;;
		*.pc)                style=ftype-pc ;;
		*.diff)              style=ftype-diff ;;
		*.patch)             style=ftype-patch ;;
		*.pacnew)            style=ftype-pacnew ;;
		*.offlineimaprc)     style=ftype-offlineimaprc ;;
		*.nfo)               style=ftype-nfo ;;
		*.netrc)             style=ftype-netrc ;;
		*.muttrc)            style=ftype-muttrc ;;
		*.mtx)               style=ftype-mtx ;;
		*.msmtprc)           style=ftype-msmtprc ;;
		*.mi)                style=ftype-mi ;;
		*.mfasl)             style=ftype-mfasl ;;
		*.mf)                style=ftype-mf ;;
		*.map)               style=ftype-map ;;
		*.lua)               style=ftype-lua ;;
		*.log)               style=ftype-log ;;
		*.lesshst)           style=ftype-lesshst ;;
		*.lam)               style=ftype-lam ;;
		*.scm)               style=ftype-scm ;;
		*.lisp)              style=ftype-lisp ;;
		*.jsp)               style=ftype-jsp ;;
		*.jsm)               style=ftype-jsm ;;
		*.js)                style=ftype-js ;;
		*.e)                 style=ftype-e ;;
		*.java)              style=ftype-java ;;
		*.info)              style=ftype-info ;;
		*.htoprc)            style=ftype-htoprc ;;
		*.agda)              style=ftype-agda ;;
		*.hs)                style=ftype-hs ;;
		*.hgignore)          style=ftype-hgignore ;;
		*.hgrc)              style=ftype-hgrc ;;
		*.jhtm)              style=ftype-jhtm ;;
		*.html)              style=ftype-html ;;
		*.htm)               style=ftype-htm ;;
		*.gitignore)         style=ftype-gitignore ;;
		*.git)               style=ftype-git ;;
		*.fonts)             style=ftype-fonts ;;
		*.fehbg)             style=ftype-fehbg ;;
		*.example)           style=ftype-example ;;
		*.ex)                style=ftype-ex ;;
		*.etx)               style=ftype-etx ;;
		*.ps)                style=ftype-ps ;;
		*.epsi)              style=ftype-epsi ;;
		*.epsf)              style=ftype-epsf ;;
		*.eps3)              style=ftype-eps3 ;;
		*.eps2)              style=ftype-eps2 ;;
		*.eps)               style=ftype-eps ;;
		*.enc)               style=ftype-enc ;;
		*.dir_colors)        style=ftype-dir_colors ;;
		*.csv)               style=ftype-csv ;;
		*.less)              style=ftype-less ;;
		*.scss)              style=ftype-scss ;;
		*.sass)              style=ftype-sass ;;
		*.css)               style=ftype-css ;;
		*.cs)                style=ftype-cs ;;
		*.coffee)            style=ftype-coffee ;;
		*.awk)               style=ftype-awk ;;
		*.mutt)              style=ftype-mutt ;;
		*.asoundrc)          style=ftype-asoundrc ;;
		*.asm)               style=ftype-asm ;;
		*.sqlite)            style=ftype-sqlite ;;
		*.sql)               style=ftype-sql ;;
		*.odb)               style=ftype-odb ;;
		*.mdf)               style=ftype-mdf ;;
		*.mdb)               style=ftype-mdb ;;
		*.ldf)               style=ftype-ldf ;;
		*.db)                style=ftype-db ;;
		*.ods)               style=ftype-ods ;;
		*.odp)               style=ftype-odp ;;
		*.odb)               style=ftype-odb ;;
		*.pptx)              style=ftype-pptx ;;
		*.ppt)               style=ftype-ppt ;;
		*.chrt)              style=ftype-chrt ;;
		*.xlsx)              style=ftype-xlsx ;;
		*.xlsm)              style=ftype-xlsm ;;
		*.xls)               style=ftype-xls ;;
		*.xla)               style=ftype-xla ;;
		*.gnumeric)          style=ftype-gnumeric ;;
		*.rtf)               style=ftype-rtf ;;
		*.pages)             style=ftype-pages ;;
		*.odt)               style=ftype-odt ;;
		*.odm)               style=ftype-odm ;;
		*.dotm)              style=ftype-dotm ;;
		*.dot)               style=ftype-dot ;;
		*.docx)              style=ftype-docx ;;
		*.docm)              style=ftype-docm ;;
		*.doc)               style=ftype-doc ;;
		*.txt)               style=ftype-txt ;;
		*.mfasl)             style=ftype-mfasl ;;
		*.mkd)               style=ftype-mkd ;;
		*.mf)                style=ftype-mf ;;
		*.org)               style=ftype-org ;;
		*.md)                style=ftype-md ;;
		*.markdown)          style=ftype-markdown ;;
		*.cbz)               style=ftype-cbz ;;
		*.pdf)               style=ftype-pdf ;;
		*.mobi)              style=ftype-mobi ;;
		*.lit)               style=ftype-lit ;;
		*.fb2)               style=ftype-fb2 ;;
		*.epub)              style=ftype-epub ;;
		*.dvi)               style=ftype-dvi ;;
		*.djvu)              style=ftype-djvu ;;
		*.djv)               style=ftype-djv ;;
		*.chm)               style=ftype-chm ;;
		*.added)             style=ftype-added ;;
		*.tmp)               style=ftype-tmp ;;
		*.temp)              style=ftype-temp ;;
		*.swp)               style=ftype-swp ;;
		*.pyc)               style=ftype-pyc ;;
		*.part)              style=ftype-part ;;
		*.o)                 style=ftype-o ;;
		*.log)               style=ftype-log ;;
		*.incomplete)        style=ftype-incomplete ;;
		*.class)             style=ftype-class ;;
		*.cache)             style=ftype-cache ;;
		*.blg)               style=ftype-blg ;;
		*.bbl)               style=ftype-bbl ;;
		*.bck)               style=ftype-bck ;;
		*.bak)               style=ftype-bak ;;
		*.aux)               style=ftype-aux ;;
		*.ico)               style=ftype-ico ;;
		*.icns)              style=ftype-icns ;;
		*.gif)               style=ftype-gif ;;
		*.yuv)               style=ftype-yuv ;;
		*.xwd)               style=ftype-xwd ;;
		*.xcf)               style=ftype-xcf ;;
		*.svgz)              style=ftype-svgz ;;
		*.svg)               style=ftype-svg ;;
		*.bpg)               style=ftype-bpg ;;
		*.webp)              style=ftype-webp ;;
		*.png)               style=ftype-png ;;
		*.pcx)               style=ftype-pcx ;;
		*.mng)               style=ftype-mng ;;
		*.eps)               style=ftype-eps ;;
		*.emf)               style=ftype-emf ;;
		*.dl)                style=ftype-dl ;;
		*.CR2)               style=ftype-CR2 ;;
		*.cgm)               style=ftype-cgm ;;
		*.tiff)              style=ftype-tiff ;;
		*.tif)               style=ftype-tif ;;
		*.xpm)               style=ftype-xpm ;;
		*.xbm)               style=ftype-xbm ;;
		*.tga)               style=ftype-tga ;;
		*.indd)              style=ftype-indd ;;
		*.psd)               style=ftype-psd ;;
		*.ppm)               style=ftype-ppm ;;
		*.pgm)               style=ftype-pgm ;;
		*.pbm)               style=ftype-pbm ;;
		*.bmp)               style=ftype-bmp ;;
		*.JPG)               style=ftype-JPG ;;
		*.jpg)               style=ftype-jpg ;;
		*.jpeg)              style=ftype-jpeg ;;
		*.vdi)               style=ftype-vdi ;;
		*.vmdk)              style=ftype-vmdk ;;
		*.qcow2)             style=ftype-qcow2 ;;
		*.qcow)              style=ftype-qcow ;;
		*.war)               style=ftype-war ;;
		*.sar)               style=ftype-sar ;;
		*.jar)               style=ftype-jar ;;
		*.ear)               style=ftype-ear ;;
		*.arj)               style=ftype-arj ;;
		*.xpi)               style=ftype-xpi ;;
		*.udeb)              style=ftype-udeb ;;
		*.rpm)               style=ftype-rpm ;;
		*.pkg)               style=ftype-pkg ;;
		*.msi)               style=ftype-msi ;;
		*.jad)               style=ftype-jad ;;
		*.gem)               style=ftype-gem ;;
		*.egg)               style=ftype-egg ;;
		*.deb)               style=ftype-deb ;;
		*.cab)               style=ftype-cab ;;
		*.apk)               style=ftype-apk ;;
		*.zoo)               style=ftype-zoo ;;
		*.ZIP)               style=ftype-ZIP ;;
		*.zip)               style=ftype-zip ;;
		*.Z)                 style=ftype-Z ;;
		*.Z)                 style=ftype-Z ;;
		*.z)                 style=ftype-z ;;
		*.z)                 style=ftype-z ;;
		*.xz)                style=ftype-xz ;;
		*.tzo)               style=ftype-tzo ;;
		*.tz)                style=ftype-tz ;;
		*.txz)               style=ftype-txz ;;
		*.tlz)               style=ftype-tlz ;;
		*.tgz)               style=ftype-tgz ;;
		*.tbz2)              style=ftype-tbz2 ;;
		*.tbz)               style=ftype-tbz ;;
		*.taz)               style=ftype-taz ;;
		*.tar)               style=ftype-tar ;;
		*.t7z)               style=ftype-t7z ;;
		*.rz)                style=ftype-rz ;;
		*.rar)               style=ftype-rar ;;
		*.lzma)              style=ftype-lzma ;;
		*.lzh)               style=ftype-lzh ;;
		*.lz4)               style=ftype-lz4 ;;
		*.lz)                style=ftype-lz ;;
		*.lrz)               style=ftype-lrz ;;
		*.lha)               style=ftype-lha ;;
		*.alp)               style=ftype-alp ;;
		*.gz)                style=ftype-gz ;;
		*.dz)                style=ftype-dz ;;
		*.cpio)              style=ftype-cpio ;;
		*.bz2)               style=ftype-bz2 ;;
		*.bz)                style=ftype-bz ;;
		*.arj)               style=ftype-arj ;;
		*.arc)               style=ftype-arc ;;
		*.alz)               style=ftype-alz ;;
		*.ace)               style=ftype-ace ;;
		*.7z)                style=ftype-7z ;;
		*.cmd)               style=ftype-cmd ;;
		*.bat)               style=ftype-bat ;;
		*.bin)               style=ftype-bin ;;
		*.btm)               style=ftype-btm ;;
		*.com)               style=ftype-com ;;
		*.exe)               style=ftype-exe ;;
#--[ End of ftype array ]------@@@@
        *)       if false; then
                 elif [[ $arg = $'\x7d' ]] && $right_brace_is_recognised_everywhere; then
                   # Parsing rule: }
                   #
                   #     Additionally, `tt(})' is recognized in any position if neither the
                   #     tt(IGNORE_BRACES) option nor the tt(IGNORE_CLOSE_BRACES) option is set.
                   _zsh_highlight_main__stack_pop 'Y' style=reserved-word
                   if [[ $style == reserved-word ]]; then
                     next_word+=':always:'
                   fi
                 elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 )); then
                   style=history-expansion
                 elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                   if [[ $this_word == *':regular:'* ]]; then
                     style=commandseparator
                   else
                     style=unknown-token
                   fi
                 elif (( in_redirection == 2 )); then
                   style=redirection
                 else
                   _zsh_highlight_main_highlighter_highlight_argument
                   already_added=1
                 fi
                 ;;
      esac
    fi
    if ! (( already_added )); then
      _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
    fi
    if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
      if [[ $arg == ';' ]] && $in_array_assignment; then
        # literal newline inside an array assignment
        next_word=':regular:'
      else
        next_word=':start:'
        highlight_glob=true
      fi
    elif
       [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} && $this_word == *':start:'* ]] ||
       [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} && $this_word == *':start:'* ]]; then
      next_word=':start:'
    elif [[ $arg == "repeat" && $this_word == *':start:'* ]]; then
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
    fi
    start_pos=$end_pos
    if (( in_redirection == 0 )); then
      # This is the default/common codepath.
      this_word=$next_word
    else
      # Stall $this_word.
    fi
  done
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

# Check if $arg is a path.
# If yes, return 0 and in $REPLY the style to use.
# Else, return non-zero (and the contents of $REPLY is undefined).
_zsh_highlight_main_highlighter_check_path()
{
  _zsh_highlight_main_highlighter_expand_path $arg;
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
    # [[ -d "$cdpath_dir/$expanded_path" ]] && return 0
    [[ -e "$cdpath_dir/$expanded_path" ]] && return 0
  done

  # If dirname($arg) doesn't exist, neither does $arg.
  [[ ! -d ${expanded_path:h} ]] && return 1

  # If this word ends the buffer, check if it's the prefix of a valid path.
  if [[ ${BUFFER[1]} != "-" && $pure_buf_len == $end_pos ]] &&
     [[ $WIDGET != zle-line-finish ]]; then
    local -a tmp
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && REPLY=path_prefix && return 0
  fi

  # It's not a path.
  return 1
}

# Highlight an argument and possibly special chars in quotes
# This command will at least highlight start_pos to end_pos with the default style
_zsh_highlight_main_highlighter_highlight_argument()
{
  local base_style=default i path_eligible=1 style
  local -a highlights reply

  local -a match mbegin mend
  local MATCH; integer MBEGIN MEND

  if [[ $arg[1] == - ]]; then
    if [[ $arg[2] == - ]]; then
      base_style=double-hyphen-option
    else
      base_style=single-hyphen-option
    fi
    path_eligible=0
  fi

  for (( i = 1 ; i <= end_pos - start_pos ; i += 1 )); do
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
        path_eligible=0
        if [[ $arg[i+1] == "'" ]]; then
          path_eligible=1
          _zsh_highlight_main_highlighter_highlight_dollar_quote $i
          (( i = REPLY ))
          highlights+=($reply)
          continue
        fi
        while [[ $arg[i+1] == [\^=~#+] ]]; do
          (( i += 1 ))
        done
        if [[ $arg[i+1] == [*@#?$!-] ]]; then
          (( i += 1 ))
        fi;;
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

  if (( path_eligible )) && _zsh_highlight_main_highlighter_check_path; then
    base_style=$REPLY
    _zsh_highlight_main_highlighter_highlight_path_separators $base_style
    highlights+=($reply)
  fi

  highlights=($start_pos $end_pos $base_style $highlights)
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
  local -a match mbegin mend saved_reply
  local MATCH; integer MBEGIN MEND
  local i j k style
  reply=()

  for (( i = $1 + 1 ; i <= end_pos - start_pos ; i += 1 )) ; do
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
              # Highlight just the '$'.
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
  reply=($(( start_pos + $1 - 1)) $(( start_pos + i )) $style $reply)
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

  for (( i = $1 + 2 ; i <= end_pos - start_pos ; i += 1 )) ; do
    (( j = i + start_pos - 1 ))
    (( k = j + 1 ))
    case "$arg[$i]" in
      "'") break;;
      "\\") style=back-dollar-quoted-argument
            for (( c = i + 1 ; c <= end_pos - start_pos ; c += 1 )); do
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

# Highlight backtick subshells
_zsh_highlight_main_highlighter_highlight_backtick()
{
  local arg1=$1 i=$1 q=\` style
  reply=()
  while i=$arg[(ib:i+1:)$q]; [[ $arg[i-1] == '\' && $i -lt $(( end_pos - start_pos )) ]]; do done

  if [[ $arg[i] == '`' ]]; then
    style=back-quoted-argument
  else
    # If unclosed, i points past the end
    (( i-- ))
    style=back-quoted-argument-unclosed
  fi
  reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style)
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

autoload -U add-zsh-hook
if add-zsh-hook precmd _zsh_highlight_main__precmd_hook 2>/dev/null; then
  # Initialize command type cache
  typeset -gA _zsh_highlight_main__command_type_cache
else
  print -r -- >&2 'zsh-syntax-highlighting: Failed to load add-zsh-hook. Some speed optimizations will not be used.'
  # Make sure the cache is unset
  unset _zsh_highlight_main__command_type_cache
fi
typeset -ga X_ZSH_HIGHLIGHT_DIRS_BLACKLIST

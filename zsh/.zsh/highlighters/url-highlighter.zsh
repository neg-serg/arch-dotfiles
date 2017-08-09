#!/usr/bin/env zsh

# Whether the pattern highlighter should be called or not.
_zsh_highlight_url_highlighter_predicate()
{
  _zsh_highlight_buffer_modified
}

# Pattern syntax highlighting function.
_zsh_highlight_url_highlighter()
{
  setopt localoptions extendedglob
  _zsh_highlight_url_highlighter_loop "$BUFFER" "(^https?://[^\n'\"]*) "
}

_zsh_highlight_url_highlighter_loop()
{
  # This does *not* do its job syntactically, sorry.
  local buf="$1" pat="$2"
  local -a match mbegin mend
  if [[ "$buf" =~ "${pat}" ]]; then
    curl -sIL -m 4 -w '' "${match}" -o /dev/null
    local exitCode=$?
    if [[ "$exitCode" -eq "0" ]]; then
      region_highlight+=("$((mbegin[1] - 1)) $mend[1] fg=green")
      "$0" "$match" "$pat"; return $?
    else
      region_highlight+=("$((mbegin[1] - 1)) $mend[1] fg=red")
      "$0" "$match" "$pat"; return $?
    fi
  fi
}

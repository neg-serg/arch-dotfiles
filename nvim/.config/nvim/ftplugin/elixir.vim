let s:pb_elixir_blocks =
      \ [ '@doc\>', '@moduledoc\>'
      \ , '\<alias\>', '\<use\>', '\<import\>', '\<require\>'
      \ , '\<defmodule\>', '\<def\>', '\<defp\>'
      \ ]

let b:pb_elixir_pattern = '^\s*\%(' . join(s:pb_elixir_blocks, '\\|') . '\)'

execute('nmap <buffer> <silent> ]] /' . b:pb_elixir_pattern . '<cr>')
execute('nmap <buffer> <silent> [[ ?' . b:pb_elixir_pattern . '<cr>')
execute('vmap <buffer> <silent> ]] /' . b:pb_elixir_pattern . '<cr>')
execute('vmap <buffer> <silent> [[ ?' . b:pb_elixir_pattern . '<cr>')
execute('omap <buffer> <silent> ]] /' . b:pb_elixir_pattern . '<cr>')
execute('omap <buffer> <silent> [[ ?' . b:pb_elixir_pattern . '<cr>')

let g:loaded_getscriptPlugin = 1 " I don't use it
let g:loaded_2html_plugin = 1 " 2html is too ugly for me
let g:loaded_vimballPlugin = 1 " Don't use legacy vimball
let g:loaded_matchparen = 1 " Don't show matching brackets/parenthesis
let loaded_netrwPlugin = 1 " Disable netrw plugin, use vim-ranger
let &runtimepath = expand('$XDG_CONFIG_HOME/nvim/') . ','
    \ . expand('$XDG_CONFIG_HOME/nvim/after/') . ',' . &runtimepath

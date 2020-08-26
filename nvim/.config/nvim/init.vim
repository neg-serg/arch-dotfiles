set packpath=~/.config/nvim,~/.config/nvim/after
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime)
            \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

let g:loaded_getscriptPlugin = 1 " I don't use it
let g:loaded_2html_plugin = 1 " 2html is too ugly for me
let g:loaded_vimballPlugin = 1 " Don't use legacy vimball
let g:loaded_matchparen = 1 " Don't show matching brackets/parenthesis
let loaded_netrwPlugin = 1 " Disable netrw plugin, use vim-ranger

set nocompatible
set noexrc
set secure
set shell=/bin/dash
set termguicolors
if !1 | finish | endif

if ! $NVIMPAGER
    packadd neovim-autoload-session
endif

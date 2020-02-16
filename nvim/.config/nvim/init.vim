scriptencoding utf-8
set noexrc
set secure
set shell=/bin/dash
let g:startuptime = reltime()

let g:loaded_getscriptPlugin = 1 " I don't use it
let g:loaded_2html_plugin    = 1 " 2html is too ugly for me
let g:loaded_vimballPlugin   = 1 " Don't use legacy vimball
let g:loaded_matchparen      = 1 " Don't show matching brackets/parenthesis
let loaded_netrwPlugin       = 1 " Disable netrw plugin, use vim-ranger

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

let g:profile = 0
fun! ProfileStart()
    let l:profile_file = '/tmp/vim.'.getpid().'.profile.txt'
    echom 'Profiling into' l:profile_file
    exec 'profile start '.l:profile_file
    profile! file **
    profile  func *
endfun
if get(g:, 'profile')
    call ProfileStart()
endif
autocmd VimEnter * let g:startuptime = reltime(g:startuptime)
        \ | redraw | echomsg 'startuptime: ' . reltimestr(g:startuptime)

let &runtimepath = expand('~/.config/nvim/') . ','
    \ . expand('~/.config/nvim/after/') . ',' . &runtimepath
set termguicolors

call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/00-plugin-list.vim
call plug#end()

source ~/.config/nvim/02-keymaps.vim
source ~/.config/nvim/03-plugins-config.vim
source ~/.config/nvim/04-autocmds.vim
source ~/.config/nvim/11-vimacs.vim
source ~/.config/nvim/14-abbr.vim
source ~/.config/nvim/21-langmap.vim
source ~/.config/nvim/31-statusline.vim

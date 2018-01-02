scriptencoding utf-8
set noexrc
set secure
set shell=/bin/sh

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if 1
    let g:loaded_getscriptPlugin = 1 " I don't use it
    let g:loaded_2html_plugin    = 1 " 2html is too ugly for me
    let g:loaded_logipat         = 1 " Boolean logic patterns
    let g:loaded_matchparen      = 1 " Don't show matching brackets/parenthesis
    let g:loaded_netrwPlugin     = 1 " Don't use netrw
    let g:loaded_vimballPlugin   = 1 " Don't use legacy vimball
    let g:loaded_tarPlugin       = 1 " Don't use archive-related plugins
    let g:loaded_gzip            = 1 " Don't use archive-related plugins
    let g:loaded_zipPlugin       = 1 " Don't use archive-related plugins
endif

set runtimepath+=~/.fzf

if has('nvim')
    let g:python_interpreter='python2'
        let &runtimepath = expand('~/.vim/') . ','
        \ . expand('~/.vim/after/') . ',' . &rtp
    runtime! plugin/python_setup.vim
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    let $COLORTERM='truecolor'
    source ~/.vim/01-nvim_terminal_fix.vim
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has('termguicolors'))
        set termguicolors
    endif
endif

if (&t_Co > 2 || has('gui_running'))
    syntax on
endif
filetype plugin indent on

source ~/.config/nvimpager/01-settings.vim

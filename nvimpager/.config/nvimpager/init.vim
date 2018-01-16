scriptencoding utf-8
set noexrc
set secure
set shell=/bin/sh

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $COLORTERM='truecolor'
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
set termguicolors

set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/
source ~/.vim/00-bundlelist.vim
source ~/.config/nvimpager/01-settings.vim

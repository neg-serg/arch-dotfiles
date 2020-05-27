scriptencoding utf-8
set noexrc
set secure
set shell=/bin/dash
set termguicolors
source ~/.config/nvimpager/31-statusline.vim
autocmd BufReadPre,FileReadPre * colorscheme neg

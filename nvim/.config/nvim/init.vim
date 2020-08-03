set noexrc
set secure
set shell=/bin/dash
set termguicolors
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

source $XDG_CONFIG_HOME/nvim/00-plugin-list.vim
source $XDG_CONFIG_HOME/nvim/02-bindkeymaps.vim
source $XDG_CONFIG_HOME/nvim/03-plugins-config.vim
source $XDG_CONFIG_HOME/nvim/04-autocmds.vim
source $XDG_CONFIG_HOME/nvim/11-vimacs.vim
source $XDG_CONFIG_HOME/nvim/14-abbr.vim
source $XDG_CONFIG_HOME/nvim/21-langmap.vim
source $XDG_CONFIG_HOME/nvim/31-statusline.vim

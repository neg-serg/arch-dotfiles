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

let &runtimepath = expand('$XDG_CONFIG_HOME/nvim/') . ','
    \ . expand('$XDG_CONFIG_HOME/nvim/after/') . ',' . &runtimepath
set termguicolors

" thx to github.com/ceuk/dotfiles
let vimplug_exists=expand("$XDG_CONFIG_HOME/nvim/autoload/plug.vim")

if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
source $XDG_CONFIG_HOME/nvim/00-plugin-list.vim
call plug#end()

source $XDG_CONFIG_HOME/nvim/02-keymaps.vim
source $XDG_CONFIG_HOME/nvim/03-plugins-config.vim
source $XDG_CONFIG_HOME/nvim/04-autocmds.vim
source $XDG_CONFIG_HOME/nvim/11-vimacs.vim
source $XDG_CONFIG_HOME/nvim/14-abbr.vim
source $XDG_CONFIG_HOME/nvim/21-langmap.vim
source $XDG_CONFIG_HOME/nvim/31-statusline.vim

set packpath=~/.config/nvim,~/.config/nvim/after
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime)
            \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

set noexrc
set secure
set termguicolors
if !1 | finish | endif

if ! $NVIMPAGER
    packadd neovim-autoload-session
endif

if &compatible
    set nocompatible
endif
set noexrc
set secure
set shell=/bin/dash
set termguicolors
if !1 | finish | endif
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime)
                    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

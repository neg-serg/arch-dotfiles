let s:enabled = 0

set keymap=russian-jcukenwin
function MyKeyMapHighlight()
    if &iminsert == 0
        if s:enabled
            let s:enabled = 0
        endif
    else
        if !s:enabled
            let s:enabled = 1
        endif
    endif
endfunction
call MyKeyMapHighlight()
au WinEnter * :call MyKeyMapHighlight()
cmap <silent> <C-s> <C-^>
imap <silent> <C-s> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-s> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-s> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

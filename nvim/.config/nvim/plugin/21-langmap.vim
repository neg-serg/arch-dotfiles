let s:enabled = 0
function MapHighlight()
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
call MapHighlight()
augroup map_highlight
    au WinEnter * :call MapHighlight()
augroup end
imap <silent> <C-s> <C-^>X<Esc>:call MapHighlight()<CR>a<C-H>
nmap <silent> <C-s> a<C-^><Esc>:call MapHighlight()<CR>

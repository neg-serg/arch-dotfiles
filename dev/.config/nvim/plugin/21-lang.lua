vim.cmd('let g:enabled = 0')
vim.api.nvim_exec([[
    function MapHighlight()
        if &iminsert == 0
            if g:enabled
                let g:enabled = 0
            endif
        else
            if !g:enabled
                let g:enabled = 1
            endif
        endif
    endfunction
]], true)

vim.api.nvim_exec([[
    call MapHighlight()
    augroup map_highlight
        au WinEnter * :call MapHighlight()
    augroup end
    imap <silent> <C-s> <C-^>X<Esc>:call MapHighlight()<CR>a<C-H>
    nmap <silent> <C-s> a<C-^><Esc>:call MapHighlight()<CR>
]], true)

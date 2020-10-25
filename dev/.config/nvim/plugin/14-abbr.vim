function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '^\k\+$'
        return "\<C-]>\<CR>"
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()

cnoreabbrev gd Gvdiff
cnoreabbrev gp Gpush
cnoreabbrev gc Gcommit -v -m
cnoreabbrev gca Gcommit --amend -v
cnoreabbrev gcheckout Gcheckout
cnoreabbrev grm Gremove
cnoreabbrev gmv Gmove
cnoreabbrev L CocList
cnoreabbrev U UltiSnipsEdit

function! CreateFoldersAndWrite(bang)
    let l:one = expand('%:p')
    let l:two = substitute(l:one, '^[A-Za-z]*', '', '')
    if l:one != l:two
        echo 'Sorry but buffer is not a real file'
        return
    endif
    silent execute('!mkdir -p %:h')
    try
        if (a:bang)
            execute(':w!')
        else
            execute(':w')
        endif
    catch "E166: Can't open linked file for writing"
        redraw!
        SudaWrite
    endtry
endfunction

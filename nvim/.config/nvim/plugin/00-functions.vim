function! DelDel()
    " Do not copy to default register on delete/change
    for key in ['d', 'D', 'c', 'C']
        for keymode in ['n', 'v']
            exe keymode . 'noremap ' . key . ' "_' . key
        endfor
    endfor
endfunction
function! DequoteLang()
    %s/[‘’]/'/|s/[“”¿¿]/\"/
endfunction

function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
        tabnew
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent put=message
    endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

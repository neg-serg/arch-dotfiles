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

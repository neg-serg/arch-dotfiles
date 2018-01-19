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

function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


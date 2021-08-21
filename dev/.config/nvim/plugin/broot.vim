nnoremap [Qleader]e :call RunBroot()<CR>i

function! RunBroot()
    let l:command = 'broot -h --conf ~/.config/nvim/nvim-broot.toml'
    vnew | setl nonumber
    call termopen(l:command, {'on_exit': 'BrootOnExit'})
endfunction

function! BrootOnExit(job_id, code, event) dict
    let l:filename = getline(1)
    vnew | bd! # | close
    if (l:filename != '')
        execute 'edit ' . l:filename
        execute 'only'
    endif
endfunction

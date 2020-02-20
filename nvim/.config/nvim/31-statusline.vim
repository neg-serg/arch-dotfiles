let g:currentmode={
      \ 'n'  : 'N',
      \ 'no' : 'Normal·Operator Pending',
      \ 'v'  : 'V',
      \ 'V'  : 'V·Line',
      \ '^V' : 'V·Block',
      \ 's'  : 'S',
      \ 'S'  : 'S·Line',
      \ '^S' : 'S·Block',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'Rv' : 'V·Replace',
      \ 'c'  : 'C',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : '!',
      \ 't'  : 'T'
      \}

function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! GitBranch(git)
    if a:git == ""
        return ''
    else
        return ' ' . a:git . ' '
    endif
endfunction

function! CheckFT(filetype)
    if a:filetype == ''
        return ''
    else
        return tolower(a:filetype)
    endif
endfunction

function! CheckMod(modi)
    if a:modi == 1
        hi Modi guifg=#6C7E96 guibg=#010C12
        hi Filename guifg=#6C7E96 guibg=#010C12
        return expand('%:t').'*'
    else
        hi Modi guifg=#617287 guibg=#010C12
        hi Filename guifg=#617287 guibg=#010C12
        return expand('%:t')
    endif
endfunction

function! ActiveLine()
    let statusline = ""
    let statusline .= "%#Base#"
    let statusline .= "%#Mode# %{ModeCurrent()}"
    let statusline .= '%#StatusLeftDelimiter1# ❯>'
    let statusline .= "%#Modi# %{CheckMod(&modified)}"
    let statusline .= "%#Git# %{GitBranch(fugitive#head())} %)"
    let statusline .= "%#Decoration#▓▒▒"
    let statusline .= "%3* "
    let statusline .= "%= "
    let statusline .= "%#Decoration#▒▒▓"
    let statusline .= "%#Filetype#%{CheckFT(&filetype)} "
    let statusline .= "%3*"
    let statusline .= "%#StatusRightDelimiter1#❮"
    let statusline .= "%1*"
    let statusline .= "%#StatusRight# %02l%#StatusRightDelimiter1#/%#StatusRight#%02v"
    let statusline .= "%#StatusRightDelimiter1# ❮ "
    let statusline .= "%#StatusRight#%2p%% "

    return statusline
endfunction

function! InactiveLine()
    let statusline = ""
    let statusline .= "%#Base#"
    let statusline .= "%#Filename# %F "
    return statusline
endfunction

augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
    autocmd FileType nerdtree setlocal statusline=%!NERDLine()
augroup END

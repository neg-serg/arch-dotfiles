scriptencoding=utf-8
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
    if a:git ==# ''
        return ''
    else
        return ' ' . a:git . ' '
    endif
endfunction

function! CheckFT(filetype)
    if a:filetype ==# ''
        return ''
    else
        return '❮ ' . tolower(a:filetype)
    endif
endfunction

function! VisualSelectionSize()
    if mode() == "v"
        " Exit and re-enter visual mode, because the marks
        " ('< and '>) have not been updated yet.
        exe "normal \<ESC>gv"
        if line("'<") != line("'>")
            return (line("'>") - line("'<") + 1) . ' lines'
        else
            return (col("'>") - col("'<") + 1) . ' chars'
        endif
    elseif mode() == "V"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . ' lines'
    elseif mode() == "\<C-V>"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
    else
        return ''
    endif
endfunction

function! CheckMod(modi)
    if a:modi == 1
        hi Modi guifg=#8fa7c7 guibg=NONE
        hi Filename guifg=#8fa7c7 guibg=NONE
        return StatusLineFileName().'  '
    else
        hi Modi guifg=#6587b3 guibg=NONE
        hi Filename guifg=#8fa7c7 guibg=NONE
        return StatusLineFileName()
    endif
endfunction

function! ActiveLine()
    let statusline = ''
    let statusline .= '%#Base#   '
    let statusline .= '%{VisualSelectionSize()}'
    let statusline .= '%#StatusLeftDelimiter1#❯>'
    let statusline .= '%#Modi# %{CheckMod(&modified)}'
    let statusline .= "%#Modi# %{&readonly?'\ ':''}"
    let statusline .= '%(%{StatusLineALE()}%)%*'
    let statusline .= "%#Git# %{get(g:,'coc_git_status','')}"
    let statusline .= '%#Decoration# '
    let statusline .= '%3* '
    let statusline .= '%= '
    let statusline .= '%#Decoration# '
    let statusline .= '%#StatusRight#  %{StatusLinePWD()}'
    if exists("*coc#status")
        let statusline .= '%{coc#status()}' . "%{get(b:,'coc_current_function','')}"
        if coc#status() ==? ''
            let statusline .= ' %#Filetype#%{CheckFT(&filetype)}'
        endif
    endif
    let statusline .= '%3*'
    let statusline .= '%#StatusRightDelimiter1# ❮'
    let statusline .= " %{&modifiable?(&expandtab?' ':' ').&shiftwidth:''}"
    let statusline .= '%#StatusRightDelimiter1# ❮'
    let statusline .= '%1*'
    let statusline .= '%#StatusRight# %02l%#StatusRightDelimiter1#/%#StatusRight#%02v'
    let statusline .= '%#StatusRightDelimiter1# ❮ '
    let statusline .= '%#StatusRight#%2p%% '
    let statusline .= '%#StatusRightDelimiter1#❮'
    let statusline .= '%#Mode# %{ModeCurrent()}'
    return statusline
endfunction

function! InactiveLine()
    let statusline = '%#Base# %#Filename# %.20%F '
    return statusline
endfunction

augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END

function! StatusLinePWD()
    if !exists('b:statusline_pwd')
        let b:statusline_pwd = fnamemodify(getcwd(), ':t')
    endif
    return b:statusline_pwd
endfunction

function! StatusLineFileName()
    let pre = ''
    let pat = '://'
    let name = expand('%:~:.')
    if name =~# pat
        let pre = name[:stridx(name, pat) + len(pat)-1] . '...'
        let name = name[stridx(name, pat) + len(pat):]
    elseif empty(name) && &filetype ==# 'netrw'
        let name = fnamemodify(b:netrw_curdir, ':~:.')
    endif
    let name = simplify(name)
    let ratio = winwidth(0) / len(name)
    if ratio <= 2 && ratio > 1
        let name = pathshorten(name)
    elseif ratio <= 1
        let name = fnamemodify(name, ':t')
    endif
    return pre . name
endfunction

function! StatusLineALE() abort
    if !exists(':ALE*')
        return ''
    endif
    let l:s = []
    let ale = ale#statusline#Count(bufnr('%'))
    if ale['error'] > 0
        call add(l:s, 'E: ' . ale['error'])
    endif
    if ale['warning'] > 0
        call add(l:s, 'W: ' . ale['warning'])
    endif
    if ale['total'] > 0
        call add(l:s, 'T: ' . ale['total'])
    endif
    if !empty(l:s)
        return '[ALE '.join(l:s, ',').']'
    endif
    return ''
endfunction

set rulerformat=%-30(%=%t%{&mod?'\ +':''}\ %p%%%)
set rulerformat+=%{&readonly?'\ [RO]':''}
set rulerformat+=%{&ff!='unix'?'\ ['.&ff.']':''}
set rulerformat+=%{(&fenc!='utf-8'&&&fenc!='')?'\ ['.&fenc.']':''}

hi StatusLine guifg=black guibg=NONE
hi StatusLineNC guifg=black guibg=cyan
hi Base guibg=NONE guifg=#929dcb
hi Decoration guibg=NONE guifg=NONE
hi Git guibg=NONE guifg=#005faf
hi LineCol guibg=NONE guifg=#929dcb
hi Mode guibg=NONE guifg=#007fb5
hi Filetype guibg=NONE guifg=#007fb5
hi PowerlineMode guibg=NONE guifg=NONE
hi StatusLeftDelimiter1 guibg=NONE guifg=#326e8c
hi StatusRightDelimiter1 guibg=NONE guifg=#326e8c
hi StatusRight guibg=NONE guifg=#007fb5

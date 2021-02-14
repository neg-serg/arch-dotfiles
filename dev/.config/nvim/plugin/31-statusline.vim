function! StatusLinePWD() abort
    if !exists('b:statusline_pwd')
        let b:statusline_pwd = fnamemodify(getcwd(), ':t')
    endif
    return b:statusline_pwd
endfunction

function! StatusLineFileName() abort
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

function! StatusErrors() abort
    if !exists(':ALE*')
        return ''
    endif
    let l:s = []
    let ale = ale#statusline#Count(bufnr('%'))
    if ale['error'] > 0
        call add(l:s, '' . ale['error'])
    endif
    if ale['warning'] > 0
        call add(l:s, '' . ale['warning'])
    endif
    if !empty(l:s)
        return join(l:s, '')
    endif
    return ''
endfunction

function! HighlightGr() abort
    return '> ' . synIDattr(synID(line('.'), col('.'), 1), 'name') . ' <'
endfun

function! NegJobs() abort
    let n_jobs = exists('g:jobs') ? len(g:jobs) : 0
    return winwidth(0) <# 55
        \ ? ''
        \ : n_jobs
        \ ? ' ' . n_jobs
        \ : ''
endfun

function! NegQF() abort
    return printf('q:%d l:%d',
        \ len(getqflist()),
        \ len(getloclist(bufnr('%')))
        \ )
endfun

function! GitBranch(git) abort
    if a:git ==# ''
        return ''
    else
        return ' ' . a:git . ' '
    endif
endfunction

function! CheckFT(filetype) abort
    if a:filetype ==# ''
        return ''
    else
        return '  '.tolower(a:filetype)
    endif
endfunction

augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END

function! InactiveLine()
    return luaeval("require'31-statusline'.inActiveLine()")
endfunction

function! ActiveLine()
    return luaeval("require'31-statusline'.activeLine()")
endfunction

function! FancyMode() abort
    return luaeval("require'31-statusline'.FancyMode()")
endfunction

function! CocStatus() abort
    " No linting involved
    let status = get(g:, 'coc_status', '')
    let first_word = matchstr(status, '^\s*\zs\S*')
    " Replace the long strings by some fancy characters
    return empty(status)
                \ ? '' : first_word is# 'Python'
                \ ? '' : first_word is# 'TSC'
                \ ? '' : first_word
endfun

function! VisualSelectionSize() abort
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

function! CheckMod(modi) abort
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

"function! InactiveLine() abort
"    return '%#Base# %#Filename# %.20%F '
"endfunction

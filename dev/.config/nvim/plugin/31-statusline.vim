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
        return '• ' . tolower(a:filetype)
    endif
endfunction

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

function! ActiveLine() abort
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
        if coc#status() ==? ''
            let statusline .= ' %#Filetype#%{CheckFT(&filetype)}'
        else
            let statusline .= ' • %{coc#status()}' . "%{get(b:,'coc_current_function','')}"
        endif
    endif
    let statusline .= '%3*'
    let statusline .= '%#StatusRightDelimiter1# •'
    let statusline .= " %{&modifiable?(&expandtab?' ':' ').&shiftwidth:''}"
    let statusline .= '%#StatusRightDelimiter1# •'
    let statusline .= '%1*'
    let statusline .= '%#StatusRight# %02l%#StatusRightDelimiter1#/%#StatusRight#%02v'
    let statusline .= '%#StatusRightDelimiter1# • '
    let statusline .= '%#StatusRight#%2p%% '
    let statusline .= '%#StatusRightDelimiter1#•'
    let statusline .= '%#Mode# %{ModeCurrent()}'
    return statusline
endfunction

function! InactiveLine() abort
    return '%#Base# %#Filename# %.20%F '
endfunction

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

function! StatusLineALE() abort
    if !exists(':ALE*')
        return ''
    endif
    let l:s = []
    let ale = ale#statusline#Count(bufnr('%'))
    if ale['error'] > 0
        call add(l:s, 'e:' . ale['error'])
    endif
    if ale['warning'] > 0
        call add(l:s, 'w:' . ale['warning'])
    endif
    if ale['total'] > 0
        call add(l:s, 't:' . ale['total'])
    endif
    if !empty(l:s)
        return '❰ALE '.join(l:s, ',').'❱'
    endif
    return ''
endfunction

function! Neghi_group() abort
    return '> ' . synIDattr(synID(line('.'), col('.'), 1), 'name') . ' <'
endfun

function! Negcolumn_and_percent() abort
    " The percent part was inspired by vim-line-no-indicator plugin.
    let chars = ['꜒', '꜓', '꜔', '꜕', '꜖',]
    let [c_l, l_l] = [line('.'), line('$')]
    let index = float2nr(ceil((c_l * len(chars) * 1.0) / l_l)) - 1
    let perc = chars[index]
    return winwidth(0) ># 55 ? printf('%s%2d', perc, col('.')) : ''
endfun

function! Negjobs() abort
    let n_jobs = exists('g:jobs') ? len(g:jobs) : 0
    return winwidth(0) <# 55
        \ ? ''
        \ : n_jobs
        \ ? ' ' . n_jobs
        \ : ''
endfun

function! Negqf() abort
    return printf('[q:%d l:%d]',
        \ len(getqflist()),
        \ len(getloclist(bufnr('%')))
        \ )
endfun

function! NegALE(mode) abort
    " a:mode: 1/0 = errors/ok
    if !exists('g:loaded_ale')
        return ''
    endif
    if !g:loaded_ale
        return ''
    endif
    if !g:ale_enabled || empty(ale#linter#Get(&ft))
        return ''
    endif
    let counts = ale#statusline#Count(bufnr('%'))
    let total = counts.total
    let errors = counts.error + counts.style_error
    let warnings = counts.warning + counts.style_warning
    return s:get_parsed_linting_str(errors, warnings, total, a:mode)
endfun

function! s:get_parsed_linting_str(errors, warnings, total, mode) abort
    let errors_str = a:errors isnot# 0
                \ ? printf('%s %s', s:sl.checker.error_sign, a:errors)
                \ : ''
    let warnings_str = a:warnings isnot# 0
                \ ? printf('%s %s', s:sl.checker.warning_sign, a:warnings)
                \ : ''
    let def_str = printf('%s %s', errors_str, warnings_str)
    " Trim spaces
    let def_str = substitute(def_str, '^\s*\(.\{-}\)\s*$', '\1', '')
    let success_str = s:sl.checker.success_sign
    if a:mode
        return a:total is# 0 ? '' : def_str
    else
        return a:total is# 0 ? success_str : ''
    endif
endfun

function! Negcoc_diagnostic(mode) abort
    if !exists('g:coc_enabled')
        return ''
    endif
    if !g:coc_enabled
        return ''
    endif
    let infos = get(b:, 'coc_diagnostic_info', {})
    if empty(infos) | return '' | endif
    let errors = get(infos, 'error', 0)
    let warnings = get(infos, 'warning', 0)
    let total = errors + warnings
    return s:get_parsed_linting_str(errors, warnings, total, a:mode)
endfun

function! Negcoc_status() abort
    " No linting involved
    let status = get(g:, 'coc_status', '')
    let first_word = matchstr(status, '^\s*\zs\S*')
    " Replace the long strings by some fancy characters
    return empty(status)
                \ ? '' : first_word is# 'Python'
                \ ? '' : first_word is# 'TSC'
                \ ? '' : first_word
endfun

function! Get_SL(...) abort
    let sl = ''
    let sl .= '%1*%( %{Negpreviewwindow()} %)'
    let sl .= '%6*%(%{NegALE(0)} %)'
    let sl .= '%7*%([%{NegALE(1)}] %)'
    let sl .= '%6*%(%{Negcoc_diagnostic(0)} %)'
    let sl .= '%7*%([%{Negcoc_diagnostic(1)}] %)'
    let sl .= '%( %{Negjobs()} %)'
    let sl .= '%( %{Negcoc_status()} %)'
    return sl
endfun

augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END

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

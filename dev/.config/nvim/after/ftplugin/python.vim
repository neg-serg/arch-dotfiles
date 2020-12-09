let b:ale_linters = ['flake8', 'pylint']
let python_highlight_all = 1

" :Thx to Leeren:
" import conv.metrics (1)
" /conv.metrics/
" conv/metrics.python_highlight_all
" from conv import conversion as conv (2)
" /conv import conversion/
" conv/conversion.py conv.py
function! PyInclude(fname)
    let parts = split(a:fname, ' import ')
    let l = parts[0] " (1) conv.metrics (2) conv
    if len(parts) > 1
        let r = parts[1] " conversion
        let joined = join([l, r], '.') "conv.conversion
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . '.py.'
endfunction

setlocal includeexpr=PyInclude(v:fname)
setlocal define=^\\s*\\<(def\\\|class\\)\\>

setl foldmethod=expr

iabbrev <buffer> false False
iabbrev <buffer> true True

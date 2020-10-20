" Vim filetype plugin file
" Language: python
" Maintainer:   Tom Picton <tom@tompicton.co.uk>
" Previous Maintainer: James Sully <sullyj3@gmail.com>
" Previous Maintainer: Johannes Zellner <johannes@zellner.org>
" Last Change:  Sun 17 Mar 2019
" https://github.com/tpict/vim-ftplugin-python

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1
let s:keepcpo=&cpo
set cpo&vim

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal include=^\\s*\\(from\\\|import\\)

setlocal suffixesadd=.py
setlocal comments=b:#,fb:-
setlocal commentstring=#\ %s

set wildignore+=*.pyc

if has('browsefilter') && !exists('b:browsefilter')
    let b:browsefilter = "Python Files (*.py)\t*.py\n" .
                \ "All Files (*.*)\t*.*\n"
endif

if !exists('g:python_recommended_style') || g:python_recommended_style != 0
    " As suggested by PEP8.
    setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
endif

" First time: try finding "pydoc".
if !exists('g:pydoc_executable')
    if executable('pydoc')
        let g:pydoc_executable = 1
    else
        let g:pydoc_executable = 0
    endif
endif

" If 'pydoc' was found use it for keywordprg.
if g:pydoc_executable
    setlocal keywordprg=pydoc
endif

" Script for filetype switching to undo the local stuff we may have changed
let b:undo_ftplugin = 'setlocal cinkeys<'
      \ . '|setlocal comments<'
      \ . '|setlocal commentstring<'
      \ . '|setlocal expandtab<'
      \ . '|setlocal include<'
      \ . '|setlocal includeexpr<'
      \ . '|setlocal indentkeys<'
      \ . '|setlocal keywordprg<'
      \ . '|setlocal omnifunc<'
      \ . '|setlocal shiftwidth<'
      \ . '|setlocal softtabstop<'
      \ . '|setlocal suffixesadd<'
      \ . '|setlocal tabstop<'

let &cpo = s:keepcpo
unlet s:keepcpo

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

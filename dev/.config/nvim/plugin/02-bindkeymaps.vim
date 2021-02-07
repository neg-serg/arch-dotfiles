let mapleader = ','
let g:mapleader = ','
nnoremap Y y$
noremap <expr> G &wrap ? "G$g0" : "G"
noremap <expr> 0 &wrap ? 'g0' : '0'
noremap <expr> $ &wrap ? "g$" : "$"
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" thx to ralismark.xyz/2020/08/29/how-i-use-vim-1.html
" Fixed I/A for visual
xnoremap <expr> I mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"
xnoremap <expr> A mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"

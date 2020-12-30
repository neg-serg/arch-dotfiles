let mapleader = ','
let g:mapleader = ','
nnoremap Y y$
noremap <expr> G &wrap ? "G$g0" : "G"
noremap <expr> 0 &wrap ? 'g0' : '0'
noremap <expr> $ &wrap ? "g$" : "$"
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
" These create newlines like o and O but stay in normal mode
nnoremap <silent> zJ o<Esc>k
nnoremap <silent> zK O<Esc>j
" thx to ralismark.xyz/2020/08/29/how-i-use-vim-1.html
" Fixed I/A for visual
xnoremap <expr> I mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"
xnoremap <expr> A mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"
" Toggle hlsearch for current results, start highlight
nnoremap <Leader><Leader> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<CR><C-l>
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
map <C-g> g<C-g>
" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_
nnoremap q <NOP>
nnoremap Q q
nmap e [Qleader]
nnoremap <silent> [Qleader]n :normal :<C-u>cnext<CR>
nnoremap <silent> [Qleader]p :normal :<C-u>cprevious<CR>
nnoremap <silent> [Qleader]R :normal :<C-u>crewind<CR>
nnoremap <silent> [Qleader]N :normal :<C-u>cfirst<CR>
nnoremap <silent> [Qleader]P :normal :<C-u>clast<CR>
nnoremap <silent> [Qleader]l :normal :<C-u>clist<CR>
nnoremap [Qleader]w :w!<cr>
" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '
" like firefox tabs
nnoremap <silent> <M-w> :bd<CR>
cmap <C-V> <C-R>+
exe 'inoremap <script> <C-v> <C-g>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-v> ' . paste#paste_cmd['v']
" fix for floating windows
nnoremap <C-c> <C-[>
inoremap <C-c> <C-[>
" Escape as normal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> <leader><Tab> :b#<CR>
nnoremap <silent> <M-1> :b 1<CR>
nnoremap <silent> <M-2> :b 2<CR>
nnoremap <silent> <M-3> :b 3<CR>
nnoremap <silent> <M-4> :b 4<CR>
nnoremap <silent> <M-5> :b 5<CR>

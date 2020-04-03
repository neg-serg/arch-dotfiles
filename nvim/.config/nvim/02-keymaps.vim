nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>

" Some helpers to edit mode (http://vimcasts.org/e/14)
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

nnoremap Y y$
nnoremap ; :

let mapleader      = ','
let maplocalleader = ' '
let g:mapleader    = ","

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Right> <Nop>
noremap <Left> <Nop>

nnoremap <silent> <leader>4 :set cursorline!<CR>
nnoremap <silent> [Qleader]cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <silent> cow :set wrap!<CR>  
nnoremap <silent> cop :setlocal paste!<Return>
nnoremap <silent> cos :setlocal spell!<Return>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zJ o<Esc>k
nnoremap <silent> zK O<Esc>j

" Toggle hlsearch for current results, start highlight
nnoremap <leader><leader> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

map Q gq

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <C-g> g<C-g>

nnoremap <leader>D "_d
xnoremap <leader>D "_d

" Toggle last active buffer
nnoremap <leader><Tab> :b#<CR>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

nnoremap Q q
nnoremap [Qleader] <Nop>
nmap e [Qleader]
nnoremap <silent> [Qleader]n :normal :<C-u>cnext<CR>
nnoremap <silent> [Qleader]p :normal :<C-u>cprevious<CR>
nnoremap <silent> [Qleader]R :normal :<C-u>crewind<CR>
nnoremap <silent> [Qleader]N :normal :<C-u>cfirst<CR>
nnoremap <silent> [Qleader]P :normal :<C-u>clast<CR>
nnoremap <silent> [Qleader]l :normal :<C-u>clist<CR>

" semicolon magic
nnoremap [Qleader]w :w!<cr>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

nnoremap [Qleader]- :resize -10<CR>
nnoremap [Qleader]+ :resize +10<CR>
nnoremap [Qleader], :vertical resize -10<CR>
nnoremap [Qleader]. :vertical resize +10<CR>

" Macros editing
nnoremap <leader>m :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" use U for redo
nnoremap U <C-r>
" like firefox tabs
nnoremap <silent> <A-w> :bd<CR>

cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
nnoremap <silent> <C-w>v :vnew<CR>
nnoremap <silent> <C-w>s :new<CR>

" fix floating windows
nnoremap <C-C> <C-[>
inoremap <C-C> <C-[>

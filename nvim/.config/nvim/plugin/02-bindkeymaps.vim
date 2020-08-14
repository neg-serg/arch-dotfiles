let mapleader      = ','
let g:mapleader    = ","

nnoremap q <NOP>
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>
nnoremap Y y$
nnoremap ; :
nnoremap S f

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

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <C-g> g<C-g>

" Toggle last active buffer
nnoremap <silent> <leader><Tab> :b#<CR>

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

" use U for redo
nnoremap U <C-r>
" like firefox tabs
nnoremap <silent> <A-w> :bd<CR>

cmap <C-V> <C-R>+
exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

" fix for floating windows
nnoremap <C-c> <C-[>
inoremap <C-c> <C-[>

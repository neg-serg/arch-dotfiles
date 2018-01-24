let g:strange_keymaps=''

if g:strange_keymaps
    nnoremap 4 $
    nnoremap $ 4
endif

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

nnoremap Y y$

nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction

let mapleader      = ','
let maplocalleader = ' '
let g:mapleader    = ","

"Annoying %)
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
nnoremap <space> <Nop>

nnoremap <silent> <leader>4 :set cursorline!<CR>
nnoremap <silent> <space>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap <silent> <F2> :set invpaste paste?<CR>
set pastetoggle=<A-p>

" Toggle some opts
nnoremap <silent> cow :set wrap!<CR>
nnoremap <silent> cof :call ToggleOptionFlags('formatoptions', ['a','t'])<Return>
nnoremap <silent> cop :setlocal paste!<Return>
nnoremap <silent> cos :setlocal spell!<Return>
nnoremap <silent> coz :setlocal foldenable!<Return>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" semicolon magic
nnoremap <Space>w :w!<cr>
nnoremap q4 :q<cr>

map <silent><space>l :set rnu!<cr>

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

" Easier horizontal scrolling
map zl zL
map zh zH
"-------[ Quickfix ]------------------------------------------------
nnoremap Q q
nnoremap [Quickfix] <Nop>
nmap q [Quickfix]
nnoremap <silent> [Quickfix]n :normal :<C-u>cnext<CR>
nnoremap <silent> [Quickfix]p :normal :<C-u>cprevious<CR>
nnoremap <silent> [Quickfix]r :normal :<C-u>crewind<CR>
nnoremap <silent> [Quickfix]N :normal :<C-u>cfirst<CR>
nnoremap <silent> [Quickfix]P :normal :<C-u>clast<CR>
nnoremap <silent> [Quickfix]l :normal :<C-u>clist<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <space>g g<c-]>

nnoremap <C-w>- :resize -10<CR>
nnoremap <C-w>+ :resize +10<CR>
nnoremap <C-w>, :vertical resize -10<CR>
nnoremap <C-w>. :vertical resize +10<CR>

" Macros editing
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" use U for redo
noremap U <C-r>

" Strip trailing workspaces
nnoremap <silent> <Space><C-s> :call StripTrailingWhitespace()<Return>

nnoremap <F1> :echom
	\ ' hi['
	\ . synIDattr(synID(line('.'),col('.'),1),'name')
	\ . '] trans['
	\ . synIDattr(synID(line('.'),col('.'),0),'name')
	\ . '] lo['
	\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')
	\ . ']'
	\ . ' fg[' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'fg#')
	\ . ']' <CR>

" Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nnoremap <expr><silent> _     v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"

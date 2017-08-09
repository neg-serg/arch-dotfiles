let g:strange_keymaps=''

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

if g:strange_keymaps
    nnoremap 4 $
    nnoremap $ 4
endif

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" paste from clipboard
map <space>pp :set paste<CR>o<esc> "*]p:set nopaste<cr>

nnoremap Y y$

" Indent paste.
nnoremap <silent> ep o<Esc>pm``[=`]``^
xnoremap <silent> ep o<Esc>pm``[=`]``^
nnoremap <silent> eP O<Esc>Pm``[=`]``^
xnoremap <silent> eP O<Esc>Pm``[=`]``^

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
map <Right> <Nop>
map <Left> <Nop>
nmap <space> <Nop>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
" Get Rid of stupid Goddamned help keys
inoremap <F1> <Nop>
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>

nnoremap <silent> <leader>4 :set cursorline!<CR>

nnoremap <silent> <space>cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <silent> <F2> :set invpaste paste?<CR>
nnoremap <M-z> :set invpaste paste?<CR>

set pastetoggle=<A-z>

nnoremap <silent><space>W :set wrap!<CR>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Now we don't have to move our fingers so far when we want to scroll through
" the command history; also, don't forget the q: command (see :h q: for more
" info)
cnoremap <C-j> <down>
cnoremap <C-k> <up>

cnoremap $q <C-\>eDeleteTillSlash()<cr>

" semicolon magic
nnoremap <Space>w :w!<cr>
nnoremap q4 :q<cr>

map <silent><space>l :set rnu!<cr>

" like firefox tabs
nnoremap <silent> <A-w> :Bclose<CR>

" Toggle hlsearch for current results
nnoremap <leader><leader> :nohlsearch<CR>
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

nnoremap <leader>R :call Ranger()<CR>

nnoremap <C-w>- :resize -10<CR>
nnoremap <C-w>+ :resize +10<CR>
nnoremap <C-w>, :vertical resize -10<CR>
nnoremap <C-w>. :vertical resize +10<CR>

" quick run for neovim internal terminal 
if has('nvim')
    nmap <Leader>ds :vsplit<CR>:term<CR>
    function! QuickTerminal()
        10new
        terminal
        file quickterm
    endfunction

    nnoremap <silent> <Leader>t :call QuickTerminal()<CR>
endif

" Macros editing
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Toggle some options
nnoremap <silent> cof :call ToggleOptionFlags('formatoptions', ['a','t'])<Return>
nnoremap <silent> cop :setlocal paste!<Return>
nnoremap <silent> cos :setlocal spell!<Return>
nnoremap <silent> coz :setlocal foldenable!<Return>

" use U for redo
noremap U <C-r>

" Strip trailing workspaces
nnoremap <silent> <Space><C-s> :call StripTrailingWhitespace()<Return>

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
noremap <silent> <Space>y y:call system(expand($HOME.'/bin/scripts/yank').' > /dev/tty', @0)<Return>

nmap <F1> :echom
	\ ' hi['
	\ . synIDattr(synID(line('.'),col('.'),1),'name')
	\ . '] trans['
	\ . synIDattr(synID(line('.'),col('.'),0),'name')
	\ . '] lo['
	\ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')
	\ . ']'
	\ . ' fg[' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'fg#')
	\ . ']' <CR>

nnoremap <leader>L :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <silent> <Up>    :cprevious<CR>
nnoremap <silent> <Down>  :cnext<CR>
nnoremap <silent> <Left>  :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" deoplete tab-complete
inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<Tab>"

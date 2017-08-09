nmap ;w :w!<cr>
nmap ;q :q<cr>
nmap ;d :bd<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Same for 0, home, end, etc
noremap $ g$
noremap <End> g<End>
noremap 0 g0
noremap <Home> g<Home>
noremap ^ g^

" Toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>
" Toggle hlsearch for current results
nnoremap <leader><leader> :nohlsearch<CR>

"-------------
"Highlight search
"--
nnoremap * *N
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>
nnoremap <C-F8> :nohlsearch<CR>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

nmap <silent> <leader>l :LustyFilesystemExplorer<CR>
"nmap <silent> <leader>r :LustyFilesystemExplorerFromHere<CR>
nmap <silent> <leader>r :LustyBufferExplorer<CR>
nmap <silent> <leader>g :LustyBufferGrep<CR>
nmap <silent> <leader>b :LustyJuggler<CR>

map ,e ^wy$:r!"
nnoremap <Leader>a ggVG
inoremap <CR> <C-g>u<CR>
nnoremap ! :%!
xnoremap ! :!

map Q gq

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" S-arrows suck
vnoremap <S-Up> <Up>
inoremap <S-Up> <Up>
nnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
inoremap <S-Down> <Down>
nnoremap <S-Down> <Down>
" Indent fun
"vnoremap > >gv
vnoremap < <gv
" Annoying
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

noremap! <M-Backspace> <C-W>
noremap! <M-Left> <C-Left>
noremap! <M-Right> <C-Right>

"---------------------------------------------------------------
" => Cope
"---------------------------------------------------------------
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

imap <C-c>sw <Esc>:AT<CR>
nmap <C-c>sw :AT<CR>

map <C-c>gt :!ctags -a *.c *.h<CR>
map <C-c>gT :!ctags -Ra *.c *.h<CR>

" List of errors
imap <C-c>l <Esc>:copen<CR>
nmap <C-c>l :copen<CR>
map <C-g> g<C-g>
inoremap <M-H> h
inoremap <M-L> l
inoremap <M-K> <C-g>k
inoremap <M-J> <C-g>j

nmap <silent> <leader>sp  :set syn=perl   <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sv  :set syn=vim    <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sz  :set syn=sh     <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sc  :set syn=config <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sf  :set syn=conf   <CR> :syntax sync fromstart <CR>

" make those behave like ci' , ci"
nnoremap ci( f(ci(
nnoremap ci{ f{ci{
nnoremap ci[ f[ci[

vnoremap ci( f(ci(
vnoremap ci{ f{ci{
vnoremap ci[ f[ci[

"nnoremap d= f=d$a=
"nnoremap d> f>d$a>

nnoremap <C-n>     :bnext<CR>
nnoremap <C-p>     :bprev<CR>

"call Cabbrev('/',   '/\v')
"call Cabbrev('?',   '?\v')
"call Cabbrev('s/',  's/\v')
"call Cabbrev('%s/', '%s/\v')
"call Cabbrev('s#',  's#\v')
"call Cabbrev('%s#', '%s#\v')
"call Cabbrev('s@',  's@\v')
"call Cabbrev('%s@', '%s@\v')
"call Cabbrev('s!',  's!\v')
"call Cabbrev('%s!', '%s!\v')
"call Cabbrev('s%',  's%\v')
"call Cabbrev('%s%', '%s%\v')
"call Cabbrev('/',   '/\v')
"call Cabbrev("'<,'>s/", "'<,'>s/\v")
"call Cabbrev("'<,'>s#", "'<,'>s#\v")
"call Cabbrev("'<,'>s@", "'<,'>s@\v")
"call Cabbrev("'<,'>s!", "'<,'>s!\v")
"vnoremap /        /\v

nnoremap p ]p
nnoremap <c-p> p
" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>
" Bindings for ctk
nnoremap <LocalLeader>C :CC<cr>

nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr> 

imap <S-Insert> <C-o>p
" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

map <C-c>np :emenu NewProj.<TAB>

imap <Esc>OH <Plug>delimitMateHome
imap <Esc>OF <Plug>delimitMateEnd

cno $q <C-\>eDeleteTillSlash()<cr>
cno $c e <C-\>eCurrentFileDir("e")<cr>

"inoremap jj <ESC> "Better insert-mode interrupting
inoremap jk <ESC>

cmap     qq     qa!<CR>  " quit really, really fast
cmap     wqq    qw<CR>   " quit really, really fast(with saving)

nmap <F12> :call UpdateCscopeDb()<cr>
vmap <F12> <esc>:call UpdateCscopeDb()<cr>
imap <F12> <esc>:call UpdateCscopeDb()<cr>

" " Use sane regexes.
" nnoremap / /\v
" vnoremap / /\v
" nnoremap ? ?\v
" vnoremap ? ?\v

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" search helper {{{
nmap <C-w>/  <C-w>v<C-w>l:redraw<CR>/
nmap <C-w>*  <C-w>v<C-w>l:redraw<CR>*
nmap <C-w>#  <C-w>v<C-w>l:redraw<CR>#

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
"}
map <Right> <Nop>
map <Left> <Nop>

" Toggle last active buffer
nnoremap <leader><Tab> :b#<CR>

"------------ YouCompleteMe ----------------------------------
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_key_invoke_completion = '<A-x>'
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"------------ UltiSnips ----------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:Ultisnips_ListSnippets=""

map <S-H> gT
map <S-L> gt

" Stupid shift key fixes
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>

    cmap Tabe tabe
endif
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Tabularize {
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }
" Session List {
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    nmap <leader>sl :SessionList<CR>
    nmap <leader>ss :SessionSave<CR>
" }
" TagBar {
    nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    nnoremap <silent> <leader>gg :GitGutterToggle<CR>
"}

nmap <silent> <F11>                        <Plug>FontsizeBegin
nmap <silent> <SID>DisableFontsizeInc     <Plug>FontsizeInc
nmap <silent> <SID>DisableFontsizeDec     <Plug>FontsizeDec
nmap <silent> <SID>DisableFontsizeDefault <Plug>FontsizeDefault


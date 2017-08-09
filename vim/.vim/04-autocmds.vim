" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
    autocmd!
    au BufRead *.session let g:session = expand('%:p:h') | so % | bd #
    au VimLeave * if exists('g:session') | call Mks(g:session) | endif
    au BufEnter * call MySetupTitleString()
augroup end
au StdinReadPost * set buftype=nofile
au BufReadCmd file:///* exe "bd!|edit ".substitute(expand("<afile>"),"file:/*","","")

fun! Mks(path)
    exe "mksession! ".a:path."/".fnamemodify(a:path, ':t').".session"
endfun

" Return to last edit position (You want this!) *N*
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" --- [ Autocmds ] --------------------------------------------------------------------------
autocmd vimrc BufRead,BufNewFile  *.viki         setlocal ft=viki
autocmd vimrc BufNewFile,BufRead  *.t2t          setlocal ft=txt2tags
autocmd vimrc Filetype            txt2tags       source   $HOME/.vim/syntax/txt2tags.vim
autocmd vimrc FileType            make           setlocal noexpandtab
autocmd vimrc FileType            javascript     setlocal noautoindent nosmartindent
autocmd vimrc FileType            tex            setlocal conceallevel=0 updatetime=1000
autocmd vimrc FileType            latex          setlocal conceallevel=0 updatetime=1000
autocmd vimrc FileType            markdown       call MarkdownKeymaps()
autocmd vimrc BufNewFile,BufRead  *.t2t          setlocal wrap lbr
autocmd vimrc BufRead,BufNewFile  *.json         setlocal filetype=json foldmethod=syntax
autocmd vimrc BufNewFile,BufRead  .pentadactylrc setlocal filetype=pentadactyl

autocmd vimrc FileType git set nofoldenable

function! MarkdownKeymaps()
    " format current line as a top-level heading in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=1 mzyyp:s/^\s*//<Return>Vr===:.+g/^\s*=\+\s*/d<Return>`z

    " format current line as a second-level heading in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=2 mzyyp:s/^\s*//<Return>Vr-==:.+g/^\s*-\+\s*/d<Return>`z

    " format current line as table/body separator in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=<Bar> mzyyp:s/^\s*//
        \ <Bar>s/[^<Bar>]/-/g
        \ <Bar>s/-<Bar>/ <Bar>/g
        \ <Bar>s/<Bar>-/<Bar> /g<Return>
        \ ==:.+g/^\s*[<Bar>-]\+\s*/d<Return>`z

    " format selected Markdown indented code block into a fenced code block
    vnoremap <silent><buffer> <Leader>=` 2<']o<Esc>3i`<Esc>yy<C-o>PA
endfunction

autocmd vimrc BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
autocmd vimrc BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78

autocmd vimrc BufReadPre  *.doc set ro | silent %!antiword "%"
autocmd vimrc BufReadPost *.odt silent %!odt2txt "%"

autocmd vimrc BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
autocmd vimrc FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd vimrc BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

autocmd vimrc BufRead,BufNewFile rc.lua setlocal foldmethod=marker
autocmd vimrc FileType ruby setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd vimrc FileType ruby setlocal re=1 nornu

autocmd vimrc FileType javascript setl fen
autocmd vimrc BufRead,BufNewFile *.textile setf textile

augroup filetypedetect
    autocmd BufReadPost,BufNewFile .sawmillrc,.sawfishrc,*.jl setfiletype lisp
    autocmd BufReadPost,BufNewFile *.tmpl                     setfiletype html
    autocmd BufReadPost,BufNewFile *.wiki                     setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile *wikipedia.org.*           setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.fc.hp.com.*         setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.hp.com.*            setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile griffis1.net.*             setfiletype Wikipedia
augroup END

autocmd vimrc FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,rust,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd vimrc FileType c,cpp,bash,zsh,sh let b:delimitMate_matchpairs = "(:),[:],{:}" | hi Function guifg=#85A2CC | let b:indentLine_enabled = 1

" This handles c++ files with the ".cc" extension.
augroup ccfiles
  autocmd!
  autocmd BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  autocmd BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  autocmd BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  autocmd BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END

autocmd vimrc FileType go                     autocmd BufWritePre <buffer> Fmt
autocmd vimrc FileType haskell,rust           setlocal expandtab shiftwidth=4 softtabstop=4 nospell
autocmd vimrc BufNewFile,BufRead *.html.twig  set filetype=html.twig
augroup json_autocmd
  autocmd FileType json set foldmethod=syntax
augroup END

function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! GHDashboard (...)
  if &filetype == 'github-dashboard'
    " first variable is the statusline builder
    let builder = a:1

    call builder.add_section('airline_a', 'GitHub ')
    call builder.add_section('airline_b',
                \ ' %{get(split(get(split(github_dashboard#statusline(), " "),
                \ 1, ""), ":"), 0, "")} ')
    call builder.add_section('airline_c',
                \ ' %{get(split(get(split(github_dashboard#statusline(), " "),
                \ 2, ""), "]"), 0, "")} ')

    " tell the core to use the contents of the builder
    return 1
  endif
endfunction

autocmd vimrc FileType github-dashboard call airline#add_statusline_func('GHDashboard')

" UltiSnips is missing a setf trigger for snippets on BufEnter
autocmd vimrc BufEnter *.snippets setf snippets

" In UltiSnips snippet files, we want actual tabs instead of spaces for indents.
" US will use those tabs and convert them to spaces if expandtab is set when the
" user wants to insert the snippet.
autocmd vimrc FileType snippets set noexpandtab

" The stupid python filetype plugin overrides our settings!
autocmd vimrc FileType python
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4 |
      \ setlocal completeopt-=preview |
      \ setlocal foldlevel=1000 |
      \ map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

" Turn on spell checking by default for git commit messages
autocmd vimrc FileType gitcommit setlocal spell! spelllang=en_us
autocmd vimrc FileType markdown setlocal spell! spelllang=en_us tw=77 fo+=t

let g:indent_guides_auto_colors = 0
autocmd vimrc VimEnter,Colorscheme * hi IndentGuidesOdd  ctermbg=239
autocmd vimrc VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240

"------------------------------------------------------------------------------------------------------------------
function! s:on_FileType_help_define_mappings()
    if &l:readonly
        nnoremap <buffer>J <C-]>
        nnoremap <buffer>K <C-t>
        nnoremap <buffer><silent><Tab> /\%(\_.\zs<Bar>[^ ]\+<Bar>\ze\_.\<Bar>CTRL-.\<Bar><[^ >]\+>\)<CR>
        nnoremap <buffer>u <C-u>
        nnoremap <buffer>d <C-d>
        nnoremap <buffer>q :<C-u>q<CR>
    endif
endfunction
autocmd vimrc Filetype help call s:on_FileType_help_define_mappings()

" git-rebase
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-p> :<C-u>Pick<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-s> :<C-u>Squash<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-e> :<C-u>Edit<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-r> :<C-u>Reword<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-f> :<C-u>Fixup<CR>

autocmd vimrc FileType slim                                set commentstring=/\ %s
autocmd vimrc FileType xdefaults                           set commentstring=!%s
autocmd vimrc FileType gtkrc,nginx,inittab,tmux,sshdconfig set commentstring=#%s

augroup modechange_settings
  autocmd!

  " Clear search context when entering insert mode, which implicitly stops the
  " highlighting of whatever was searched for with hlsearch on. It should also
  " not be persisted between sessions.
  autocmd InsertEnter * let @/ = ''
  autocmd BufReadPre,FileReadPre * let @/ = ''

  autocmd InsertLeave * setlocal nopaste
augroup END

if has('autocmd')
    fun! MyAutoScrollOff()
        if exists('g:no_auto_scrolloff')
            return
        endif
        if &ft == 'help'
            let scrolloff = 999
        elseif &buftype != ""
            " Especially with quickfix (mouse jumping, more narrow).
            let scrolloff = 0
        elseif &diff
            let scrolloff = 10
        else
            let scrolloff = 3
        endif
        if &scrolloff != scrolloff
            let &scrolloff = scrolloff
        endif
    endfun
    augroup set_scrolloff
        au!
        au BufEnter,WinEnter * call MyAutoScrollOff()
        if exists('#TermOpen')  " neovim
            au TermOpen * set sidescrolloff=0 scrolloff=0
        endif
    augroup END
endif

" enter will work in command edit mode as intended, since by default it's
" mapped to :nohl
autocmd vimrc CmdwinEnter * noremap <buffer><CR> <CR>
if has("nvim")
    augroup Terminal
        au!
        au TermOpen * let g:last_terminal_job_id = b:terminal_job_id | IndentLinesDisable
        au BufWinEnter term://* startinsert | IndentLinesDisable
    augroup END
    augroup nvimrc_aucmd
        autocmd!
        autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
    augroup END
endif

" if get(g:, 'lint_on_save', 1)
"     augroup Neomake_on_save
"         au!
"         autocmd! BufWritePost * call s:neomake()
"     augroup END
" endif

" let g:__toggle_syntax_flag = 1

" function! s:neomake() abort
"     if g:__toggle_syntax_flag == 1
"         Neomake
"     endif
" endfunction

" if get(g:, 'lint_on_the_fly', 0)
"     let g:neomake_tempfile_enabled = 1
"     let g:neomake_open_list = 0
"     augroup Neomake_on_the_fly
"         au!
"         autocmd! TextChangedI * call s:neomake()
"     augroup END
" endif

" augroup Neomake_on_save
"     au!
"     autocmd! BufWritePost * call s:neomake()
" augroup END

" augroup Vim_core
"     au!
"     autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
"             \   q :cclose<cr>:lclose<cr>
"     autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
"             \   bd|
"             \   q | endif
"     autocmd FileType html,css,jsp EmmetInstall
"     autocmd BufRead,BufNewFile *.pp setfiletype puppet
"     if g:enable_cursorline == 1
"         autocmd BufEnter,WinEnter,InsertLeave * setl cursorline
"         autocmd BufLeave,WinLeave,InsertEnter * setl nocursorline
"     endif
"     if g:enable_cursorcolumn == 1
"         autocmd BufEnter,WinEnter,InsertLeave * setl cursorcolumn
"         autocmd BufLeave,WinLeave,InsertEnter * setl nocursorcolumn
"     endif
"     autocmd BufReadPost *
"             \ if line("'\"") > 0 && line("'\"") <= line("$") |
"             \   exe "normal! g`\"" |
"             \ endif
"     autocmd BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
"     autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
"     autocmd BufNewFile,BufRead *.avs set syntax=avs " for avs syntax file.
"     autocmd FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters.
"     autocmd FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.
"     autocmd FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
"     autocmd FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f://
"     autocmd FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
"     autocmd FileType lua set comments=f:--
"     autocmd FileType vim setlocal foldmethod=marker
"     autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"     autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"     autocmd Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
"     autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"     autocmd FileType xml call XmlFileTypeInit()
"     autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"     autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"     autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"     autocmd FileType python,coffee call zvim#util#check_if_expand_tab()
" augroup END

" " Instead of reverting the cursor to the last position in the buffer, we
" " set it to the first line when editing a git commit message
" au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" " disable touchpad when typing
" if executable('synclient')
"     let s:touchpadoff = 0
"     autocmd InsertEnter * call s:disable_touchpad()
"     autocmd InsertLeave * call s:enable_touchpad()
"     autocmd FocusLost * call system('synclient touchpadoff=0')
"     autocmd FocusGained * call s:reload_touchpad_status()
" endif

" function! s:reload_touchpad_status() abort
"     if s:touchpadoff
"         call s:disable_touchpad()
"     endif
" endf
" function! s:disable_touchpad() abort
"     let s:touchpadoff = 1
"     call system('synclient touchpadoff=1')
" endfunction
" function! s:enable_touchpad() abort
"     let s:touchpadoff = 0
"     call system('synclient touchpadoff=0')
" endfunction

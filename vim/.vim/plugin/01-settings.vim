set shell=/bin/bash
if bufname('%') == ''
  set bufhidden=wipe
endif

let g:impact_transbg=1
let g:enable_cursorline=0
let g:enable_cursorcolumn=0

if v:version >= 704
    " The new Vim regex engine is currently slooooow as hell which makes syntax
    " highlighting slow, which introduces typing latency.
    " Consider removing this in the future when the new regex engine becomes
    " faster.
    " set regexpengine=1
    " Now I make it autodetect
    set regexpengine=0
endif

set regexpengine=1

set conceallevel=2
set concealcursor=i

if has('filterpipe')
    set noshelltemp
endif

" Options initiating with ?m?
" [global] |'magic'| Set 'magic' patterns ;)
" Examples:
"  \v       \m       \M       \V         matches ~
"  $        $        $        \$         matches end-of-line
"  .        .        \.       \.         matches any character
"  *        *        \*       \*         any number of the previous atom
"  ()       \(\)     \(\)     \(\)       grouping into an atom
"  |        \|       \|       \|         separating alternatives
"  \a       \a       \a       \a         alphabetic character
"  \\       \\       \\       \\         literal backslash
"  \.       \.       .        .          literal dot
"  \{       {        {        {          literal '{'
"  a        a        a        a          literal 'a'
set magic

set path+=.,..,./include,../include,/usr/include
execute 'set path+=/usr/lib/modules/'.system('uname -r')[:-2].'/build/include'
execute 'set path+=/usr/lib/modules/'.system('uname -r')[:-2].'/build/arch/x86/include'

set isfname+={
set isfname+=}

set background=dark
colorscheme neg

if !has("gui_running") && exists('$TMUX')
    let g:not_tmuxed_vim = system(expand("~/bin/scripts/not_tmuxed_wim"))
    if g:not_tmuxed_vim =~ "FALSE"
        set t_ut=
        if !exists('$ST_TERM')
            autocmd VimEnter * silent !echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            autocmd VimEnter * silent !tmux set -g prefix ^b > /dev/null
            autocmd VimEnter * silent !tmux bind-key C-b last-window > /dev/null
            let &t_SI="\033Ptmux;\033\033]12;rgb:32/4c/80\007\033\\"
            let &t_EI="\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            autocmd VimLeave * silent !tmux set status on;
                \ echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
        else
            if !has("nvim")
                autocmd VimEnter * silent !echo -ne "\ePtmux;\e\e]4;258;rgb:b0/d0/f0\a\e\\"
                let &t_SI = "\033Ptmux;\033\033]4;258;rgb:32/4c/80\007\033\\"
                let &t_EI = "\033Ptmux;\033\033]4;258;rgb:b0/d0/f0\007\033\\"
            endif
            autocmd VimEnter * silent !tmux set -g prefix ^b > /dev/null
            autocmd VimEnter * silent !tmux bind-key C-b last-window > /dev/null
            autocmd VimLeave * silent !tmux set status on;
                \ echo -ne "\ePtmux;\e\e]4;258;rgb:b0/d0/f0\a\e\\"
        endif
        autocmd VimEnter * silent !tmux set status off > /dev/null
        autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
        set timeout ttimeout
        set timeoutlen=2000 ttimeoutlen=0 " Very fast and also you shouldn't make combination too fast
    endif
endif

" convert "\\" to "/" on win32 like environment
if exists('+shellslash')
    set shellslash
endif
if has('user_commands')
    command! -range=% Share silent <line1>,<line2>write !curl -s -F "sprunge=<-" http://sprunge.us | head -n 1 | tr -d '\r\n ' | DISPLAY=:0.0 xclip
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
    command! -nargs=0 Sw :SudoWrite
    command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
    "command! -nargs=0 curf let @+=expand("%:p")
endif
"----------------------------------------------------------------------------
set keywordprg=:help
let $PATH = $PATH . ':' . expand("~/bin/go/bin")

set encoding=utf-8                          " Set default enc to utf-8
scriptencoding utf-8                        " Encoding used in the script
" set autowrite                             " Autowrite by default
set noautowrite                             " Don't autowrite by default
" set autoread                              " Auto reload
set noautochdir                             " Dont't change pwd automaticly
" set autochdir                             " Change pwd automaticly
set noshowmode                              " no show the mode ("-- INSERT --") at the bottom

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
set autoread
if executable(resolve(expand("par")))
    set formatprg="par -140"  " use par as formatter
else
    set formatprg="fmt -140"  " use fmt as formatter
endif

" 'fileencodings' contains a list of possible encodings to try when reading
" a file.  When 'encoding' is a unicode value (such as utf-8), the
" value of fileencodings defaults to ucs-bom,utf-8,default,latin1.
"   ucs-bom  Treat as unicode-encoded file if and only if BOM is present
"   utf-8    Use utf-8 encoding
"   default  Value from environment LANG
"   latin1   8-bit encoding typical of DOS
" Setting this value explicitly, though to the default value.
set fileencodings=utf-8,default,latin1,cp1251,koi8-r,cp866
set termencoding=utf8                       " Set termencoding to utf-8
"--------------------------------------------------------------------------
" Where file browser's directory should begin:
"   last    - same directory as last file browser
"   buffer  - directory of the related buffer
"   current - current directory (pwd)
"   {path}  - specified directory
set browsedir=buffer

" What to do when opening a new buffer. May be empty or may contain
" comma-separated list of the following words:
" useopen   - use existing windows if possible.
" usetab    - like useopen but also checks other tabs
" split     - split current window before loading a buffer
" 'useopen' may be useful for re-using QuickFix window.
set switchbuf=useopen,usetab

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as '*'.
  " See :h 'clipboard' for details.
  if has ('x') && has ('gui') " On Linux use + register for copy-paste
      set clipboard=unnamedplus
  elseif has ('gui')          " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
  endif
  set clipboard=unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" Protect home directory
if !empty($SUDO_USER) && $USER !=# $SUDO_USER
  set viminfo=
  set directory-=~/trash
  set backupdir-=~/trash
endif

set completeopt=menu,menuone,longest
"probably it will increase lusty+gundo speed
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set noshowmatch                 " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set winminwidth=0               " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set matchtime=2                 " Default time to hi brackets too long for me

if has('multi_byte') && &encoding ==# 'utf-8'
    set listchars=tab:›…,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    if has('patch-7.4.338')
        " Show ↪ at the beginning of wrapped lines
        let &showbreak = nr2char(8618).' '
        set breakindent
        set breakindentopt=sbr
    endif
endif

" allow backspace and cursor keys to cross line boundaries
set gdefault                    " this makes search/replace global by default
set showcmd                     " Show partial commands in status line and Selected characters/lines in visual mode

" set nowrap                    " Do not wrap lines
set wrap                        " Wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set sidescroll=1                " The minimal number of columns to scroll horizontally.
set sidescrolloff=10            " min num of scr columns to keep to the left and to the
                                " right of the cursor if 'nowrap' is set.
set virtualedit=onemore,block   " Allow for cursor beyond last character
set noswapfile                  " Disable swap to prevent ugly messages
set shortmess=a                 " Abbrev. of messages (avoids 'hit enter')
" set shortmess+=filmnrxoOtT    " Abbrev. of messages (avoids 'hit enter')
set more                        " probably it should get out 'Press enter' msg
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set nofoldenable                " Disable folds as
set history=1000                " Store a ton of history (default is 20)
set nospell                     " Spell checking off
set shiftwidth=4                " spaces for autoindents
set shiftround                  " makes indenting a multiple of shiftwidth
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set smarttab
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>             " Match, to be used with %
try
  set matchpairs+=《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474
endtry
set wildignore+=*.o,*.so,*.obj,.git,.svn
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.mp3
set wildignore+=*.sw?
set wildignore+=*.pyc
set wildignore+=__pycache__
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set equalalways                 " keep windows equal when splitting (default)
set eadirection=hor             " ver/hor/both - where does equalalways apply

set pastetoggle=<F2>            " Pastetoggle (sane indentation on pastes)
set nopaste                     " Disable paste by default
set hidden                      " It hides buffers instead of closing them
" Avoid command-line redraw on every entered character by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
  set noarabicshape
endif
"--[ change undo file location ]----------------------------------
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  silent !mkdir -p ~/trash > /dev/null 2>&1
  set undodir=~/trash/
  set undofile
endif

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set formatoptions+=t    " auto-wrap using textwidth (not comments)
set formatoptions+=c    " auto-wrap comments too
set formatoptions+=r    " continue the comment header automatically on <CR>
set formatoptions+=q    " allow formatting of comments with gq
set formatoptions+=n    " recognize numbered lists when autoindenting
set formatoptions+=l    " don't break long lines in insert mode
set formatoptions+=1    " don't break lines after one-letter words, if possible
" -------------------------------------------------------------------
set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
set formatoptions-=2    " don't use second line of paragraph when autoindenting
set formatoptions-=v    " don't worry about vi compatiblity
set formatoptions-=b    " don't worry about vi compatiblity
set formatoptions-=j    " delete comment character when joining
" Where it makes sense, remove a comment leader when joining lines.  For
" example, joining:
try
  " Vim 7.4
  set formatoptions+=j
catch /.*/
endtry

" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set autoindent          " on new lines, match indent of previous line
set nosmartindent       " disable smart auto indenting, I think it should be deprecated
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set laststatus=2        " requied by PowerLine/Airline

set nocursorline        " highlight current line is too slow
set backup              " backuping is good

set backupdir=~/trash
set directory=~/trash
set undofile            " So is persistent undo ...
set undolevels=1000     " Maximum number of changes that can be undone
set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
set cpoptions=a         " :read with a filename set the alternate filename for window
set cpoptions+=A        " -- : write --
set cpoptions+=c        " search -> end of any match at the cursor pos but not start of the next line
set cpoptions+=e        " :@r adds CR and nonlinewise
set cpoptions+=F        " :write set name for current buffer if no
set cpoptions+=s        " set buf opts before it created
set cpoptions+=B        " a backslash has no special meaning in mappings
set cpoptions+=d        " make ./ in tags relative to tags file in current dir
set cpoptions+=$        " no line redisplay -> put a '$' at the end

set maxfuncdepth=100    " Maximum depth of function calls for user functions
set maxmemtot=2000000   " Maximum amount of memory in Kbyte to use for all buffers together.
set maxmapdepth=1000    " Maximum number of times a mapping is done
                        " without resulting in a character to be used.
set maxmem=8188370      " Maximum amount of memory (in Kbyte) to use for one buffer
set maxmempattern=1000  " Maximum amount of memory (in Kbyte) to use for pattern matching.

if !has("nvim")
    set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
else
    set viminfo=
    set shada=
endif
set nomodeline                        " disable modelines
set grepprg=ag\ --nogroup\ --nocolor  " use ag over grep

set iminsert=0          " write latin1 characters first
set imsearch=0          " search with latin1 characters first
set cmdheight=1         " standard cmdline height

set tags=./tags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

if has("cscope")
    if executable("gtags")
        set csprg=/usr/bin/gtags-cscope
    else
        set csprg=/usr/bin/cscope
    endif
    set csto=0
    set cscopetag
    " set cscopequickfix=s-,c-,d-,i-,t-,e-

    let GtagsCscope_Auto_Map        = 1
    let GtagsCscope_Use_Old_Key_Map = 0
    let GtagsCscope_Ignore_Case     = 1
    let GtagsCscope_Absolute_Path   = 1
    let GtagsCscope_Keep_Alive      = 1
    let GtagsCscope_Auto_Load       = 0
endif

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix        = 1
" When using the taglist plugin, don't attempt to resize the terminal
let g:is_bash         = 1

let g:session_autoload = "no"
let g:session_autosave = "yes"

if has('clpum')
    set wildmode=popup
    set wildmenu
    set clpumheight=40
    set clcompletefunc=UserDefinedClComplete
    function! UserDefinedClComplete(findstart, base)
        if a:findstart
            return getcmdpos()
        else
            return [
            \   { 'word': 'Jan', 'menu': 'January' },
            \   { 'word': 'Feb', 'menu': 'February' },
            \   { 'word': 'Mar', 'menu': 'March' },
            \   { 'word': 'Apr', 'menu': 'April' },
            \   { 'word': 'May', 'menu': 'May' },
            \ ]
        endif
    endfunc
endif

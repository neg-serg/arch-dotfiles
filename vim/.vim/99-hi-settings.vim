" ------[ GUI settings ]-----------------------------------------------------
set t_Co=256                           " I use 256-color terminals
if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif
" colorscheme solarized

if !has("gui_running")
    " ENABLE CTRL INTERPRETING FOR VIM
    " silent !stty -ixon > /dev/null 2>/dev/null
    
    set ttyscroll=1024
    set lazyredraw
    colorscheme miromiro
endif
"----------------------------------------------------------------------------

set encoding=utf-8                          " Set default enc to utf-8
" set autowrite                             " Autowrite by default
set noautowrite                             " Don't autowrite by default
set noautochdir                             " Dont't change pwd automaticly

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
set autoread

" 'fileencodings' contains a list of possible encodings to try when reading
" a file.  When 'encoding' is a unicode value (such as utf-8), the
" value of fileencodings defaults to ucs-bom,utf-8,default,latin1.
"   ucs-bom  Treat as unicode-encoded file if and only if BOM is present
"   utf-8    Use utf-8 encoding
"   default  Value from environment LANG
"   latin1   8-bit encoding typical of DOS
" Setting this value explicitly, though to the default value.
set fileencodings=ucs-bom,utf-8,default,latin1,cp1251,koi8-r,cp866

set termencoding=utf8                       " Set termencoding to utf-8
set fileencodings=utf-8,cp1251              " Set fileenc list

set timeout timeoutlen=250
set ttimeout ttimeoutlen=40  " Usable for fast keybindings
"--------------------------------------------------------------------------
" Where file browser's directory should begin:
"   last    - same directory as last file browser
"   buffer  - directory of the related buffer
"   current - current directory (pwd)
"   {path}  - specified directory
set browsedir=buffer

" What to do when opening a new buffer. May be empty or may contain
" comma-separated list of the following words:
"   useopen   - use existing windows if possible.
"   usetab    - like useopen but also checks other tabs
"   split     - split current window before loading a buffer
" 'useopen' may be useful for re-using QuickFix window.
set switchbuf=

syntax sync minlines=256
" set completeopt=menu
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab
"syn sync minlines=1000
"probably it will increase lusty+gundo speed
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set winminwidth=0               " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set matchtime=3                 " Default time to hi brackets too long for me

" set nowrap                      " Do not wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set clipboard-=autoselect clipboard+=autoselectml
" Windowing settings set splitright splitbelow
"set swapsync=""                " don't call fsync() or sync(); let linux handle it
" set autowrite                   " Automatically write a file when leaving a modified buffer
set virtualedit=onemore         " Allow for cursor beyond last character
set noswapfile                  " Disable swap to prevent ugly messages
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set history=1000                " Store a ton of history (default is 20)
" set spell                     " Spell checking on
set expandtab                   " Tabs are spaces, not tabs
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set smarttab
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>             " Match, to be used with %
"set matchpairs+==:;            " Match, to be used with %
"set matchpairs+=<:>            " Match, to be used with %
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set equalalways                 " keep windows equal when splitting (default)
set eadirection=hor             " ver/hor/both - where does equalalways apply

set pastetoggle=<F2>            " Pastetoggle (sane indentation on pastes)
set nopaste                     " Disable paste by default
set hidden                      " It hides buffers instead of closing them

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set formatoptions+=t    " auto-wrap using textwidth (not comments)
set formatoptions+=c    " auto-wrap comments too
set formatoptions+=r    " continue the comment header automatically on <CR>
set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
set formatoptions+=q    " allow formatting of comments with gq
" set formatoptions-=w   " double-carriage-return indicates paragraph
" set formatoptions-=a   " don't reformat automatically
set formatoptions+=n    " recognize numbered lists when autoindenting
set formatoptions+=2    " use second line of paragraph when autoindenting
set formatoptions-=v    " don't worry about vi compatiblity
set formatoptions-=b    " don't worry about vi compatiblity
set formatoptions+=l    " don't break long lines in insert mode
set formatoptions+=1    " don't break lines after one-letter words, if possible
set cindent             " stricter rules for C programs

set laststatus=2        " requied by PowerLine/Airline

set cursorline          " highlight current line
set backup              " backuping is good

set backupdir=~/trash
set directory=~/trash
set undofile            " So is persistent undo ...
set undolevels=1000     " Maximum number of changes that can be undone
set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
set cpoptions=aAceFsBd
" ---------------- Folds --------------------------------------
" set foldmethod=indent               "fold based on indent
" set foldenable                      "fold by default
" set foldnestmax=3                   "deepest fold is 3 levels
" set nofoldenable                    "dont fold by default

set fillchars=vert:│
set maxfuncdepth=1000
set maxmemtot=200000

set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set modeline          " enable modelines
set grepprg=ag\ --nogroup\ --nocolor  "use ag over grep
" set grepprg=grep\ -nH\ $*

set iminsert=0
set cmdheight=1

if has("cscope")
  set csprg=/usr/bin/gtags-cscope
  set csto=0
  set cscopetag
  " set csprg=/usr/bin/cscope
  " if filereadable("cscope.out")
  "   cs add cscope.out
  " endif
  " if filereadable("GTAGS")
  " cscope add  expand(:pwd)/GTAGS
  " endif
endif
if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

"rainbow parentheses - Подсвечивание парных скобок.
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

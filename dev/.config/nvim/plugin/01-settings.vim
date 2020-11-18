colorscheme neg
set report=0                                                    " no report on substitution
set fileformats=unix,dos,mac                                    " file format fallback
set synmaxcol=256                                               " no syntax hi for too long lines
set regexpengine=0                                              " autoselect regex engine
set conceallevel=2                                              " enable conceal
set concealcursor=niv                                           " conceal cursor
set keymap=russian-jcukenwin                                    " add ru keymap
set magic                                                       " use magic
set listchars=                                                  " disable listchars
set path+=.,..,**,/usr/include,./include,../include             " add path settings
if executable(resolve(expand('par')))
    set formatprg="par -140"                                    " use par as formatter
else
    set formatprg="fmt -140"                                    " use fmt as formatter
endif
if executable(resolve(expand('perltidy')))
    set equalprg="perltidy"
endif
set hidden                                                      " It hides buffers instead of closing them
set lazyredraw                                                  " Reduce useless redrawing
set backup                                                      " Backuping is good
set cindent                                                     " Smart indenting for c-like code
set cinoptions=b1,g0,N-s,t0,(0,W4                               " See :h cinoptions-values
set clipboard=unnamedplus                                       " Always clipboard all operations
set copyindent                                                  " Copy the previous indentation on autoindenting
set diffopt+=internal,algorithm:patience                        " Better diff algorithm
set eadirection=hor                                             " Ver/hor/both - where does equalalways apply
set expandtab                                                   " tabs are spaces, not tabs
set fileencodings=utf-8,default                                 " less file encodings
set gdefault                                                    " This makes search/replace global by default
set ignorecase                                                  " Case insensitive search
set iminsert=0                                                  " Write latin1 characters first
set imsearch=0                                                  " Search with latin1 characters first
set inccommand=nosplit                                          " Better live substitution
set isfname+={,}                                                " Scan in filenames in such brackets
set jumpoptions=stack                                           " Jumplist behave like tagstack
set linespace=0                                                 " No extra spaces between rows
set matchtime=0                                                 " Default time to hi brackets too long for me
set matchpairs+=<:>,《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:” " better matchpairs
set maxfuncdepth=100                                            " Maximum depth of function calls for user functions
set maxmapdepth=1000                                            " Maximum number of times a mapping is done without resulting in a character to be used.
set maxmempattern=1000                                          " Maximum amount of memory (in Kbyte) to use for pattern matching.
set noautochdir                                                 " Dont't change pwd automaticly because of problems with plugins
set autoread                                                    " Autoread file on change
set noautowrite                                                 " Don't autowrite by default
set nofoldenable                                                " Disable folds as
set nojoinspaces                                                " Prevents inserting two spaces after punctuation on a join (J)
set noshowmatch                                                 " Show matching brackets/parenthesis
set nospell                                                     " Disable spell checking by default
set number                                                      " Line numbers on
set pumblend=15                                                 " Set up pmenu transparency
set pumheight=12                                                " Do not make pmenu too wide
set scrolljump=1                                                " Lines to scroll when cursor leaves screen
set scrolloff=1                                                 " Minimum lines to keep above and below cursor
set scrollback=1                                                " Disable scrollback
set shiftround                                                  " Makes indenting a multiple of shiftwidth
set shiftwidth=4                                                " Spaces for autoindents
set shortmess+=a                                                " Abbrev. of messages (avoids 'hit enter')
set shortmess+=oOstTWAIcqFS                                     " Shorting messages for all
set showmode                                                    " No show the mode ("-- INSERT --") at the bottom
set showtabline=0                                               " Do not show tab line
set sidescrolloff=10                                            " Min num of scr columns to keep to the left and to the
set smartcase                                                   " Case sensitive when uc present
set softtabstop=4                                               " Let backspace delete indent
set splitbelow                                                  " Puts new split windows to the bottom of the current
set splitright                                                  " Puts new vsplit windows to the right of the current
set switchbuf=useopen,usetab                                    " 'useopen' may be useful for re-using QuickFix window.
set tabstop=4                                                   " An indentation every four columns
set timeoutlen=2000                                             " 2 seconds wait to sequence complete
set ttimeoutlen=20                                              " Very fast and also you shouldn't make combination too fast
set updatetime=250                                              " Faster diagnostics
set virtualedit=onemore,block                                   " Allow for cursor beyond last character
set whichwrap=b,s,h,l,<,>,[,]                                   " Backspace and cursor keys wrap too
set wildmode=full                                               " Command <Tab> completion, list matches, then longest common part, then all.
set wildoptions=pum                                             " Wild options
set winblend=15                                                 " Pseudo-transparency for floating windows
set winminheight=0                                              " Windows can be 0 line high
set winminwidth=0                                               " Windows can be 0 line width
set nowrap                                                      " Do not wrap lines by default
set mouse=a                                                     " Add mouse support
" formatoptions+=t                                              " Auto-wrap using textwidth (not comments)
" formatoptions+=c                                              " Auto-wrap comments too
" formatoptions+=r                                              " Continue the comment header automatically on <CR>
" formatoptions+=q                                              " Allow formatting of comments with gq
" formatoptions+=n                                              " Recognize numbered lists when autoindenting
" formatoptions+=l                                              " Don't break long lines in insert mode
" formatoptions+=1                                              " Don't break lines after one-letter words, if possible
" formatoptions-=o                                              " Don't insert comment leader with 'o' or 'O'
" formatoptions-=2                                              " Don't use second line of paragraph when autoindenting
" formatoptions-=v                                              " Don't worry about vi compatiblity
" formatoptions-=b                                              " Don't worry about vi compatiblity
" formatoptions-=j                                              " Delete comment character when joining
set formatoptions=n1jcroql                                      " -------------------------------------
" cpoptions+=$                                                  " No line redisplay -> put a '$' at the end
" cpoptions+=A                                                  " -- : write --
" cpoptions+=B                                                  " A backslash has no special meaning in mappings
" cpoptions+=F                                                  " :write set name for current buffer if no
" cpoptions+=W                                                  " Overwrite file when possible
" cpoptions+=c                                                  " Search -> end of any match at the cursor pos but not start of the next line
" cpoptions+=d                                                  " Make ./ in tags relative to tags file in current dir
" cpoptions+=e                                                  " :@r adds CR and nonlinewise
" cpoptions+=s                                                  " Set buf opts before it created
" cpoptions+=a                                                  " :read with a filename set the alternate filename for window
set cpoptions=_$ABFWcdesa                                       " ----------------------------------------
set backupdir=~/trash                                           " Set up backupdir
set directory=~/trash                                           " Directory for swap files
set undodir=~/trash/                                            " Set up undo dir
set undofile                                                    " So is persistent undo ...
set undolevels=1000                                             " Maximum number of changes that can be undone
set undoreload=10000                                            " Maximum number lines to save for undo on a buffer reload
set shada=!,'100,<50,s100,h,:100,%,/100                         " shada settings

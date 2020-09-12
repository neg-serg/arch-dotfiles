colorscheme neg

if bufname('%') ==? ''
    set bufhidden=wipe
endif

set report=0 "no report on substitution
set fileformats=unix,dos,mac "file format fallback
set synmaxcol=2500 "no syntax hi for too long lines
set conceallevel=2 concealcursor=niv
set keymap=russian-jcukenwin

" Options initiating with ?m?
" [global] |'magic'| Set 'magic' patterns ;)
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
set path+=**

set isfname+={
set isfname+=}

set timeout ttimeout
set timeoutlen=2000
set ttimeoutlen=30 " Very fast and also you shouldn't make combination too fast

"----------------------------------------------------------------------------
set noautowrite     " Don't autowrite by default
set noautochdir     " Dont't change pwd automaticly because of problems with plugins
set showmode        " no show the mode ("-- INSERT --") at the bottom
set showtabline=0   " do not show tab line

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
if executable(resolve(expand('par')))
    set formatprg="par -140"  " use par as formatter
else
    set formatprg="fmt -140"  " use fmt as formatter
endif
set fileencodings=utf-8,default,latin1,cp1251,koi8-r,cp866
"--------------------------------------------------------------------------
set switchbuf=useopen,usetab    " 'useopen' may be useful for re-using QuickFix window.
set clipboard=unnamedplus       " always clipboard all operations
set shada=
set jumpoptions=stack
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set noshowmatch                 " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
set winminwidth=0               " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildoptions=pum             " wild options
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set inccommand=split            " Better live substitution
set matchtime=2                 " Default time to hi brackets too long for me
set updatetime=250              " Faster diagnostics
set pumblend=15                 " Set up pmenu transparency
set pumheight=8                 " Do not make pmenu too wide

set winblend=15                 " Pseudo-transparency for floating windows

" allow backspace and cursor keys to cross line boundaries
set gdefault                    " this makes search/replace global by default

set wrap                        " Wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set sidescrolloff=10            " min num of scr columns to keep to the left and to the
                                " right of the cursor if 'nowrap' is set.
set virtualedit=onemore,block   " Allow for cursor beyond last character
set shortmess+=a                " Abbrev. of messages (avoids 'hit enter')
set shortmess+=oOstTWAIcqFS     " Shorting messages for all
set nofoldenable                " Disable folds as
set spell                       " Spell checking off
set shiftwidth=4                " spaces for autoindents
set shiftround                  " makes indenting a multiple of shiftwidth
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>,《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set eadirection=hor             " ver/hor/both - where does equalalways apply
set hidden                      " It hides buffers instead of closing them
set lazyredraw                  " Reduce useless redrawing
set diffopt+=internal,algorithm:patience " Better diff algorithm

set formatoptions+=t    " auto-wrap using textwidth (not comments)
set formatoptions+=c    " auto-wrap comments too
set formatoptions+=r    " continue the comment header automatically on <CR>
set formatoptions+=q    " allow formatting of comments with gq
set formatoptions+=n    " recognize numbered lists when autoindenting
set formatoptions+=l    " don't break long lines in insert mode
set formatoptions+=1    " don't break lines after one-letter words, if possible
set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
set formatoptions-=2    " don't use second line of paragraph when autoindenting
set formatoptions-=v    " don't worry about vi compatiblity
set formatoptions-=b    " don't worry about vi compatiblity
set formatoptions-=j    " delete comment character when joining

set cpoptions=a         " :read with a filename set the alternate filename for window
set cpoptions+=A        " -- : write --
set cpoptions+=c        " search -> end of any match at the cursor pos but not start of the next line
set cpoptions+=e        " :@r adds CR and nonlinewise
set cpoptions+=F        " :write set name for current buffer if no
set cpoptions+=s        " set buf opts before it created
set cpoptions+=B        " a backslash has no special meaning in mappings
set cpoptions+=d        " make ./ in tags relative to tags file in current dir
set cpoptions+=$        " no line redisplay -> put a '$' at the end

" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set nosmartindent       " disable smart auto indenting, I think it should be deprecated
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cinoptions=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set cinkeys-=0#         " better support for
set indentkeys-=0#      " tcomment
set nocursorline        " highlight current line is too slow
set backup              " backuping is good
" Protect home directory
if !empty($SUDO_USER) && $USER !=# $SUDO_USER
    set directory-=~/trash
    set backupdir-=~/trash
endif
set directory=~/trash
set backupdir=~/trash
"--[ change undo file location ]----------------------------------
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set undofile            " So is persistent undo ...
set undodir=~/trash/    " Set up undo dir
set undolevels=1000     " Maximum number of changes that can be undone
set undoreload=10000    " Maximum number lines to save for undo on a buffer reload

" set maxfuncdepth=100    " Maximum depth of function calls for user functions
" set maxmapdepth=1000    " Maximum number of times a mapping is done
"                         " without resulting in a character to be used.
" set maxmempattern=1000  " Maximum amount of memory (in Kbyte) to use for pattern matching.

set modeline            " disable modelines

set iminsert=0          " write latin1 characters first
set imsearch=0          " search with latin1 characters first
set cmdheight=1         " standard cmdline height

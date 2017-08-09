"  __     ___
"  \ \   / (_)_ __ ___
"   \ \ / /| | '_ ` _ \  
"    \ V / | | | | | | |
"     \_/  |_|_| |_| |_|  
"

scriptencoding utf-8
 if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif 

try
call neobundle#rc(expand('~/.vim/bundle/'))
if empty($https_proxy)
  let g:neobundle#types#git#default_protocol = 'git'
else
  let g:neobundle#types#git#default_protocol = 'https'
endif

NeoBundleFetch 'Shougo/neobundle.vim'         " Let NeoBundle manage NeoBundle
"------------------------------------------------------------------------------------------------------------
"--[ Bundles ]-----------------------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------------
NeoBundle 'sjbach/lusty.git'                  "file/buffer explorer
NeoBundle 'kien/ctrlp.vim'                    "for MRU
NeoBundle 'godlygeek/tabular'                 "tabularize!
NeoBundle 'mileszs/ack.vim'                   "ack wrapper
if executable("ag")
    NeoBundle 'rking/ag.vim.git'              "ag (ack replacement) wrapper
endif
NeoBundleLazy 'sjl/gundo.vim', { 'autoload' : {'commands': 'GundoToggle'}}
NeoBundle 'tpope/vim-eunuch.git'              "for SudoWrite, Locate, Find etc
NeoBundle 'tomtom/tcomment_vim.git'           "easier comments
NeoBundle 'bling/vim-airline.git'             "fancy statusline
NeoBundle 'altercation/vim-colors-solarized'  "fancy solarized colorscheme
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make -f make_mac.mak',
      \     'unix'    : 'make -f make_unix.mak',
      \    },
      \ }
"------------------------------------------------------------------------------------------------------------
"--[ misc ]--------------------------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------------
NeoBundle 'majutsushi/tagbar'                 "tagbar
NeoBundle 'tpope/vim-abolish.git'             "advanced abbreviation & substitution
NeoBundle 'drmikehenry/vim-fontsize.git'      "set fontsize on the fly
NeoBundle 'nathanaelkane/vim-indent-guides'   "indent tabs visualy
NeoBundle 'vim-scripts/CCTree.git'            "show codeflow by cscope ctags and ccglue
NeoBundle 'tpope/vim-markdown'                "markdown helper for vim
NeoBundle 'vim-scripts/auctex.vim.git'        "auctex.vim for the syntax highlighting.
NeoBundle 'vim-scripts/bufkill.vim.git'       "bufkill with BD

NeoBundle 'vim-scripts/Conque-GDB.git'        "Conque GDB is powerful gdb wrapper for vim
"------------------------------------------------------------------------------------------------------------
"--[ experimental ]------------------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------------
NeoBundle 'Shougo/vinarise.vim.git'           "Hex editor for vim
NeoBundle 'joedicastro/DirDiff.vim.git'       "Recursive diff on two directories and generate a diff 'window'
NeoBundle 'vim-scripts/utl.vim.git'           "Open urls in files
NeoBundle 'jimsei/winresizer.git'             "Resize window simply
NeoBundleLazy 'vim-scripts/zoomwintab.vim', {'autoload' :
            \{'commands' : 'ZoomWinTabToggle'}}
NeoBundle 'tyru/restart.vim.git'              "add restart support
NeoBundle 'chrisbra/Join.git'                 "Extended Join for vim
NeoBundle 'oplatek/Conque-Shell.git'          "Possibly it's shell for gvim
NeoBundle 'sjl/clam.vim.git'                  "Allow run commands in split
NeoBundle 'tpope/vim-obsession.git'           "Session manager
NeoBundle 'AndrewRadev/multichange.vim.git'   "Test
NeoBundle 'lyokha/vim-xkbswitch.git'
"------------------------------------------------------------------------------------------------------------
"---------------[  markdown ]--------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------------
NeoBundle 'vim-jp/vital.vim.git'              "improve unity perf
NeoBundle 'Shougo/unite.vim.git'              "Unite for autocomp
NeoBundleLazy 'Shougo/junkfile.vim', {
            \'autoload':{'commands':'JunkfileOpen',
            \ 'unite_sources':['junkfile','junkfile/new']}} "Create temporary file for memo, testing, ... 
NeoBundleLazy 'Shougo/unite-build.git', {'autoload' : {
    \ 'unite_sources' : 'build',
    \ }}
NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
NeoBundleLazy 'kmnk/vim-unite-svn.git', {'autoload' : {
    \ 'unite_sources' : ['svn/status', 'svn/info', 'svn/blame', 'svn/diff'],
    \ }}
NeoBundleLazy 'tsukkee/unite-help', {'autoload':{'unite_sources':'help'}}
NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':
            \ 'colorscheme'}}
NeoBundleLazy 'ujihisa/unite-locate', {'autoload':{'unite_sources':'locate'}}
NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : { 'unite_sources' :
            \ ['history/command', 'history/search']}}
NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {'unite_sources' :
            \ 'filetype', }}
NeoBundleLazy 'osyo-manga/unite-quickfix', {'autoload':{'unite_sources':
            \ ['quickfix', 'location_list']}}
NeoBundleLazy 'osyo-manga/unite-fold', {'autoload':{'unite_sources':'fold'}}
NeoBundleLazy 'tacroe/unite-mark', {'autoload':{'unite_sources':'mark'}}
NeoBundleLazy 'hewes/unite-gtags.git', {'autoload':{'unite_sources':['gtags', 'gtags/def', 'gtags/context', 'gtags/ref', 'gtags/grep', 'gtags/def' ]}} 
NeoBundleLazy 'mattn/unite-gist.git' , {'autoload':{'unite_sources':'gist'}}             

NeoBundleCheck
catch /117/
    echo "load NeoBundle failed"
endtry
syntax on
filetype plugin indent on

source ~/.vim/00-functions.vim
source ~/.vim/01-settings.vim
source ~/.vim/02-unite.vim
source ~/.vim/04-autocmds.vim
source ~/.vim/10-keymaps.vim
source ~/.vim/11-emacs-keys.vim
source ~/.vim/21-langmap.vim
" source ~/.vim/etc/lightline.vim

" source ~/.vim/.trash/99-test.vim
" ~/.vim/.trash/99-trash.vim


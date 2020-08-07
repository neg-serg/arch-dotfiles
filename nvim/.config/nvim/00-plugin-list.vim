call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
"--[ Main ]--------------------------------------------------------------------------
Plug 'neg-serg/neg' " separated repo for the my own main colorscheme
Plug 'neg-serg/neovim-colorschemes' " all colorschemes in the single repo
Plug 'norcalli/nvim-colorizer.lua' "high-performance color highlighter for Neovim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " autocomplete
Plug 'easymotion/vim-easymotion' " easymotion
Plug 'honza/vim-snippets' " vim-snippets
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " undo tree
Plug 'sjbach/lusty', {'on': ['LustyFilesystemExplorer', 'LustyFilesystemExplorerFromHere']} " file/buffer explorer
Plug 'FooSoft/vim-argwrap' " vim arg wrapper
Plug 'kopischke/vim-fetch' " vim path/to/file.ext:12:3
Plug 'justinmk/vim-dirvish' "minimalistic file manager
Plug 'airblade/vim-rooter' " autochdir for project root or for current dir
" --[ Edit ]-------------------------------------------------------------------------
Plug 'tpope/vim-surround' " new commands to vim for generic brackets
Plug 'AndrewRadev/dsf.vim' " surround for function calls
Plug 'AndrewRadev/splitjoin.vim' "one-liner to multi-liner
Plug 'wellle/targets.vim' " better text objects
Plug 'junegunn/vim-easy-align' " use easy-align, instead of tabular
Plug 'jiangmiao/auto-pairs' " autopair for brackets
Plug 'sbdchd/neoformat' " universal formatter
Plug 'tpope/vim-repeat' " dot for everything
Plug 'inkarkat/vim-ReplaceWithRegister' " replace with register keybindings
Plug 'tpope/vim-abolish' " for different case coersion
Plug 'haya14busa/vim-asterisk' " smartcase star
Plug 'lambdalisue/suda.vim' " smart sudo support
"--[ Search ]------------------------------------------------------------------------
Plug 'junegunn/fzf', {'dir': '~/.config/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim' "  fzf vim bindings
Plug 'pbogut/fzf-mru.vim' " fzf mru source
Plug 'mhinz/vim-grepper', {'on': ['Grepper', '<plug>(GrepperOperator)']} "better grep plugin
" --[ Dev ]--------------------------------------------------------------------------
Plug 'dense-analysis/ale' " async linter with lsp support
Plug 'tomtom/tcomment_vim' " commenter plugin
Plug 'liuchengxu/vista.vim' " lsp-symbols tag searcher
Plug 'Shougo/neoinclude.vim' " include completion framework
Plug 'puremourning/vimspector' " vim debugging support
Plug 'tpope/vim-dispatch', {'on': ['Dispatch', 'Start', 'Make']} " provide async build
Plug 'radenling/vim-dispatch-neovim', {'on': ['Dispatch', 'Start']} " Neovim support for vim-dispatch
Plug 'derekwyatt/vim-fswitch' " switching between companion source files e.g. .h and .cpp
Plug 'plasticboy/vim-markdown' " markdown vim mode
Plug 'mattn/emmet-vim', {'on': 'EmmetInstall'} " expanding abbreviations similar to emmet
Plug 'vimwiki/vimwiki' " personal wiki for vim
Plug 'donRaphaco/neotex' , {'for': 'tex'} " latex support
Plug 'thinca/vim-ref' " integrated reference viewer for help with separated window
Plug 'vim-scripts/IndentConsistencyCop', {'for': 'python'} " autochecks for indent
" --[ Appearance ]-------------------------------------------------------------------
Plug 'sheerun/vim-polyglot' "  language pack collection
Plug 'nvim-treesitter/nvim-treesitter' " better syntax highlight
Plug 'chr4/nginx.vim', { 'for': 'nginx' } " Nginx config file syntax
Plug 'norcalli/nvim-colorizer.lua' " fast js/css colorizer
Plug 'luochen1990/rainbow' " better rainbow parentheses
Plug 'arzg/vim-sh' " better sh / zsh highlight
" --[ DCVS ]-------------------------------------------------------------------------
Plug 'tpope/vim-fugitive' " Git stuff. Needed for powerline etc
Plug 'junegunn/gv.vim' " git commit browser
Plug 'airblade/vim-gitgutter' " show last git changes
Plug 'rhysd/git-messenger.vim' " shows git message
Plug 'rhysd/committia.vim' " better commit message
Plug 'jreybert/vimagit' " interactive work with git
"--[ Session ]-----------------------------------------------------------------------
Plug 'xolox/vim-misc' " for vim-session
Plug 'xolox/vim-session' " rule sessions
" --[ Misc ]-------------------------------------------------------------------------
Plug 'jamessan/vim-gnupg' " Transparent work with gpg-encrypted files
Plug 'vim-scripts/ViewOutput' " VO commandline output
Plug 'dstein64/vim-startuptime' " measuring startuptime
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " delete whitespaces with ease
call plug#end()

set noexrc
set secure
set shell=/bin/dash
set termguicolors
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
"--[ Main ]--------------------------------------------------------------------------
Plug 'neg-serg/neg' " separated repo for the my own main colorscheme
Plug 'neg-serg/neovim-colorschemes' " all colorschemes in the single repo
Plug 'neg-serg/neovim-autoload-session' " session autosave
Plug 'norcalli/nvim-colorizer.lua' " high-performance color highlighter for Neovim
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
Plug 'tpope/vim-abolish' " for different case coersion
Plug 'haya14busa/vim-asterisk' " smartcase star
Plug 'tpope/vim-repeat' " dot for everything
Plug 'inkarkat/vim-ReplaceWithRegister' " replace with register keybindings
Plug 'lambdalisue/suda.vim' " smart sudo support
Plug 'tomtom/tcomment_vim' " commenter plugin
"--[ Search ]------------------------------------------------------------------------
Plug 'junegunn/fzf', {'dir': '~/.config/fzf', 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim' "  fzf vim bindings
Plug 'pbogut/fzf-mru.vim' " fzf mru source
Plug 'mhinz/vim-grepper', {'on': ['Grepper', '<plug>(GrepperOperator)']} "better grep plugin
" --[ Dev ]--------------------------------------------------------------------------
Plug 'dense-analysis/ale' " async linter with lsp support
Plug 'liuchengxu/vista.vim' " lsp-symbols tag searcher
Plug 'puremourning/vimspector' " vim debugging support
Plug 'tpope/vim-dispatch', {'on': ['Dispatch', 'Start', 'Make']} " provide async build
Plug 'radenling/vim-dispatch-neovim', {'on': ['Dispatch', 'Start']} " Neovim support for vim-dispatch
Plug 'plasticboy/vim-markdown' " markdown vim mode
Plug 'thinca/vim-ref' " integrated reference viewer for help with separated window
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
Plug 'rhysd/git-messenger.vim' " shows git message
Plug 'rhysd/committia.vim' " better commit message
Plug 'jreybert/vimagit' " interactive work with git
" --[ Misc ]-------------------------------------------------------------------------
Plug 'jamessan/vim-gnupg' " Transparent work with gpg-encrypted files
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " delete whitespaces with ease
Plug 'vimwiki/vimwiki' " personal wiki for vim
call plug#end()

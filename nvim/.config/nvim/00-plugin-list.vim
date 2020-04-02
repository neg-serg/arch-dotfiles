"--[ Main ]--------------------------------------------------------------------------
Plug 'neg-serg/neg' " separated repo for the my own main colorscheme
Plug 'neg-serg/neovim-colorschemes' " all colorschemes in the single repo
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " autocomplete
Plug 'easymotion/vim-easymotion' " easymotion
" --[ Edit ]-------------------------------------------------------------------------
Plug 'inkarkat/vim-ReplaceWithRegister' " replace with register keybindings
Plug 'junegunn/vim-easy-align' " use easy-align, instead of tabular
Plug 'jiangmiao/auto-pairs' " autopair for brackets
Plug 'sbdchd/neoformat' " universal formatter
Plug 'tpope/vim-repeat' " dot for everything
Plug 'tpope/vim-surround' " new commands to vim for generic brackets
Plug 'wellle/targets.vim' " better text objects
Plug 'justinmk/vim-dirvish' "minimalistic file manager
"--[ Additions ]---------------------------------------------------------------------
Plug 'FooSoft/vim-argwrap' " vim arg wrapper
Plug 'kopischke/vim-fetch' " vim path/to/file.ext:12:3
Plug 'Valloric/ListToggle' " toggle quickfix and location list
" --[ Rice ]-------------------------------------------------------------------------
Plug 'luochen1990/rainbow' " better rainbow parentheses
Plug 'tpope/vim-abolish' " for different case coersion
Plug 'tpope/vim-eunuch' " for SudoWrite, Locate, Find etc
"--[ Search ]------------------------------------------------------------------------
Plug 'junegunn/fzf' " fzf itself
Plug 'junegunn/fzf.vim' "  fzf vim bindings
Plug 'pbogut/fzf-mru.vim' " fzf mru source
Plug 'dyng/ctrlsf.vim' " interactive vim-grep
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'mhinz/vim-grepper' "better grep plugin
" --[ Dev ]--------------------------------------------------------------------------
Plug 'airblade/vim-rooter' " autochdir for project root or for current dir
Plug 'derekwyatt/vim-fswitch' " switching between companion source files e.g. .h and .cpp
Plug 'rhysd/git-messenger.vim' " shows git message
Plug 'tomtom/tcomment_vim' " commenter plugin
Plug 'tpope/vim-dispatch' " provide async build via tmux
Plug 'dense-analysis/ale' " ale as linter
Plug 'norcalli/nvim-colorizer.lua' " fast js/css colorizer
Plug 'liuchengxu/vista.vim' " lsp-symbols tag searcher
Plug 'sheerun/vim-polyglot' "  language pack collection
Plug 'tpope/vim-markdown' " markdown vim mode
Plug 'donRaphaco/neotex' " latex support
Plug 'thinca/vim-ref' " integrated reference viewer man/perldoc etc
" --[ DCVS ]-------------------------------------------------------------------------
Plug 'tpope/vim-fugitive' " Git stuff. Needed for powerline etc
Plug 'junegunn/gv.vim' " git commit browser
Plug 'airblade/vim-gitgutter' " show last git changes
Plug 'APZelos/blamer.nvim' " inline gitblame
"--[ Session ]-----------------------------------------------------------------------
Plug 'xolox/vim-misc' " for vim-session
Plug 'xolox/vim-session' " rule sessions
" --[ Misc ]-------------------------------------------------------------------------
Plug 'jamessan/vim-gnupg' " Transparent work with gpg-encrypted files
Plug 's3rvac/AutoFenc' "  try to autodelect filetype
Plug 'vim-scripts/ViewOutput' " VO commandline output
Plug 'dstein64/vim-startuptime' " measuring startuptime
Plug 'segeljakt/vim-silicon' " images of source code
" ----------------------------------------------------------------------[ Lazy plugins ]---
Plug 'Shougo/neoinclude.vim' " include completion framework for neocomplete/deoplete
Plug 'sjbach/lusty', {'on': ['LustyFilesystemExplorer', 'LustyFilesystemExplorerFromHere']} " file/buffer explorer
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " undo tree
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " delete whitespaces with ease
Plug 'mattn/emmet-vim', {'on': 'EmmetInstall'} " expanding abbreviations similar to emmet
Plug 'vim-scripts/IndentConsistencyCop', {'for': 'python'} " autochecks for indent
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'} " sxhkd config syntax

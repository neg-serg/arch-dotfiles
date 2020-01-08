"--[ Main ]--------------------------------------------------------------------------
Plug 'pbogut/fzf-mru.vim' " fzf mru source
Plug 'thinca/vim-quickrun' " run a bunch of text
Plug 'neg-serg/neovim-colorschemes' "all colorschemes in the single repo
"--[ Statusline ]--------------------------------------------------------------------
Plug 'itchyny/lightline.vim' " lightline statusline
Plug 'maximbaz/lightline-ale' " lightline ale mod
"--[ Autocompletion ]----------------------------------------------------------------
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " autocomplete
Plug 'jsfaint/coc-neoinclude' " neoinclude support
Plug 'neoclide/coc-lists' " use it for files support
Plug 'neoclide/coc-neco' " vimL completion engine via neco-vim
Plug 'neoclide/coc-sources' " use it for coc-ultisnips
Plug 'Shougo/neco-vim' " modern vim autocomplete
" --[ Edit ]-------------------------------------------------------------------------
Plug 'inkarkat/vim-ReplaceWithRegister' " replace with register keybindings
Plug 'junegunn/vim-easy-align' " use easy-align, instead of tabular
Plug 'machakann/vim-swap' " swap with emacs
Plug 'jiangmiao/auto-pairs' " autopair for brackets
Plug 'sbdchd/neoformat' " universal formatter
Plug 'SirVer/ultisnips' " Snippets with ycm compatibility
Plug 'tpope/vim-repeat' " dot for everything
Plug 'tpope/vim-surround' " new commands to vim for generic brackets
Plug 'wellle/targets.vim' " better text objects
Plug 'justinmk/vim-dirvish' "minimalistic file manager
"--[ Additions ]---------------------------------------------------------------------
Plug 'FooSoft/vim-argwrap' " vim arg wrapper
Plug 'kopischke/vim-fetch' " vim path/to/file.ext:12:3
Plug 'lyokha/vim-xkbswitch' " Autoswitch on <esc> with libxkb needs xkb-switch-git to run
Plug 'Valloric/ListToggle' " toggle quickfix and location list
"--[ QuickFix stuff ]----------------------------------------------------------------
Plug 'romainl/vim-qf' " better quickfix support
Plug 'thinca/vim-qfreplace' " visual replace for multiple files
Plug 'stefandtw/quickfix-reflector.vim' " qf editing
" --[ Rice ]-------------------------------------------------------------------------
Plug 'frazrepo/vim-rainbow' " better rainbow parentheses
Plug 'tpope/vim-abolish' " for different case coersion
Plug 'tpope/vim-eunuch' " for SudoWrite, Locate, Find etc
"--[ Search ]------------------------------------------------------------------------
Plug 'dyng/ctrlsf.vim' " interactive vim-grep
Plug 'junegunn/fzf' " fzf itself
Plug 'junegunn/fzf.vim' "  fzf vim bindings
Plug 'mhinz/vim-grepper' "better grep plugin
" --[ Docs ]-------------------------------------------------------------------------
Plug 'thinca/vim-ref' " integrated reference viewer man/perldoc etc
" --[ Dev ]--------------------------------------------------------------------------
Plug 'dbakker/vim-projectroot' " autochdir for project
Plug 'derekwyatt/vim-fswitch' " switching between companion source files e.g. .h and .cpp
Plug 'janko-m/vim-test' " easy testing for various langs
Plug 'rhysd/git-messenger.vim' " shows git message
Plug 'Shougo/echodoc.vim' " print documents in echo area
Plug 'tomtom/tcomment_vim' " commenter plugin
Plug 'tpope/vim-dispatch' " provide async build via tmux
Plug 'Vimjas/vim-python-pep8-indent' " python autoindent pep8 compatible
Plug 'dense-analysis/ale' " ale as linter
Plug 'norcalli/nvim-colorizer.lua' " fast colorizer
" --[ LaTeX ]------------------------------------------------------------------------
Plug 'donRaphaco/neotex' " latex support
" ----------------[  Tags  ]---------------------------------------------------------
Plug 'bbchung/gasynctags' " autogenerate gtags to cscope db
Plug 'neg-serg/gtags-cscope-vim' "  my gtags-cscope fork
Plug 'yuki777/gtags.vim' " Gtags v0.64
" ---------------[ Misc syntax ]-----------------------------------------------------
Plug 'mzlogin/vim-markdown-toc' " plugin to autogenerate table of contents for markdown
Plug 'sheerun/vim-polyglot' "  language pack collection
Plug 'tpope/vim-markdown' " markdown vim mode
" --[ DCVS ]-------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter' " show last git changes
Plug 'gregsexton/gitv' " gitk for vim
Plug 'tpope/vim-fugitive' " Git stuff. Needed for powerline etc
" --[ tmux ]-------------------------------------------------------------------------
Plug 'christoomey/vim-tmux-navigator' " easy jump between windows
"--[ Session ]-----------------------------------------------------------------------
Plug 'xolox/vim-misc' " for vim-session
Plug 'xolox/vim-session' " rule sessions
" --[ Misc ]-------------------------------------------------------------------------
Plug 'jamessan/vim-gnupg' " Transparent work with gpg-encrypted files
Plug 'Konfekt/FastFold' " Do not update folds when it's not needed
Plug 'mopp/autodirmake.vim' " automake dir which didnt exists
Plug 's3rvac/AutoFenc' "  try to autodelect filetype
Plug 'vim-scripts/ViewOutput' " VO commandline output
" ----------------------------------------------------------------------[ Lazy plugins ]---
" --[ Main ]-------------------------------------------------------------------------------
Plug 'Shougo/neoinclude.vim' " include completion framework for neocomplete/deoplete
Plug 'sjbach/lusty', {'on': ['LustyFilesystemExplorer', 'LustyFilesystemExplorerFromHere']} " file/buffer explorer
" --[ Edit ]-------------------------------------------------------------------------------
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " undo tree
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " delete whitespaces with ease
" --[ Web ]-------------------------------------------------------------------------------
Plug 'mattn/emmet-vim', {'on': 'EmmetInstall'} " expanding abbreviations similar to emmet
" --[ Markdown ]--------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'} " markdown preview
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'} " mathjax support for markdown preview
" --[ Python ]-----------------------------------------------------------------------------
Plug 'vim-scripts/IndentConsistencyCop', {'for': 'python'} " autochecks for indent
" --[ Misc syntax ]-----------------------------------------------------------------------
Plug 'blindFS/vim-regionsyntax', {'for': ['vimwiki', 'markdown', 'tex', 'html']} " region syntax highlighting
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'} " sxhkd config syntax

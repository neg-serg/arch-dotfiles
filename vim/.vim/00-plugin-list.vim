"--[ Main ]--------------------------------------------------------------------------
Plug 'thinca/vim-quickrun' " run a bunch of text
Plug 'Shougo/neomru.vim' " add neomru source
Plug 'itchyny/lightline.vim' " lightline statusline
Plug 'maximbaz/lightline-ale' " lightline ale mod
Plug 'justinmk/vim-dirvish' " netrw replacement
Plug 'bounceme/remote-viewer' " dirvish remote-viewer
Plug 'kristijanhusak/vim-dirvish-git' " git support for divish
Plug 'Shougo/defx.nvim' " better file-manager for nvim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "autocomplete
Plug 'neoclide/coc-lists' "use it for files support
Plug 'neoclide/coc-neco' "vimL completion engine via neco-vim
Plug 'jsfaint/coc-neoinclude' "neoinclude support
Plug 'neoclide/coc-sources' "use it for coc-ultisnips
Plug 'voldikss/coc-github' "github issues support
" --[ Edit ]-------------------------------------------------------------------------------
Plug 'sbdchd/neoformat' " universal formatter
Plug 'SirVer/ultisnips' " Snippets with ycm compatibility
Plug 'tpope/vim-unimpaired' " good mappings and toggles
Plug 'tpope/vim-repeat' " dot for everything
Plug 'Raimondi/delimitMate' " autopair for brackets
Plug 'tpope/vim-surround' "new commands to vim for generic brackets
Plug 'machakann/vim-sandwich' "Surround-like operators
Plug 'stefandtw/quickfix-reflector.vim' "qf editing
Plug 'junegunn/vim-easy-align' " use easy-align, instead of tabular
Plug 'machakann/vim-swap' " swap with emacs
Plug 'google/vim-searchindex' "search indexing
Plug 'rhysd/clever-f.vim' "more clever-f
"--[ Additions ]--------------------------------------------------------------------------
Plug 'romainl/vim-qf' "better quickfix support
Plug 'thinca/vim-qfreplace' " visual replace for multiple files
Plug 'kopischke/vim-fetch' " vim path/to/file.ext:12:3
Plug 'FooSoft/vim-argwrap' " vim arg wrapper
Plug 'Valloric/ListToggle' " toggle quickfix and location list <leader>l by def
Plug 'lyokha/vim-xkbswitch' " Autoswitch on <esc> with libxkb needs xkb-switch-git to run
" --[ Rice ]-------------------------------------------------------------------------------
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'tpope/vim-eunuch' " for SudoWrite, Locate, Find etc
Plug 'tpope/vim-abolish' " for different case coersion
"--[ Search ]-----------------------------------------------------------------------------
Plug 'junegunn/fzf' " fzf itself
Plug 'junegunn/fzf.vim' "  fzf vim bindings
Plug 'sjbach/lusty' " file/buffer explorer
Plug 'dyng/ctrlsf.vim' " interactive vim-grep
Plug 'mhinz/vim-grepper' "better grep plugin
" --[ Docs ]------------------------------------------------------------------------------
Plug 'thinca/vim-ref' " integrated reference viewer man/perldoc etc
" --[ Dev ]-------------------------------------------------------------------------------
Plug 'chrisbra/vim-diff-enhanced' " patience diff
Plug 'tpope/vim-dispatch' " provide async build via tmux
Plug 'w0rp/ale' " ale as linter
Plug 'tomtom/tcomment_vim' " commenter plugin
Plug 'dbakker/vim-projectroot' " better rooter
Plug 'derekwyatt/vim-fswitch' " switching between companion source files e.g. .h and .cpp
Plug 'Shougo/neco-vim' " modern vim autocomplete
Plug 'Vimjas/vim-python-pep8-indent' " python autoindent pep8 compatible
Plug 'Shougo/echodoc.vim' " print documents in echo area
Plug 'apalmer1377/factorus' " refactoring tool
Plug 'rhysd/git-messenger.vim' " shows git message
Plug 'janko-m/vim-test' " easy testing for various langs
" --[ LaTeX ]-----------------------------------------------------------------------------
Plug 'donRaphaco/neotex'
" ----------------[  Tags  ]--------------------------------------------------------------
Plug 'yuki777/gtags.vim' " Gtags v0.64
Plug 'bbchung/gasynctags' " autogenerate gtags to cscope db
Plug 'neg-serg/gtags-cscope-vim' "  my gtags-cscope fork
" ---------------[ Misc syntax ]----------------------------------------------------------
Plug 'tpope/vim-markdown' " markdown vim mode
Plug 'mzlogin/vim-markdown-toc' " plugin to autogenerate table of contents for markdown
Plug 'sheerun/vim-polyglot' "  language pack collection
Plug 'whatyouhide/vim-gotham' " gotham colorscheme for nvim
Plug 'joshdick/onedark.vim' " onedark colorscheme
Plug 'KeitaNakamura/neodark.vim' " neodark colorscheme
Plug 'NLKNguyen/papercolor-theme' " great bright colorscheme
Plug 'icymind/NeoSolarized' " solarized with better neovim support
Plug 'arcticicestudio/nord-vim' " dark and cold colorscheme
Plug 'chriskempson/base16-vim' " base16 colorschemes pack
Plug 'tyrannicaltoucan/vim-deep-space' " deepspace colorscheme
Plug 'bluz71/vim-moonfly-colors' " moonfly colorscheme
Plug 'ryanoasis/vim-devicons' " fancy icons for fonts
Plug 'chr4/nginx.vim' "nginx syntax highlighting
" --[ dcvs ]------------------------------------------------------------------------------
Plug 'tpope/vim-fugitive' " Git stuff. Needed for powerline etc
Plug 'airblade/vim-gitgutter' " show last git changes
Plug 'gregsexton/gitv' " gitk for vim
" --[ Tmux ]----------------------------------------------------------------------------
Plug 'christoomey/vim-tmux-navigator' " easy jump between windows
"--[ Session ]--------------------------------------------------------------------------
Plug 'xolox/vim-misc' " for vim-session
Plug 'xolox/vim-session' " rule sessions
" --[ Misc ]----------------------------------------------------------------------------
Plug 'powerman/vim-plugin-ruscmd' " prevent too much ru-en layout switching with c-s
Plug 's3rvac/AutoFenc' "  try to autodelect filetype
Plug 'wellle/targets.vim' " better text objects
Plug 'Konfekt/FastFold' " Do not update folds when it's not needed
Plug 'vim-scripts/ViewOutput' " VO commandline output
Plug 'jamessan/vim-gnupg' " Transparent work with gpg-encrypted files
Plug 'Shougo/deol.nvim' " better neovim terminal-based mode
Plug 'itchyny/vim-parenmatch' "  An efficient alternative to the standard matchparen plugin
Plug 'mopp/autodirmake.vim' " automake dir which didnt exists
Plug 'xarthurx/taskwarrior.vim' "taskwarrior support

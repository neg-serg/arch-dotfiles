" --[ Main ]-------------------------------------------------------------------------------
Plug 'Shougo/neoinclude.vim' " include completion framework for neocomplete/deoplete
" --[ Edit ]-------------------------------------------------------------------------------
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " undo tree
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " find whitespaces with ease
" --[ Web ]-------------------------------------------------------------------------------
Plug 'mattn/emmet-vim', {'on': 'EmmetInstall'} " expanding abbreviations similar to emmet
" --[ Markdown ]--------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'} " markdown preview
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'} " mathjax support for markdown preview
" --[ JS ]---------------------------------------------------------------------------------
Plug 'maksimr/vim-jsbeautify', {'for': 'javascript'} " neoformat formatter ;)
" --[ Python ]-----------------------------------------------------------------------------
Plug 'vim-scripts/IndentConsistencyCop', {'for': 'python'} " autochecks for indent
" --[ Rust ]-------------------------------------------------------------------------------
Plug 'rust-lang/rust.vim', {'for': 'rust'} " detection of rust files
" --[ Haskell ]-----------------------------------------------------------------------------
Plug 'bitc/vim-hdevtools', {'for': 'haskell'} " type-related features
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'} " syntax highlight and indentation
" --[ Ruby ]--------------------------------------------------------------------------------
Plug 'osyo-manga/vim-monster', {'for': 'ruby'} " alternative ruby autocompletion
Plug 'tpope/vim-rails', {'for': 'ruby'} " rails plugin from Tim Pope
Plug 'tpope/vim-rake', {'for': 'ruby'} " ruby rake support
Plug 'tpope/vim-rbenv', {'for': 'ruby'} " ruby rbenv support
" --[ Perl ]--------------------------------------------------------------------------------
Plug 'vim-perl/vim-perl', {'for': 'perl'} " perl support
Plug 'c9s/perlomni.vim', {'for': 'perl'} " perl omnicomplete
" --[ Go ]-----------------------------------------------------------------------------------
Plug 'jstemmer/gotags', {'for': 'go'} " tags for go
" --[ Misc Langs ]--------------------------------------------------------------------------
Plug 'joonty/vdebug', {'on': 'VdebugStart'} " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.
Plug 'oscarh/vimerl', {'for': 'erlang'} " vim erlang support
Plug 'rhysd/vim-crystal', {'for': 'crystal'} " crystal language support
Plug 'jalvesaq/Nvim-R', {'for': 'R'} " nvim R support
Plug 'nosami/Omnisharp', {'for': 'csharp'} " omnisharp completion
" --[ Misc syntax ]-----------------------------------------------------------------------
Plug 'blindFS/vim-regionsyntax', {'for': ['vimwiki', 'markdown', 'tex', 'html']} " region syntax highlighting
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'} " sxhkd config syntax

" --[ Main ]-------------------------------------------------------------------------------
Plug 'Shougo/neoinclude.vim' " include completion framework for neocomplete/deoplete
" --[ Edit ]-------------------------------------------------------------------------------
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'} " undo tree
Plug 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'} " delete whitespaces with ease
" --[ Web ]-------------------------------------------------------------------------------
Plug 'mattn/emmet-vim', {'on': 'EmmetInstall'} " expanding abbreviations similar to emmet
" --[ Markdown ]--------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'} " markdown preview
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'} " mathjax support for markdown preview
" --[ JS ]---------------------------------------------------------------------------------
Plug 'maksimr/vim-jsbeautify', {'for': 'javascript'} " neoformat formatter ;)
" --[ Python ]-----------------------------------------------------------------------------
Plug 'vim-scripts/IndentConsistencyCop', {'for': 'python'} " autochecks for indent
" --[ Ruby ]--------------------------------------------------------------------------------
Plug 'osyo-manga/vim-monster', {'for': 'ruby'} " alternative ruby autocompletion
Plug 'tpope/vim-rails', {'for': 'ruby'} " rails plugin from Tim Pope
Plug 'tpope/vim-rake', {'for': 'ruby'} " ruby rake support
Plug 'tpope/vim-rbenv', {'for': 'ruby'} " ruby rbenv support
" --[ Misc Langs ]--------------------------------------------------------------------------
Plug 'joonty/vdebug', {'on': 'VdebugStart'} " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.
" --[ Misc syntax ]-----------------------------------------------------------------------
Plug 'blindFS/vim-regionsyntax', {'for': ['vimwiki', 'markdown', 'tex', 'html']} " region syntax highlighting
Plug 'baskerville/vim-sxhkdrc', {'for': 'sxhkdrc'} " sxhkd config syntax

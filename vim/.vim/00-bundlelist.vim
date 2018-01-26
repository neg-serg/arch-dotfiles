let s:nvim_deoplete           = 1
let s:nvim_completion_manager = 0

"--[ Main ]------------------------------------------------------------------------------
if dein#load_state(expand('~/.vim/repos'))
    call dein#begin(expand('~/.vim'))
    call dein#load_toml('~/.vim/dein.toml', {'lazy' : 0})
    if s:nvim_deoplete
        "dark-powered completion engine
        call dein#add('Shougo/deoplete.nvim', {
          \ 'on_event' : 'InsertEnter',
          \ 'loadconf' : 1,
          \ })
        "include completion framework for neocomplete/deoplete
        call dein#add('Shougo/neoinclude.vim', { 'on_event' : 'InsertEnter'})
        "better completions with deoplete
        call dein#add('Shougo/echodoc.vim')
    elseif s:nvim_completion_manager
        call dein#add('roxma/nvim-completion-manager')
    endif
    "--[ Additions ]--------------------------------------------------------------------------
    "vim path/to/file.ext:12:3
    call dein#add('kopischke/vim-fetch')
    "vim arg wrapper
    call dein#add('FooSoft/vim-argwrap')
    "toggle quickfix and location list <leader>l by def
    call dein#add('Valloric/ListToggle.git')
    "better alternate files switcher and more
    call dein#add('tpope/vim-projectionist', { 'on_cmd' : ['A', 'AS', 'AV',
        \ 'AT', 'AD', 'Cd', 'Lcd', 'ProjectDo']})
    "Autoswitch on <esc> with libxkb needs xkb-switch-git to run
    call dein#add('lyokha/vim-xkbswitch.git')
    "powerful vim spell-checking with LangTool
    call dein#add('rhysd/vim-grammarous')
    "--[ Search ]-----------------------------------------------------------------------------
    if executable(resolve(expand('rg')))
        call dein#add('jremmen/vim-ripgrep')
    endif
    "interactive vim-grep
    call dein#add('dyng/ctrlsf.vim')
    "yet another interactive grepper
    call dein#add('mhinz/vim-grepper')
    " fast fuzzy finder
    call dein#add('junegunn/fzf')
    "fzf vim bindings
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    "fzf-finder for vim options
    call dein#add('teto/nvim-palette', { 'do': ':UpdateRemotePlugins'})
    "file/buffer explorer
    call dein#add('sjbach/lusty.git')
    "--[ Rice ]-------------------------------------------------------------------------------
    "rainbow parentheses
    call dein#add('luochen1990/rainbow')
    "css and colors colorizer
    call dein#add('chrisbra/colorizer')
    "highlight colors in terminal
    call dein#add('sunaku/vim-hicterm')
    "visual replace for multiple files
    call dein#add('thinca/vim-qfreplace.git')
    "--[ Edit ]-------------------------------------------------------------------------------
    "universal formatter
    call dein#add('sbdchd/neoformat')
    ""Snippets with ycm compatibility
    call dein#add('SirVer/ultisnips.git')
    "for tabularizing
    call dein#add('godlygeek/tabular.git', { 'on_cmd' : 'Tabularize'})
    "Extended and fast Join for vim
    call dein#add('chrisbra/Join.git')
    "good mappings and toggles
    call dein#add('tpope/vim-unimpaired.git')
    "dot for everything
    call dein#add('tpope/vim-repeat')
    "undo tree
    call dein#add('simnalamburt/vim-mundo', {'on_cmd': ['MundoToggle']})
    "autopair ()[]{}
    call dein#add('Raimondi/delimitMate')
    "new commands to vim for (){}[]''""<>
    call dein#add('tpope/vim-surround')
    "-----------------------------------------------------------------------------------------
    "stack trace parser
    call dein#add('mattboehm/vim-unstack')
    "jump for vim ids without tags
    call dein#add('mhinz/vim-lookup')
    "generate config for ycm
    call dein#add('rdnetto/YCM-Generator')
    "automake dir which didnt exists
    call dein#add('mopp/autodirmake.vim.git')
    "for SudoWrite, Locate, Find etc
    call dein#add('tpope/vim-eunuch.git')
    "for different case coersion
    call dein#add('tpope/vim-abolish')
    if s:nvim_deoplete
        "modern vim autocomplete
        call dein#add('Shougo/neco-vim')
    endif
    "--[ dcvs ]------------------------------------------------------------------------------
    if executable(resolve(expand('git')))
        "Git stuff. Needed for powerline etc
        call dein#add('tpope/vim-fugitive.git')
        "github bindings for fugitive
        call dein#add('tpope/vim-rhubarb')
        "Git dashboard in vim
        call dein#add('junegunn/vim-github-dashboard.git')
        "github issues autocomp
        call dein#add('jaxbot/github-issues.vim.git')
        "to handle branches/merge conflicts
        call dein#add('idanarye/vim-merginal.git')
        "yet another git commit browser
        call dein#add('junegunn/gv.vim', { 'on_cmd' : 'GV'})
        "diff directories easyer with vim
        call dein#add('vim-scripts/DirDiff.vim.git')
        "show last git changes
        call dein#add('airblade/vim-gitgutter.git')
        "vimagit like magit from emacs inter. mode
        call dein#add('jreybert/vimagit')
    endif
    "----------------------------------------------------------------------------------------
    if executable(resolve(expand('tmux')))
        "tmux basics
        call dein#add('tpope/vim-tbone.git')
        "easy jump between windows
        call dein#add('christoomey/vim-tmux-navigator')
    endif
    "--[ Misc ]------------------------------------------------------------------------------
    "prevent to much ru-en layout switching with c-s
    call dein#add('powerman/vim-plugin-ruscmd')
    " vim nice swapit
    call dein#add('mjbrownie/swapit')
    " Vim file manager
    call dein#add('Shougo/vimfiler.vim')
    " try to autodelect filetype
    call dein#add('s3rvac/AutoFenc')
    " language pack collection
    call dein#add('sheerun/vim-polyglot')
    "better text objects
    call dein#add('wellle/targets.vim')
    "text to esc-seqs in vim
    call dein#add('vim-scripts/Improved-AnsiEsc')
    "Do not update folds when it's not needed
    call dein#add('Konfekt/FastFold')
    "work with ssh easier
    call dein#add('Shougo/neossh.vim.git')
    "VO commandline output
    call dein#add('vim-scripts/ViewOutput.git')
    "framework open file by context
    call dein#add('kana/vim-gf-user.git')
    "go to the changed block under the cursor from diff output
    call dein#add('kana/vim-gf-diff.git')
    "vim-gf-user extension: jump Vim script function
    call dein#add('mattn/gf-user-vimfn.git')
    "funny vim hardmode plugin
    call dein#add('wikitopian/hardmode')
    " There is no need in fixkey for nvim because of it's default behaviour
    if !has('nvim')
        "fixes key codes for console Vim
        call dein#add('drmikehenry/vim-fixkey')
    endif
    "Transparent work with gpg-encrypted files
    call dein#add('jamessan/vim-gnupg.git')
    if executable(resolve(expand('task')))
        "add taskwarrior vim plug wrapper
        call dein#add('blindFS/vim-taskwarrior')
    endif
    "to term of fm
    call dein#add('justinmk/vim-gtfo')
    "rename for files even with spaces in filename
    call dein#add('ReekenX/vim-rename2.git')
    if s:nvim_deoplete
        call dein#add('zchee/deoplete-zsh')
    endif
    "highlight all patterns, not only current
    call dein#add('haya14busa/incsearch.vim', {'merged' : 0})
    "fuzzy incsearch
    call dein#add('haya14busa/incsearch-fuzzy.vim', {'merged' : 0})
    "indentlines
    call dein#add('Yggdroot/indentLine')
    "better interaction with viml
    call dein#add('tpope/vim-scriptease')
    "find whitespaces with ease
    call dein#add('ntpeters/vim-better-whitespace',  { 'on_cmd' : 'StripWhitespace'})
    "better asterisk commands
    call dein#add('haya14busa/vim-asterisk')
    "better neovim terminal-based mode
    call dein#add('Shougo/deol.nvim')
    "try to add some custom hooks with it
    call dein#add('ahw/vim-hooks')
    " An efficient alternative to the standard matchparen plugin
    call dein#add('itchyny/vim-parenmatch')
    " Google calendar in vim
    call dein#add('itchyny/calendar.vim')
    "--[ Docs ]------------------------------------------------------------------------------
    "view and search rfc
    call dein#add('mhinz/vim-rfc')
    "prints doc in echo area
    call dein#add('Shougo/echodoc.vim')
    "integrated reference viewer man/perldoc etc
    call dein#add('thinca/vim-ref.git')
    "dasht integration
    call dein#add('sunaku/vim-dasht')
    "--[ Dev ]-------------------------------------------------------------------------------
    call dein#add('majutsushi/tagbar')
    "patience diff
    call dein#add('chrisbra/vim-diff-enhanced.git')
    "provide async build via tmux
    call dein#add('tpope/vim-dispatch.git')
    if has('nvim')
        "ale as linter
        call dein#add('w0rp/ale', {'merged' : 0, 'loadconf' : 1 , 'loadconf_before' : 1})
    endif
    if executable(resolve(expand('rc')))
        "rtags plugin for vim
        call dein#add('lyuts/vim-rtags.git')
    endif
    if executable(resolve(expand('lldb')))
        "lldb bindings to neovim
        call dein#add('critiqjo/lldb.nvim')
    endif
    "try it instead of tcommentc
    call dein#add('tpope/vim-commentary.git')
    "to insert endif for if, end for begin and so on
    call dein#add('tpope/vim-endwise')
    "better rooter
    call dein#add('dbakker/vim-projectroot')
    "switching between companion source files (e.g. .h and .cpp)
    call dein#add('derekwyatt/vim-fswitch.git')
    "easy testing for various langs
    call dein#add('janko-m/vim-test.git')
    "--[ Scala ]-----------------------------------------------------------------------------
    "scala vim autocompletion
    call dein#add('ensime/ensime-vim')
    "various initial scala support for vim
    call dein#add('derekwyatt/vim-scala')
    "basic SBT support for vim
    call dein#add('derekwyatt/vim-sbt')
    "--[ Python ]-----------------------------------------------------------------------------
    "autochecks for indent
    call dein#add('vim-scripts/IndentConsistencyCop.git', { 'on_ft' : 'python'})
    "python autoindent pep8 compatible
    call dein#add('hynek/vim-python-pep8-indent.git', { 'on_ft' : 'python'})
    "pydoc integration
    call dein#add('fs111/pydoc.vim', { 'on_ft' : 'python'})
    "gf for python
    call dein#add('mkomitee/vim-gf-python.git', { 'on_ft' : 'python'})
    if s:nvim_deoplete
        call dein#add('zchee/deoplete-jedi', { 'on_ft' : 'python'})
    endif
    "--[ R ]----------------------------------------------------------------------------------
    if has('nvim')
        "nvim R support
        call dein#add('jalvesaq/Nvim-R')
    endif
    "--[ Mono ]-------------------------------------------------------------------------------
    if executable('mono')
        "omnisharp completion
        call dein#add('nosami/Omnisharp.git')
    endif
    "--[ Go ]---------------------------------------------------------------------------------
    if executable(resolve(expand('gotags')))
        "tags for go
        call dein#add('jstemmer/gotags.git')
    endif
    if executable(resolve(expand('go')))
        if s:nvim_deoplete
            call dein#add('zchee/deoplete-go', {'on_ft' : 'go', 'build': 'make'})
        else
            "omnicomplete for go
            call dein#add('Blackrush/vim-gocode.git')
            "golang support
            call dein#add('fatih/vim-go.git', { 'on_ft' : 'go', 'loadconf_before' : 1})
        endif
    endif
    "golang syntax highlight
    call dein#add('jnwhiteh/vim-golang.git')
    "--[ Rust ]-------------------------------------------------------------------------------
    if executable(resolve(expand('rustc')))
        "racer support
        call dein#add('racer-rust/vim-racer', {'on_ft' : 'rust'})
        "detection of rust files
        call dein#add('rust-lang/rust.vim', {'on_ft' : 'rust', 'merged' : 1})
        "rust-cargo bindings
        call dein#add('jtdowney/vimux-cargo')
        if s:nvim_deoplete
            " deoplete support via racer
            call dein#add('sebastianmarkow/deoplete-rust', {'on_ft' : 'rust'})
        endif
    endif
    "--[ Elixir ]-----------------------------------------------------------------------------
    if executable(resolve(expand('elixir')))
        " deoplete support via alchemist-server
        if s:nvim_deoplete
            call dein#add('slashmili/alchemist.vim', { 'on_ft' : 'elixir'})
        endif
    endif
    "--[ Nim ]---------------------------------------------------------------------------------
    if has('nvim') && has('use_nim')
        if executable(resolve(expand('nim'))) && executable(resolve(expand('nimble')))
            "nim support for vim and advanced support for neovim
            call dein#add('baabelfish/nvim-nim')
            "syntax file for nim
            call dein#add('zah/nim.vim', {'on_ft': ['nim']})
        endif
    endif
    "--[ Haskell ]-----------------------------------------------------------------------------
    if executable(resolve(expand('ghci')))
        "autocomplete for hs using ghc-mod
        call dein#add('ujihisa/neco-ghc', { 'on_ft' : 'haskell'})
        "ghc-mod integration
        call dein#add('eagletmt/ghcmod-vim.git', { 'on_ft' : 'haskell'})
        "type-related features
        call dein#add('bitc/vim-hdevtools', { 'on_ft' : 'haskell'})
        if has('nvim')
            call dein#add('neovimhaskell/haskell-vim', { 'on_ft' : 'haskell'})
        else
            "better haskell syntax hi with better indenting
            call dein#add('neg-serg/vim2hs', { 'on_ft' : 'haskell'})
        endif
    endif
    "--[ Ruby ]--------------------------------------------------------------------------------
    if has('ruby')
        if executable(resolve(expand('ruby')))
            "alternative ruby autocompletion
            call dein#add('osyo-manga/vim-monster')
            "rails plugin from Tim Pope
            call dein#add('tpope/vim-rails.git')
            "ruby rake support
            call dein#add('tpope/vim-rake.git')
            "ruby rbenv support
            call dein#add('tpope/vim-rbenv.git')
            "ruby bundler support
            call dein#add('tpope/vim-bundler')
            "provides database access to many dbms
            call dein#add('vim-scripts/dbext.vim')
            if has('loled')
                "plugin to run ruby tests
                call dein#add('skalnik/vim-vroom')
            endif
        endif
    endif
    "--[ Go ]----------------------------------------------------------------------------------
    if has('go')
        if s:nvim_deoplete
            call dein#add('zchee/deoplete-go')
        endif
    endif
    "--[ Lisp-like ]---------------------------------------------------------------------------
    "better clojure support
    call dein#add('guns/vim-clojure-static')
    "clojure async nvim-only dev environment
    call dein#add('clojure-vim/acid.nvim')
    "common lisp dev environment
    call dein#add('l04m33/vlime', {'on_ft' : 'lisp', 'rtp': 'vim'})
    "--[ Misc Langs ]--------------------------------------------------------------------------
    if executable(resolve(expand('php')))
        if s:nvim_deoplete
            call dein#add('php-vim/phpcd.vim', { 'on_ft' : 'php', 'build' : 'composer install'})
        endif
        "modern php syntax file
        call dein#add('StanAngeloff/php.vim', { 'on_ft' : 'php'})
        "indenting plugin for php
        call dein#add('2072/PHP-Indenting-for-VIm', { 'on_ft' : 'php'})
        "tiny php-spec wrapper
        call dein#add('rafi/vim-phpspec', { 'on_ft' : 'php'})
    endif
    " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
    call dein#add('joonty/vdebug', {'on_cmd': ['VdebugStart']})
    " html5 autocomplete and syntax
    call dein#add('othree/html5.vim', {'on_ft': ['html', 'htmldjango']})
    "swig syntax highlighting
    call dein#add('SpaceVim/vim-swig')
    "perl support
    call dein#add('WolfgangMehner/perl-support', {'on_ft' : 'perl'})
    "perl omnicomplete
    call dein#add('c9s/perlomni.vim', {'on_ft' : 'perl'})
    "expanding abbreviations similar to emmet
    call dein#add('mattn/emmet-vim', { 'on_cmd' : 'EmmetInstall'})
    "perl support
    call dein#add('vim-perl/vim-perl', {'on_ft': ['perl']})
    "vim plugin for supercollider
    call dein#add('sbl/scvim.git', {'on_ft': ['supercollider']})
    "vim erlang support
    call dein#add('oscarh/vimerl', {'on_ft': ['erlang']})
    "tiny swift support
    call dein#add('kballard/vim-swift', {'on_ft': ['swift']})
    "crystal language support
    call dein#add('rhysd/vim-crystal', {'on_ft' : 'crystal'})
    "ocaml support
    call dein#add('ocaml/merlin', {'on_ft' : 'ocaml', 'rtp' : 'vim/merlin'})
    "swift autocomplete
    if s:nvim_deoplete
        "deoplete support
        call dein#add('mitsuse/autocomplete-swift')
    endif
    "----------------[  Tags  ]--------------------------------------------------------------
    "autogen ctags
    call dein#add('szw/vim-tags')
    if executable(resolve(expand('gtags')))
        "Gtags v0.64
        call dein#add('yuki777/gtags.vim.git')
        "autogenerate gtags to cscope db
        call dein#add('bbchung/gasynctags.git')
        " my gtags-cscope fork
        call dein#add('https://github.com/neg-serg/gtags-cscope-vim')
        if s:nvim_deoplete
                " deoplete support
                call dein#add('ozelentok/deoplete-gtags')
            endif
    endif
    "--[ LaTeX ]-----------------------------------------------------------------------------
    call dein#add('donRaphaco/neotex', {'on_ft': ['tex']})
    "--[ Web ]-------------------------------------------------------------------------------
    "write html code faster
    call dein#add('rstacruz/sparkup.git', {'on_ft': ['html']})
    "markdown vim mode
    call dein#add('tpope/vim-markdown', {'on_ft': ['markdown']})
    "tern for vim
    call dein#add('marijnh/tern_for_vim', { 'on_ft' : ['javascript'],
        \ 'build' : 'npm install',
        \ })
    "deoplete tern support
    call dein#add('carlitux/deoplete-ternjs', { 'on_ft' : ['javascript']})
    "neoformat formatter ;)
    call dein#add('maksimr/vim-jsbeautify', { 'on_ft' : ['javascript']})
    "highlight through quote syntax
    call dein#add('joker1007/vim-markdown-quote-syntax', { 'on_ft' : 'markdown'})
    "plugin to autogenerate table of contents for markdown
    call dein#add('mzlogin/vim-markdown-toc',{ 'on_ft' : 'markdown'})
    "markdown preview
    call dein#add('iamcco/markdown-preview.vim',{ 'on_ft' : 'markdown'})
    "mathjax support for markdown preview
    call dein#add('iamcco/mathjax-support-for-mkdp',{ 'on_ft' : 'markdown'})
    "---------------[ Misc syntax ]----------------------------------------------------------
    "all-in-one vim syntax plugin
    call dein#add('sheerun/vim-polyglot')
    "syntax, indent, and filetype plugin files for git
    call dein#add('tpope/vim-git')
    " region syntax highlighting
    call dein#add('blindFS/vim-regionsyntax', {'on_ft': ['vimwiki', 'markdown', 'tex', 'html']})
    "basic moonscript support
    call dein#add('leafo/moonscript-vim', {'on_ft': ['moonscript']})
    "sxhkd config syntax
    call dein#add('baskerville/vim-sxhkdrc', {'on_ft': ['sxhkdrc']})
    "semantic highlight
    call dein#add('arakashic/chromatica.nvim')
    "gotham colorscheme for nvim
    call dein#add('whatyouhide/vim-gotham')
    "hybrid colorscheme
    call dein#add('w0ng/vim-hybrid')
    "jellybeands colorscheme
    call dein#add('nanotech/jellybeans.vim')
    "onedark colorscheme
    call dein#add('joshdick/onedark.vim')
    "neodark colorscheme
    call dein#add('KeitaNakamura/neodark.vim')
    "FlatColor colorscheme
    call dein#add('MaxSt/FlatColor')
    "great bright colorscheme
    call dein#add('NLKNguyen/papercolor-theme')
    "solarized with better neovim support
    call dein#add('icymind/NeoSolarized')
    "totem theme
    call dein#add('rigaspapas/totem-theme')
    "dark and cold colorscheme
    call dein#add('arcticicestudio/nord-vim')
    "colorscheme and syntax file
    call dein#add('itchyny/landscape.vim')
    "better close buffer
    call dein#add('itchyny/vim-closebuffer')
    "base16 colorschemes pack
    call dein#add('chriskempson/base16-vim')
    "gruvbox colorscheme
    call dein#add('morhetz/gruvbox')
    "deepspace colorscheme
    call dein#add('tyrannicaltoucan/vim-deep-space')
    "fancy icons for fonts
    call dein#add('ryanoasis/vim-devicons.git')

    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif

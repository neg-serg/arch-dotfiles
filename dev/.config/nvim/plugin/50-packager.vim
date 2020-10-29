if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

function! PackInit() abort
    packadd vim-packager
    call packager#init({'jobs': 0})
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Main                                                                              │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
    call packager#add('neoclide/coc.nvim', { 'do': function('InstallCoc') }) " lsp autocomplete
    call packager#add('antoinemadec/coc-fzf', {'branch': 'release'})
    call packager#add('neg-serg/lusty', {'type': 'opt'}) " file/buffer explorer
    call packager#add('justinmk/vim-dirvish') " minimalistic file manager
    call packager#add('airblade/vim-rooter') " autochdir for project root or for current dir
    call packager#add('FooSoft/vim-argwrap') " vim arg wrapper
    call packager#add('honza/vim-snippets') " vim-snippets
    call packager#add('kopischke/vim-fetch') " vim path/to/file.ext:12:3
    call packager#add('neg-serg/neovim-autoload-session', {'type': 'opt'}) " session autosave
    call packager#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'}) " better highlight
    call packager#add('norcalli/nvim-colorizer.lua') " high-performance color highlighter for Neovim
    call packager#add('simnalamburt/vim-mundo', {'type': 'opt'}) " undo tree
    call packager#add('bounceme/remote-viewer') " better ssh support
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Edit                                                                              │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('AndrewRadev/splitjoin.vim') "one-liner to multi-liner
    call packager#add('andymass/vim-matchup') " generic matcher
    call packager#add('haya14busa/vim-asterisk') " smartcase star
    call packager#add('inkarkat/vim-ReplaceWithRegister') " replace with register keybindings
    call packager#add('jiangmiao/auto-pairs') " autopair for brackets
    call packager#add('junegunn/vim-easy-align') " use easy-align, instead of tabular
    call packager#add('lambdalisue/suda.vim') " smart sudo support
    call packager#add('svermeulen/vim-NotableFt') "better ft
    call packager#add('tomtom/tcomment_vim') " commenter plugin
    call packager#add('tpope/vim-abolish') " different case coersion
    call packager#add('tpope/vim-repeat') " better dot
    call packager#add('tpope/vim-sleuth') " autoindent
    call packager#add('tpope/vim-surround') " new commands to vim for generic brackets
    call packager#add('wellle/targets.vim') " better text objects
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Search                                                                            │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'})
    call packager#add('junegunn/fzf.vim') " fzf vim bindings
    call packager#add('pbogut/fzf-mru.vim') " fzf mru source
    call packager#add('yuki-ycino/fzf-preview.vim', {'do': ':UpdateRemotePlugins'}) " integration fzf preview with coc
    call packager#add('eugen0329/vim-esearch') " the best of the best way to search
    call packager#add('romgrk/searchReplace.vim') " better search and replace
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Colorschemes                                                                      │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('neg-serg/neg') " my colorscheme
    call packager#add('kyazdani42/blue-moon') " yet another dark colorscheme
    call packager#add('overcache/NeoSolarized') " neosolarized colorscheme
    call packager#add('wadackel/vim-dogrun') " new colorscheme
    call packager#add('cormacrelf/vim-colors-github') " github-inspired colorscheme
    call packager#add('romgrk/github-light.vim') " light github-inspired colorscheme
    call packager#add('Iron-E/nvim-highlite') " colorscheme add for future reuse
    call packager#add('bluz71/vim-nightfly-guicolors') " nightfly new colorscheme
    call packager#add('Th3Whit3Wolf/space-nvim-theme') " spacemacs colorscheme port
    call packager#add('romgrk/doom-one.vim') " doom colorscheme
    call packager#add('blaketeres/deep-forest.vim') " deep forest colorscheme
    call packager#add('vimoxide/vim-cinnabar') " nice black colorscheme
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Appearance                                                                        │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('arzg/vim-sh') " better sh / zsh highlight
    call packager#add('luochen1990/rainbow') " better rainbow parentheses
    call packager#add('norcalli/nvim-colorizer.lua') " fast js/css colorizer
    call packager#add('pearofducks/ansible-vim', {'do': './UltiSnips/generate.sh'})
    call packager#add('sheerun/vim-polyglot') " language pack collection
    call packager#add('romgrk/nvim-web-devicons') " better devicons support with color
    call packager#add('romgrk/barbar.nvim') " barbar tab statusline
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Dev                                                                               │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('dense-analysis/ale') " async linter with lsp support
    call packager#add('liuchengxu/vista.vim', {'type': 'opt'}) " lsp-symbols tag searcher
    call packager#add('plasticboy/vim-markdown', {'type': 'opt'}) " markdown vim mode
    call packager#add('junegunn/goyo.vim') " make neovim window more readable
    call packager#add('puremourning/vimspector', {'type': 'opt'}) " vim debugging support
    call packager#add('radenling/vim-dispatch-neovim') " neovim support for vim-dispatch
    call packager#add('thinca/vim-ref') " integrated reference viewer for help with separated window
    call packager#add('tpope/vim-apathy') " better include jump
    call packager#add('tpope/vim-dispatch') " provide async build
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ DCVS                                                                              │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('jreybert/vimagit') " interactive work with git
    call packager#add('rhysd/committia.vim') " better commit message
    call packager#add('rhysd/conflict-marker.vim') " good conflict marker
    call packager#add('rhysd/git-messenger.vim') " shows git message
    call packager#add('lambdalisue/gina.vim') " git stuff
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ Misc                                                                              │
    " └───────────────────────────────────────────────────────────────────────────────────┘
    call packager#add('jamessan/vim-gnupg') " transparent work with gpg-encrypted files
    call packager#add('ntpeters/vim-better-whitespace') " delete whitespaces with ease
    call packager#add('pbrisbin/vim-mkdir') " auto make dir without asking
    call packager#add('reedes/vim-pencil') " better text support
    call packager#add('reedes/vim-wordy', {'type': 'opt'}) " style check for english
    call packager#add('vimwiki/vimwiki', {'type': 'opt'}) " personal wiki for vim
    call packager#add('romgrk/todoist.nvim') " todoist support
    call packager#add('vim-voom/VOoM') " two-pane outliner
endfunction

function! InstallCoc(plugin) abort
    exe '!cd '.a:plugin.dir.' && yarn install'
    exe '!cd '.a:plugin.dir.' && npm install coc-diagnostic' . \
    'coc-git coc-actions coc-json coc-translator coc-sql' . \
    'coc-spell-checker coc-solargraph coc-snippets' . \
    'coc-stylelint coc-julia coc-marketplace'
endfunction
command! PackInstall call PackInit() | call packager#install()
command! -bang PackUpdate call PackInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackClean call PackInit() | call packager#clean()
command! PackStatus call PackInit() | call packager#status()

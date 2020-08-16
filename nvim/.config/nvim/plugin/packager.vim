if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

function! PackInit() abort
    packadd vim-packager
    call packager#init({'jobs': 0})
    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
    " --[ Main ]--------------------------------------------------------------------------
    call packager#add('neg-serg/neg') " separated repo for the my own main colorscheme
    call packager#add('neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}) " autocomplete
    call packager#add('neg-serg/neovim-colorschemes') " all colorschemes in the single repo
    call packager#add('neg-serg/neovim-autoload-session') " session autosave
    call packager#add('norcalli/nvim-colorizer.lua') " high-performance color highlighter for Neovim
    call packager#add('easymotion/vim-easymotion') " easymotion
    call packager#add('honza/vim-snippets') " vim-snippets
    call packager#add('FooSoft/vim-argwrap') " vim arg wrapper
    call packager#add('kopischke/vim-fetch') " vim path/to/file.ext:12:3
    call packager#add('justinmk/vim-dirvish') " minimalistic file manager
    call packager#add('airblade/vim-rooter') " autochdir for project root or for current dir
    call packager#add('simnalamburt/vim-mundo', { 'type': 'opt' }) " undo tree
    call packager#add('sjbach/lusty') " file/buffer explorer
    call packager#add('bounceme/remote-viewer', { 'type': 'opt' }) " better ssh support
    " --[ Edit ]-------------------------------------------------------------------------
    call packager#add('tpope/vim-surround') " new commands to vim for generic brackets
    call packager#add('AndrewRadev/dsf.vim') " surround for function calls
    call packager#add('AndrewRadev/splitjoin.vim') "one-liner to multi-liner
    call packager#add('wellle/targets.vim') " better text objects
    call packager#add('jiangmiao/auto-pairs') " autopair for brackets
    call packager#add('junegunn/vim-easy-align') " use easy-align, instead of tabular
    call packager#add('tpope/vim-abolish') " for different case coersion
    call packager#add('haya14busa/vim-asterisk') " smartcase star
    call packager#add('tpope/vim-repeat') " dot for everything
    call packager#add('inkarkat/vim-ReplaceWithRegister') " replace with register keybindings
    call packager#add('lambdalisue/suda.vim') " smart sudo support
    call packager#add('tomtom/tcomment_vim') " commenter plugin
    "--[ Search ]------------------------------------------------------------------------
    call packager#add('junegunn/fzf.vim') " fzf vim bindings
    call packager#add('pbogut/fzf-mru.vim') " fzf mru source
    call packager#add('mhinz/vim-grepper') "better grep plugin
    " --[ Dev ]--------------------------------------------------------------------------
    call packager#add('dense-analysis/ale') " async linter with lsp support
    call packager#add('tpope/vim-dispatch') " provide async build
    call packager#add('radenling/vim-dispatch-neovim') " Neovim support for vim-dispatch
    call packager#add('thinca/vim-ref') " integrated reference viewer for help with separated window
    call packager#add('liuchengxu/vista.vim', { 'type': 'opt' }) " lsp-symbols tag searcher
    call packager#add('puremourning/vimspector', { 'type': 'opt' }) " vim debugging support
    call packager#add('plasticboy/vim-markdown', { 'type': 'opt' }) " markdown vim mode
    " --[ Appearance ]-------------------------------------------------------------------
    call packager#add('sheerun/vim-polyglot') " language pack collection
    call packager#add('chr4/nginx.vim') " nginx config file syntax
    call packager#add('norcalli/nvim-colorizer.lua') " fast js/css colorizer
    call packager#add('luochen1990/rainbow') " better rainbow parentheses
    call packager#add('arzg/vim-sh') " better sh / zsh highlight
    " --[ DCVS ]-------------------------------------------------------------------------
    call packager#add('tpope/vim-fugitive') " git stuff. Needed for powerline etc
    call packager#add('junegunn/gv.vim', { 'type': 'opt' }) " git commit browser
    call packager#add('rhysd/git-messenger.vim') " shows git message
    call packager#add('rhysd/committia.vim') " better commit message
    call packager#add('jreybert/vimagit') " interactive work with git
    " --[ Misc ]-------------------------------------------------------------------------
    call packager#add('jamessan/vim-gnupg') " transparent work with gpg-encrypted files
    call packager#add('ntpeters/vim-better-whitespace') " delete whitespaces with ease
    call packager#add('vimwiki/vimwiki', { 'type': 'opt' }) " personal wiki for vim
    call packager#add('pbrisbin/vim-mkdir') " auto make dir without asking
endfunction

command! PackInstall call PackInit() | call packager#install()
command! -bang PackUpdate call PackInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackClean call PackInit() | call packager#clean()
command! PackStatus call PackInit() | call packager#status()

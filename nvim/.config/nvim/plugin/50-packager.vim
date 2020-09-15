if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

function! PackInit() abort
    packadd vim-packager
    call packager#init({'jobs': 0})
    "--[ Main ]--------------------------------------------------------------------------
    call packager#add('airblade/vim-rooter') " autochdir for project root or for current dir
    call packager#add('bounceme/remote-viewer') " better ssh support
    call packager#add('FooSoft/vim-argwrap') " vim arg wrapper
    call packager#add('honza/vim-snippets') " vim-snippets
    call packager#add('justinmk/vim-dirvish') " minimalistic file manager
    call packager#add('kopischke/vim-fetch') " vim path/to/file.ext:12:3
    call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
    call packager#add('neg-serg/lusty', {'type': 'opt'}) " file/buffer explorer
    call packager#add('neg-serg/neovim-autoload-session', {'type': 'opt'}) " session autosave
    call packager#add('neoclide/coc.nvim') " autocomplete
    call packager#add('norcalli/nvim-colorizer.lua') " high-performance color highlighter for Neovim
	call packager#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'}) " better highlight
    call packager#add('simnalamburt/vim-mundo', {'type': 'opt'}) " undo tree
    "--[ Edit ]-------------------------------------------------------------------------
    call packager#add('AndrewRadev/dsf.vim') " surround for function calls
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
    "--[ Colorschemes ]------------------------------------------------------------------
    call packager#add('neg-serg/neg') " my colorscheme
	call packager#add('overcache/NeoSolarized') " neosolarized colorscheme
    call packager#add('wadackel/vim-dogrun') " new colorscheme
    "--[ Search ]------------------------------------------------------------------------
    call packager#add('eugen0329/vim-esearch') " the best of the best way to search
    call packager#add('junegunn/fzf.vim') " fzf vim bindings
    call packager#add('pbogut/fzf-mru.vim') " fzf mru source
    "--[ Dev ]--------------------------------------------------------------------------
    call packager#add('dense-analysis/ale') " async linter with lsp support
    call packager#add('liuchengxu/vista.vim', {'type': 'opt'}) " lsp-symbols tag searcher
    call packager#add('plasticboy/vim-markdown', {'type': 'opt'}) " markdown vim mode
    call packager#add('puremourning/vimspector', {'type': 'opt'}) " vim debugging support
    call packager#add('radenling/vim-dispatch-neovim') " neovim support for vim-dispatch
    call packager#add('thinca/vim-ref') " integrated reference viewer for help with separated window
    call packager#add('tpope/vim-apathy') " better include jump
    call packager#add('tpope/vim-dispatch') " provide async build
    " --[ Appearance ]-------------------------------------------------------------------
    call packager#add('arzg/vim-sh') " better sh / zsh highlight
    call packager#add('luochen1990/rainbow') " better rainbow parentheses
    call packager#add('norcalli/nvim-colorizer.lua') " fast js/css colorizer
    call packager#add('pearofducks/ansible-vim', {'do': './UltiSnips/generate.sh'})
    call packager#add('sheerun/vim-polyglot') " language pack collection
    "--[ DCVS ]-------------------------------------------------------------------------
    call packager#add('jreybert/vimagit') " interactive work with git
    call packager#add('rhysd/committia.vim') " better commit message
    call packager#add('rhysd/conflict-marker.vim') " good conflict marker
    call packager#add('rhysd/git-messenger.vim') " shows git message
    call packager#add('tpope/vim-fugitive') " git stuff
    "--[ Neovim lua support ]-----------------------------------------------------------
    call packager#add('bakpakin/fennel.vim') " fennel support
    call packager#add('Olical/aniseed', {'tag': 'v3.6.1'}) " fennel neovim support
	call packager#add('svermeulen/vimpeccable') " config with lua
    "--[ Misc ]-------------------------------------------------------------------------
    call packager#add('jamessan/vim-gnupg') " transparent work with gpg-encrypted files
    call packager#add('ntpeters/vim-better-whitespace') " delete whitespaces with ease
    call packager#add('pbrisbin/vim-mkdir') " auto make dir without asking
    call packager#add('reedes/vim-pencil') " better text support
    call packager#add('reedes/vim-wordy', {'type': 'opt'}) " style check for english
    call packager#add('vimwiki/vimwiki', {'type': 'opt'}) " personal wiki for vim
endfunction

command! PackInstall call PackInit() | call packager#install()
command! -bang PackUpdate call PackInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackClean call PackInit() | call packager#clean()
command! PackStatus call PackInit() | call packager#status()

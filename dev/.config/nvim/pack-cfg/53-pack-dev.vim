"--[ Dev ]--------------------------------------------------------------------------
call packager#add('dense-analysis/ale') " async linter with lsp support
call packager#add('liuchengxu/vista.vim', {'type': 'opt'}) " lsp-symbols tag searcher
call packager#add('plasticboy/vim-markdown', {'type': 'opt'}) " markdown vim mode
call packager#add('puremourning/vimspector', {'type': 'opt'}) " vim debugging support
call packager#add('radenling/vim-dispatch-neovim') " neovim support for vim-dispatch
call packager#add('thinca/vim-ref') " integrated reference viewer for help with separated window
call packager#add('tpope/vim-apathy') " better include jump
call packager#add('tpope/vim-dispatch') " provide async build
"--[ DCVS ]-------------------------------------------------------------------------
call packager#add('jreybert/vimagit') " interactive work with git
call packager#add('rhysd/committia.vim') " better commit message
call packager#add('rhysd/conflict-marker.vim') " good conflict marker
call packager#add('rhysd/git-messenger.vim') " shows git message
call packager#add('tpope/vim-fugitive') " git stuff

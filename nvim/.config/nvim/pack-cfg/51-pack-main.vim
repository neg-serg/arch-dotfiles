"--[ Main ]--------------------------------------------------------------------------
call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
call packager#add('neoclide/coc.nvim') " autocomplete
call packager#add('neg-serg/lusty', {'type': 'opt'}) " file/buffer explorer
call packager#add('justinmk/vim-dirvish') " minimalistic file manager
call packager#add('airblade/vim-rooter') " autochdir for project root or for current dir
call packager#add('FooSoft/vim-argwrap') " vim arg wrapper
call packager#add('honza/vim-snippets') " vim-snippets
call packager#add('kopischke/vim-fetch') " vim path/to/file.ext:12:3
call packager#add('wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'})
call packager#add('neg-serg/neovim-autoload-session', {'type': 'opt'}) " session autosave
call packager#add('nvim-treesitter/nvim-treesitter', {'type': 'opt'}) " better highlight
call packager#add('norcalli/nvim-colorizer.lua') " high-performance color highlighter for Neovim
call packager#add('simnalamburt/vim-mundo', {'type': 'opt'}) " undo tree
call packager#add('bounceme/remote-viewer') " better ssh support
"--[ Edit ]-------------------------------------------------------------------------
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
"--[ Search ]------------------------------------------------------------------------
call packager#add('junegunn/fzf.vim') " fzf vim bindings
call packager#add('pbogut/fzf-mru.vim') " fzf mru source
call packager#add('eugen0329/vim-esearch') " the best of the best way to search

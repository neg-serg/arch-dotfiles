-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Main                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'kristijanhusak/vim-packager', opt=true}
    use {'neoclide/coc.nvim' } -- lsp autocomplete
    use {'antoinemadec/coc-fzf'} -- coc fzf support
    use {'neg-serg/lusty', opt=true} -- file/buffer explorer
    use {'justinmk/vim-dirvish'} -- minimalistic file manager
    use {'airblade/vim-rooter'} -- autochdir for project root or for current dir
    use {'FooSoft/vim-argwrap'} -- vim arg wrapper
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- better highlight
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'simnalamburt/vim-mundo', opt=true} -- undo tree
    use {'romgrk/winteract.vim'} -- interactive window resize
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'andymass/vim-matchup'} -- generic matcher
    use {'junegunn/vim-easy-align'} -- use easy-align, instead of tabular
    use {'jiangmiao/auto-pairs'} -- auto-pairs
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'tomtom/tcomment_vim'} -- commenter plugin
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'tpope/vim-repeat'} -- dot for surround
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'junegunn/fzf'} -- fzf binary
    use {'junegunn/fzf.vim'} -- fzf vim bindings
    use {'pbogut/fzf-mru.vim'} -- fzf mru source
    use {'yuki-ycino/fzf-preview.vim'} -- integration fzf preview with coc
    use {'eugen0329/vim-esearch'} -- the best of the best way to search
    use {'romgrk/searchReplace.vim'} -- better search and replace
    use {'svermeulen/vim-subversive'} -- fast substitute
    use {'haya14busa/vim-asterisk'} -- smartcase star
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Colorschemes                                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tjdevries/colorbuddy.nvim'} -- colorscheme create helper
    use {'lifepillar/vim-colortemplate'} -- colortemplate generator
    use {'neg-serg/neg'} -- my colorscheme
    use {'overcache/NeoSolarized'} -- neosolarized colorscheme
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'luochen1990/rainbow'} -- better rainbow parentheses
    -- best color highlighting
    use {'RRethy/vim-hexokinase', run = 'git submodule init && git submodule update && cd hexokinase/ && go build'}
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'justinmk/vim-syntax-extra'} -- better syntax for some langs
    use {'tridactyl/vim-tridactyl', opt=true} -- tridactyl support
    use {'kyazdani42/nvim-web-devicons'} -- better devicons support with color
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'dense-analysis/ale'} -- async linter with lsp support
    use {'liuchengxu/vista.vim', opt=true} -- lsp-symbols tag searcher
    use {'plasticboy/vim-markdown', opt=true} -- markdown vim mode
    use {'tpope/vim-apathy'} -- better include jump
    use {'tpope/vim-dispatch'} -- provide async build
    use {'radenling/vim-dispatch-neovim'} -- neovim support for vim-dispatch
    use {'Yggdroot/indentLine', opt=true} -- try indentline again
    use {'mfussenegger/nvim-dap'} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text'} -- virtual debugging text support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'pearofducks/ansible-vim', opt=true, run = './UltiSnips/generate.sh'}
    use {'arouene/vim-ansible-vault', opt=true} -- ansible-vault support
    use {'saltstack/salt-vim'} -- salt sls support
    use {'rodjek/vim-puppet', opt=true} -- puppet support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'rhysd/committia.vim'} -- better commit message
    use {'rhysd/conflict-marker.vim'} -- good conflict marker
    use {'rhysd/git-messenger.vim'} -- shows git message
    use {'lambdalisue/gina.vim'} -- git stuff new
    use {'tpope/vim-fugitive'} -- git stuff old
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Misc                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'jamessan/vim-gnupg'} -- transparent work with gpg-encrypted files
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil'} -- better text support
    use {'reedes/vim-wordy', opt=true} -- style check for english
    use {'vimwiki/vimwiki', opt=true} -- personal wiki for vim
    use {'romgrk/todoist.nvim', opt=true} -- todoist support
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
end)

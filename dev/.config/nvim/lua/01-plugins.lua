local fn=vim.fn
local install_path=fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute=vim.api.nvim_command
vim.o.termguicolors=true
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd [[packadd packer.nvim]]
if packer_bootstrap then
    require('packer').sync()
end
return require('packer').startup({function(use)
    use {'wbthomason/packer.nvim', opt=true} -- lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Performance / Fixes                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'lewis6991/impatient.nvim' -- faster loading
    use 'dstein64/vim-startuptime' -- startup time measurement
    use 'antoinemadec/FixCursorHold.nvim' -- fix cursorhold slowdown
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'norcalli/nvim_utils' -- neovim lua utils
    use {'airblade/vim-rooter', config=[[require'plugcfg/vim-rooter']]} -- autochdir for project root or for current dir
    use 'kopischke/vim-fetch' -- vim path/to/file.ext:12:3
    use 'pbrisbin/vim-mkdir' -- auto make dir without asking
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use {'nvim-telescope/telescope.nvim', requires={
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            {'nvim-telescope/telescope-frecency.nvim',
                config=[[require'telescope'.load_extension('frecency')]],
                requires={'tami5/sqlite.lua'}
            }
        }
    }
    use {'stevearc/dressing.nvim', config=[[require'plugcfg/dressing']]}
    use {'luukvbaal/nnn.nvim', config=[[require('plugcfg/nnn')]]}
    use 'brooth/far.vim' -- better find and replace
    use {'haya14busa/vim-asterisk', config=[[require'plugcfg/vim-asterisk']]} -- smartcase star
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'onsails/lspkind-nvim' -- lsp pictograms
    use {'neovim/nvim-lspconfig', config=[[require('plugcfg/lspconfig')]]} -- lspconfig
    use {'hrsh7th/nvim-cmp', config=[[require('plugcfg/nvim-cmp').init()]]} -- completion engine
    use 'hrsh7th/cmp-nvim-lua' -- cmp neovim lua api support
    use 'hrsh7th/cmp-nvim-lsp' -- cmp lsp support
    use 'hrsh7th/cmp-path' -- cmp path completion support
    use 'williamboman/nvim-lsp-installer' -- lsp-servers autoinstaller
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'kevinhwang91/nvim-bqf', ft='qf'} -- better quickfix
    use {'jamessan/vim-gnupg', ft='gpg', opt=true} -- transparent work with gpg-encrypted files
    use {'numToStr/Comment.nvim', config=[[require('Comment').setup()]], event='BufRead', opt=true}
    use {'dense-analysis/ale', config=[[require'plugcfg/ale']]} -- async linter with lsp support
    use {'windwp/nvim-autopairs',
        config=[[require('plugcfg/nvim-autopairs')]],
        event='InsertEnter'} -- try new autopairs
    use 'lervag/vimtex' -- modern TeX support
    use {'lewis6991/gitsigns.nvim',
        after='plenary.nvim', config=[[require'plugcfg/gitsigns']], event='BufRead'} -- async gitsigns
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', config=[[require'plugcfg/vim-dispatch']],
        cmd={'Dispatch', 'Make', 'Focus', 'Start'}, opt=true} -- provide async build
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Debug                                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'mfussenegger/nvim-dap', opt=true, config=[[require'plugcfg/dap']]} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt=true} -- virtual debugging text support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Text                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'plasticboy/vim-markdown', ft='md', opt=true} -- markdown vim mode
    use {'nvim-neorg/neorg',
        after = {'nvim-treesitter', 'telescope.nvim'},
        config = [[require'plugcfg/neorg']],
        ft = "norg",
    }
    use {'ellisonleao/glow.nvim', cmd='Glow', opt=true} -- glow preview in terminal
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'AndrewRadev/splitjoin.vim' -- one-line <-> multiline converter
    use {'andymass/vim-matchup', event='VimEnter', config=[[require'plugcfg/vim-matchup']]} -- generic matcher
    use {'FooSoft/vim-argwrap', cmd='ArgWrap', opt=true, config=[[require'plugcfg/argwrap']]} -- vim arg wrapper
    use {'junegunn/vim-easy-align', config=[[require'plugcfg/easyalign']]} -- use easy-align, instead of tabular
    use 'svermeulen/vim-NotableFt' -- better f-t-bindings
    use 'tpope/vim-repeat' -- dot for surround
    use 'tpope/vim-surround' -- new commands to vim for generic brackets
    use 'wellle/targets.vim' -- new text objects
    use 'ntpeters/vim-better-whitespace' -- delete whitespaces with ease
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=[[require'plugcfg/treesitter']]} -- better highlight
    use 'nvim-treesitter/nvim-treesitter-refactor' -- refactor modules for ts
    use 'p00f/nvim-ts-rainbow' -- treesitter-based rainbow
    use 'folke/todo-comments.nvim' -- better highlight TODO, HACK, etc
    use {'kyazdani42/nvim-web-devicons', config=[[require'plugcfg/nvim-web-devicons']]} -- fancy webicons
    use {'yamatsum/nvim-nonicons', requires={'kyazdani42/nvim-web-devicons'}}
    use {'neg-serg/neg', config=[[vim.cmd("colorscheme neg")]]} -- my pure-dark neovim colorscheme
    use {'RRethy/vim-hexokinase', run="make hexokinase"} -- best way to display colors in the file
    use 'tjdevries/colorbuddy.vim' -- for future experiments with new colorschemes
    use {'nathom/filetype.nvim', config=[[require'plugcfg/filetype-nvim']]} -- faster filetype alternative
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'rhysd/conflict-marker.vim', config=[[require'plugcfg/conflict-marker']]} -- good conflict marker
    use {'sindrets/diffview.nvim', cmd={'DiffviewLoad'}, config=[[require'plugcfg/diffview']]} -- diff view for multiple files
    use 'tpope/vim-fugitive' -- git stuff old
end, config={
        display={open_fn=require('packer.util').float},
        compile_path = vim.fn.stdpath('config')..'/lua/packer/packer_compiled.lua'
    }
})

local fn=vim.fn
local install_path=fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute=vim.api.nvim_command
vim.o.termguicolors=true
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt=true} -- no lazy packer
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
    use {'nacro90/numb.nvim', config=[[require('numb').setup()]] } -- interactive number with :<num>
    use 'pbrisbin/vim-mkdir' -- auto make dir without asking
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use 'justinmk/vim-gtfo' -- open filemanager or terminal in current dir
    use {'nvim-telescope/telescope.nvim', requires={
            'nvim-lua/plenary.nvim',
            'fannheyward/telescope-coc.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run='make'},
            {'nvim-telescope/telescope-frecency.nvim',
                config=[[require'telescope'.load_extension('frecency')]],
                requires={'tami5/sql.nvim'}
            }
        }
    }
    use {'rmagatti/auto-session', event='VimEnter', config=[[require('plugcfg/auto-session')]]} -- best modern autosession plugin
    use 'justinmk/vim-dirvish' -- file manager
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'L3MON4D3/LuaSnip' -- lua snippets
    use 'onsails/lspkind-nvim' -- lsp pictograms
    use {'neovim/nvim-lspconfig', config=[[require('plugcfg/lspconfig')]]} -- lspconfig
    use {'hrsh7th/nvim-cmp', config=[[require('plugcfg/nvim-cmp').init()]]} -- completion engine
    use {'saadparwaiz1/cmp_luasnip'} -- lua snippets
    use {'hrsh7th/cmp-nvim-lua'} -- cmp neovim lua api support
    use {'hrsh7th/cmp-nvim-lsp'} -- cmp lsp support
    use {'hrsh7th/cmp-path'} -- cmp path completion support
    use 'williamboman/nvim-lsp-installer' -- lsp-servers autoinstaller
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'kevinhwang91/nvim-bqf', ft = 'qf'} -- better quickfix
    use {'jamessan/vim-gnupg', ft={'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'numToStr/Comment.nvim', config=[[require('Comment').setup()]], event='BufRead', opt=true}
    use {'dense-analysis/ale', config=[[require'plugcfg/ale']]} -- async linter with lsp support
    use {'windwp/nvim-autopairs',
        config=[[require('plugcfg/nvim-autopairs')]],
        event='InsertEnter'} -- try new autopairs
    use 'lervag/vimtex' -- modern TeX support
    use {'lewis6991/gitsigns.nvim',
        after='plenary.nvim', config=[[require'plugcfg/gitsigns']], event='BufRead'} -- async gitsigns
    use {'mfussenegger/nvim-dap', opt=true, config=[[require'plugcfg/dap']]} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt=true} -- virtual debugging text support
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', config=[[require'plugcfg/vim-dispatch']],
        cmd={'Dispatch', 'Make', 'Focus', 'Start'}, opt=true} -- provide async build
    use 'rstacruz/sparkup' -- better emmet-vim
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Text                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'plasticboy/vim-markdown', opt=true} -- markdown vim mode
    use {'reedes/vim-pencil', opt=true,
          cmd={'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'},
          ft={'txt', 'markdown', 'rst'}} -- better text support
    use {"nvim-neorg/neorg", config = [[require'plugcfg/neorg']], requires = "nvim-lua/plenary.nvim"}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'AndrewRadev/splitjoin.vim' -- one-line <-> multiline converter
    use {'andymass/vim-matchup', event='VimEnter', config=[[require'plugcfg/vim-matchup']]} -- generic matcher
    use {'FooSoft/vim-argwrap', cmd='ArgWrap', opt=true, config=[[require'plugcfg/argwrap']]} -- vim arg wrapper
    use {'junegunn/vim-easy-align', config=[[require'plugcfg/easyalign']]} -- use easy-align, instead of tabular
    use 'svermeulen/vim-NotableFt' -- better ft
    use 'tpope/vim-repeat' -- dot for surround
    use 'tpope/vim-surround' -- new commands to vim for generic brackets
    use 'wellle/targets.vim' -- better text objects
    use 'ntpeters/vim-better-whitespace' -- delete whitespaces with ease
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'brooth/far.vim' -- better find and replace
    use {'haya14busa/vim-asterisk', config=[[require'plugcfg/vim-asterisk']]} -- smartcase star
    use 'windwp/nvim-spectre' -- yet another interactive find and replace
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=[[require'plugcfg/treesitter']]} -- better highlight
    use 'p00f/nvim-ts-rainbow' -- treesitter-based rainbow
    use 'MTDL9/vim-log-highlighting' -- better log highlighter
    use 'Bakudankun/PICO-8.vim' -- pico-8 cartridge files
    use 'folke/todo-comments.nvim' -- better highlight TODO, HACK, etc
    use 'ishan9299/nvim-solarized-lua' -- solarized colorscheme
    use {'kyazdani42/nvim-web-devicons', config=[[require'plugcfg/nvim-web-devicons']]} -- fancy webicons
    use {'yamatsum/nvim-nonicons', requires={'kyazdani42/nvim-web-devicons'}}
    use {'neg-serg/neg', config=[[vim.cmd("colorscheme neg")]]} -- my pure-dark neovim colorscheme
    use {'RRethy/vim-hexokinase', run="make hexokinase"} -- best color highlighting
    use 'seanjbl/tonight.nvim' -- darker variant of tommorow
    use 'sheerun/vim-polyglot' -- language pack collection
    use 'tjdevries/colorbuddy.vim' -- for future experiments with new colorschemes
    use 'tridactyl/vim-tridactyl' -- tridactyl support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'saltstack/salt-vim' -- salt sls support
    use 'rodjek/vim-puppet' -- puppet syntax highlighting
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'rhysd/conflict-marker.vim',
        config=[[
            vim.cmd('highlight ConflictMarkerBegin guibg=#2f7366')
            vim.cmd('highlight ConflictMarkerOurs guibg=#2e5049')
            vim.cmd('highlight ConflictMarkerTheirs guibg=#344f69')
            vim.cmd('highlight ConflictMarkerEnd guibg=#2f628e')
            vim.cmd('highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81')
        ]]
    } -- good conflict marker
    use {'sindrets/diffview.nvim',
        cmd={'DiffviewLoad'},
        config=[[require'plugcfg/diffview']]
    } -- diff view for multiple files
    use 'tpope/vim-fugitive' -- git stuff old
end, config={
        display={open_fn=require('packer.util').float},
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }
})

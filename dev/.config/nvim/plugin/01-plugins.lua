local present, packer = pcall(require, 'packer')
if not present then
    local packer_path=vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
    vim.fn.delete(packer_path, 'rf')
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})
    present, packer = pcall(require, 'packer')
    if present then
        print 'Packer cloned successfully.'
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end
vim.api.nvim_cmd({cmd='packadd', args={'packer.nvim'}}, {})
return require('packer').startup({function(use)
    use {'wbthomason/packer.nvim', event='VimEnter', opt=true} -- lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Performance / Fixes                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'lewis6991/impatient.nvim' -- faster loading
    use 'nathom/filetype.nvim' -- faster filetype alternative
    use {'dstein64/vim-startuptime', cmd='StartupTime'} -- startup time measurement
    use 'antoinemadec/FixCursorHold.nvim' -- fix cursorhold slowdown
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'kyazdani42/nvim-web-devicons', event='UIEnter'} -- better icons
    use {'yamatsum/nvim-nonicons', requires={'kyazdani42/nvim-web-devicons'},
         after='nvim-web-devicons'} -- fancy webicons
    use 'neg-serg/NeoRoot.lua' -- autochdir for project root or for current dir
    use {'ghillb/cybu.nvim', -- fancy menu changing
         config=function() require('cfg.cybu') end,
         keys={'<Tab>', '<S-Tab>'}}
    use 'kopischke/vim-fetch' -- vim path/to/file.ext:12:3
    use {'jghauser/mkdir.nvim', config=function() require('mkdir') end, event='BufWritePre'}
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use {'nvim-telescope/telescope.nvim',
        requires={
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            {'nvim-telescope/telescope-frecency.nvim', requires={'tami5/sqlite.lua'}}
        },
        cmd='Telescope',
        keys='<leader>.',
        config=function() require('cfg.telescope') end}
    use 'haya14busa/vim-asterisk' -- smartcase star
    use {'gelguy/wilder.nvim',
        config=function() require('cfg.wilder') end,
        run=':UpdateRemotePlugins',
        event='VimEnter'} -- better cmdline menu
    use 'romgrk/fzy-lua-native' -- fzy native lua integration
    use({'nvim-lualine/lualine.nvim', requires={'arkav/lualine-lsp-progress'} })
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'folke/trouble.nvim',
        requires={'kyazdani42/nvim-web-devicons', after='trouble.nvim'},
        cmd={'Trouble','TroubleClose','TroubleToggle','TroubleRefresh'},
        config=function() require'cfg.trouble' end,
        keys={'<leader>xx'}, opt=true}
    use {'hrsh7th/nvim-cmp', -- completion engine
        config=function() require('cfg.cmp') end,
        after={'LuaSnip'},
        requires={
            {'hrsh7th/cmp-nvim-lsp', after='nvim-cmp'}, -- cmp lsp support
            {'hrsh7th/cmp-nvim-lsp-signature-help', after='nvim-cmp'}, -- experiment with signature-help
            {'hrsh7th/cmp-nvim-lua', after='nvim-cmp'}, -- cmp neovim lua api support
            {'hrsh7th/cmp-path', after='nvim-cmp'}, -- cmp path completion support
            {'onsails/lspkind-nvim'}, -- lsp pictograms
            {'lukas-reineke/cmp-under-comparator'}, -- better nvim-cmp sorter
        }, event={'InsertEnter'}}
    use {{'L3MON4D3/LuaSnip', -- snippets engine
            requires='rafamadriz/friendly-snippets', -- additional snippets'
            config=function() require('cfg.luasnip') end,
            event={"InsertEnter"}},
        {'saadparwaiz1/cmp_luasnip', after={'LuaSnip', 'nvim-cmp'}}, -- lua snippets nvim-cmp support
        event={"InsertEnter"}}
    use {'neovim/nvim-lspconfig', -- lsp config
        config=function() require('cfg.lsp') end,
        requires={'williamboman/nvim-lsp-installer'},
        event={'InsertEnter'}}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'jamessan/vim-gnupg', ft='gpg'} -- transparent work with gpg-encrypted files
    use {'kevinhwang91/nvim-bqf', ft='qf'} -- better quickfix
    use {'lervag/vimtex', ft={'tex','latex'}} -- modern TeX support
    use {'numToStr/Comment.nvim',
        config=function() require("cfg.comment") end,
        event={'BufNewFile','BufRead'}} -- commenter plugin
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', cmd={'Dispatch','Make','Focus','Start'}} -- provide async build
    use {'windwp/nvim-autopairs',
        wants='nvim-cmp',
        config=function() require('cfg.autopairs') end,
        event={'InsertEnter'}} -- super powerful autopairs
    use{'willchao612/vim-diagon', cmd='Diagon'} -- creates diagrams from text. Requires diagon from snap.
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Debug                                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    -- use {'mfussenegger/nvim-dap', -- neovim debugger protocol support
    --     requires = {
    --         {'rcarriga/nvim-dap-ui'},
    --         {'theHamsta/nvim-dap-virtual-text'},  -- virtual debugging text support
    --     },
    --     config=function() require('cfg.nvim-dap') end,
    --     after={'nvim-dap-ui','nvim-dap-virtual-text'},
    --     event={'BufNewFile','BufRead' },
    -- }
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Text                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'plasticboy/vim-markdown', ft='md'} -- markdown vim mode
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'tommcdo/vim-exchange' -- experiment with exchange
    use {'andymass/vim-matchup',
        config=function() require("cfg.matchup") end,
        event = {"BufRead","BufNewFile"}}
    -- generic matcher
    use 'FooSoft/vim-argwrap' -- vim arg wrapper
    use {'junegunn/vim-easy-align',
        config=function() require('cfg.vim-easy-align') end,
        keys={'ga'}} -- use easy-align, instead of tabular
    use 'ntpeters/vim-better-whitespace' -- delete whitespaces with ease
    use 'svermeulen/vim-NotableFt' -- better f-t-bindings
    use {'tpope/vim-repeat', event={"BufRead","BufNewFile"}} -- dot for surround
    use 'tpope/vim-surround' -- new commands to vim for generic brackets
    use 'wellle/targets.vim' -- new text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'neg-serg/neg.nvim' -- my pure-dark neovim colorscheme
    use {'nvim-treesitter/nvim-treesitter',
        cmd='TSUpdate',
        event={'BufRead','BufNewFile','InsertEnter'},
        run=':TSUpdate',  -- better highlight
        config=function() require('cfg.treesitter') end,
        requires = {
            {'nvim-treesitter/nvim-treesitter-textobjects',
                after='nvim-treesitter',
                config=function() require('cfg.treesitter') end,},
            {'p00f/nvim-ts-rainbow', after='nvim-treesitter'}, -- treesitter-based rainbow
            {'RRethy/nvim-treesitter-endwise', after='nvim-treesitter'}, -- ts-based endwise
            {'nvim-treesitter/nvim-treesitter-refactor', after='nvim-treesitter'} -- refactor modules for ts
    }}
    use {'RRethy/vim-hexokinase', run='make hexokinase'} -- best way to display colors in the file
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'akinsho/git-conflict.nvim'
    use {'sindrets/diffview.nvim', -- diff view for multiple files
        cmd={'DiffviewOpen'}, requires={'kyazdani42/nvim-web-devicons','nvim-lua/plenary.nvim'},
        opt=true}
    use {'lewis6991/gitsigns.nvim',
        requires='plenary.nvim',
        config=function() require('cfg.gitsigns') end,
        event={'BufNewFile','BufRead'}} -- async gitsigns
end,
    config={
        display={
            title = 'Packer',
            open_cmd = '85vnew \\[packer\\]', -- An optional command to open a window for packer's display
            keybindings = {toggle_info = '<TAB>'},
        },
        compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua',
        auto_clean = true,
        compile_on_sync = true,
        profile = {enable = true, threshold = 0.0001},
    }
})

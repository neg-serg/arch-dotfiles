local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.api.nvim_cmd({cmd='packadd', args={'packer.nvim'}}, {})
return require'packer'.startup({function(use)
    use {'wbthomason/packer.nvim'} -- lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Performance / Fixes                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'nathom/filetype.nvim',-- faster filetype alternative
         config=function() require'cfg.filetype' end}
    use {'dstein64/vim-startuptime', cmd='StartupTime'} -- startup time measurement
    use {'antoinemadec/FixCursorHold.nvim', -- fix cursorhold slowdown
         config=function() vim.g.cursorhold_updatetime=100 end}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'akinsho/toggleterm.nvim', -- better way to toggle term
        config=function() require'cfg.toggleterm' end,
        keys={'<leader>l'}}
    use {'ahmedkhalf/project.nvim', config = function() require'cfg.project' end}
    use {'kyazdani42/nvim-web-devicons', -- better icons
        config=function() require'cfg.devicons' end, event='UIEnter'}
    use {'yamatsum/nvim-nonicons', requires={'kyazdani42/nvim-web-devicons'},
         after='nvim-web-devicons', event='UIEnter'} -- fancy webicons
    use {'ghillb/cybu.nvim', -- fancy menu changing
         config=function() require'cfg.cybu' end,
         keys={'<Tab>', '<S-Tab>'}}
    use 'kopischke/vim-fetch' -- vim path/to/file.ext:12:3
    use {'jghauser/mkdir.nvim', -- auto make dir when needed
        config=function() require'mkdir' end, event='BufWritePre'}
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use {'nvim-telescope/telescope.nvim', -- modern fuzzy-finder over lists
        requires={
            'nvim-lua/plenary.nvim', -- lua functions
            'romgrk/fzy-lua-native', -- fzy native lua integration
            'nvim-telescope/telescope-fzy-native.nvim', -- telescope with fzy native
            'nvim-telescope/telescope-media-files.nvim', -- media files preview
            {'nvim-telescope/telescope-frecency.nvim', requires={'tami5/sqlite.lua'}}
        },
        module='telescope',
        keys={'<M-b>', '<M-f>', '<M-C-o>', '<M-o>', '<M-d>',
            '<leader>.', '[Qleader]e', '[Qleader]f', '[Qleader]c', '[Qleader]p'},
        config=function() require'cfg.telescope' end}
    use {'haya14busa/vim-asterisk', -- smartcase star
        config=function() require'cfg.asterisk' end}
    use {'gelguy/wilder.nvim', -- fancy cmdline completion
        config=function() require'cfg.wilder' end,
        run=':UpdateRemotePlugins',
        event='CmdlineEnter'} -- better cmdline menu
    use {'windwp/windline.nvim', -- most modern statusline
        config=function() require'cfg.wildline' end}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'folke/trouble.nvim', -- pretty list for diagnostics
        requires={'kyazdani42/nvim-web-devicons', after='trouble.nvim'},
        cmd={'Trouble','TroubleClose','TroubleToggle','TroubleRefresh'},
        config=function() require'cfg.trouble' end,
        keys={'<leader>X'}, opt=true}
    use {'hrsh7th/nvim-cmp', -- completion engine
        config=function() require'cfg.cmp' end,
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
            config=function() require'cfg.luasnip' end,
            event={'BufRead','BufNewFile','InsertEnter'}},
        {'saadparwaiz1/cmp_luasnip', after={'LuaSnip', 'nvim-cmp'}}, -- lua snippets nvim-cmp support
        event={'InsertEnter'}}
    use {'neovim/nvim-lspconfig', -- lsp config
        config=function() require'cfg.lsp' end,
        requires={'williamboman/nvim-lsp-installer'},
        event={'InsertEnter'}}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'danymat/neogen', -- annotation toolkit
        config=function() require'cfg.neogen' end,
        requires='nvim-treesitter/nvim-treesitter'}
    use {'jamessan/vim-gnupg', ft='gpg'} -- transparent work with gpg-encrypted files
    use {'kevinhwang91/nvim-bqf', ft='qf'} -- better quickfix
    use {'lervag/vimtex', ft={'tex','latex'}} -- modern TeX support
    use {'numToStr/Comment.nvim', -- modern commenter
        config=function() require'cfg.comment' end,
        event={'BufNewFile','BufRead'}} -- commenter plugin
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', -- provide async build
        config=function() require'cfg.dispatch' end,
        cmd={'Dispatch','Make','Focus','Start'}}
    use {'windwp/nvim-autopairs', -- super powerful autopairs
        wants='nvim-cmp',
        config=function() require'cfg.autopairs' end,
        event={'InsertEnter'}}
    use{'willchao612/vim-diagon', cmd='Diagon'} -- creates diagrams from text. Requires diagon from snap.
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Debug                                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'mfussenegger/nvim-dap', -- neovim debugger protocol support
        requires={
            {'rcarriga/nvim-dap-ui'}, -- better ui for nvim-dap
            {'theHamsta/nvim-dap-virtual-text'}},  -- virtual debugging text support
        config=function() require'cfg.nvim-dap' end,
        after={'nvim-dap-ui','nvim-dap-virtual-text'},
        event={'BufNewFile','BufRead'}}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Text                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'plasticboy/vim-markdown', ft='md'} -- markdown vim mode
    use {'cstsunfu/md-bullets.nvim', -- markdown org-like bullets(better highlighting)
        config=function() require'cfg.bullets' end}
    use {'lukas-reineke/headlines.nvim', -- adds highlights for text ft, like md, norg
        ft={'markdown','vimwiki'},
        config=function() require 'cfg.headlines' end}
    use {"potamides/pantran.nvim", config=function() require'cfg.translate' end}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'tommcdo/vim-exchange' -- experiment with exchange
    use {'andymass/vim-matchup', -- generic matcher
        config=function() require'cfg.matchup' end,
        event={'BufRead','BufNewFile'}}
    use {'FooSoft/vim-argwrap', -- vim arg wrapper
        config=function() require'cfg.argwrap' end}
    use {'junegunn/vim-easy-align', -- use easy-align, instead of tabular
        config=function() require'cfg.vim-easy-align' end, keys={'ga'}}
    use 'ntpeters/vim-better-whitespace' -- delete whitespaces with ease
    use {'phaazon/hop.nvim', -- speed motions
        config=function() require'cfg.hop' end}
    use {'svermeulen/vim-NotableFt', -- better f-t-bindings
        config=function() require 'cfg.ft' end}
    use {'tpope/vim-repeat', event={'BufRead','BufNewFile'}} -- dot for surround
    use 'tpope/vim-surround' -- new commands to vim for generic brackets
    use 'wellle/targets.vim' -- new text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neg-serg/neg.nvim', -- my pure-dark neovim colorscheme
        config=function() vim.cmd'colorscheme neg' end}
    use {'nvim-treesitter/nvim-treesitter', -- nvim treesitter support
        cmd='TSUpdate',
        event={'BufRead','BufNewFile','InsertEnter'},
        run=':TSUpdate',  -- better highlight
        config=function() require'cfg.treesitter' end,
        requires={
            {'nvim-treesitter/nvim-treesitter-textobjects',
                after='nvim-treesitter',
                config=function() require'cfg.treesitter' end,},
            {'p00f/nvim-ts-rainbow', after='nvim-treesitter'}, -- treesitter-based rainbow
            {'RRethy/nvim-treesitter-endwise', after='nvim-treesitter'}, -- ts-based endwise
            {'nvim-treesitter/nvim-treesitter-refactor', after='nvim-treesitter'} -- refactor modules for ts
    }}
    use {'RRethy/vim-hexokinase', run='make hexokinase'} -- best way to display colors in the file
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'akinsho/git-conflict.nvim', -- visualize and resolve git conflicts
        config=function() require'cfg.gitconflict' end,
        cmd={'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth',
            'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict',
            'GitConflictListQf'}}
    use {'sindrets/diffview.nvim', -- diff view for multiple files
        config=function() require'cfg.diffview' end,
        cmd={'DiffviewOpen','DiffviewFileHistory'},
        requires={'kyazdani42/nvim-web-devicons','nvim-lua/plenary.nvim'},
        keys={'<C-S-G>'}, opt=true}
    use {'lewis6991/gitsigns.nvim',
        requires='plenary.nvim',
        config=function() require'cfg.gitsigns' end,
        event={'BufNewFile','BufRead'}} -- async gitsigns
end,
    config={
        display={
            title='Packer',
            open_cmd='85vnew \\[packer\\]', -- An optional command to open a window for packer's display
            keybindings={toggle_info='<TAB>'},
        },
        auto_clean=true,
        compile_on_sync=true,
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
        profile={enable=false, threshold=0.0001},
    }
})

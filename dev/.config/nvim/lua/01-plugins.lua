local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader=","
require'lazy'.setup({
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐ 
    -- │ █▓▒░ Performance / Fixes                                                          │ 
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'dstein64/vim-startuptime', cmd='StartupTime'}, -- startup time measurement
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐ 
    -- │ █▓▒░ Generic                                                                      │ 
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'akinsho/toggleterm.nvim', -- better way to toggle term
        config=function() require'cfg.toggleterm' end,
        keys={'[Qleader]t'}},
    {'folke/persistence.nvim', config=function() require'cfg.persistence' end},
    {'ahmedkhalf/project.nvim', config=function() require'cfg.project' end},
    {'kyazdani42/nvim-web-devicons', -- better icons
        config=function() require'cfg.devicons' end},
    {'ghillb/cybu.nvim', -- fancy menu changing
        config=function() require'cfg.cybu' end,
        keys={'<Tab>','<S-Tab>'}},
    {'kopischke/vim-fetch'}, -- vim path/to/file.ext:12:4
    {'jghauser/mkdir.nvim', -- auto make dir when needed
        config=function() require'mkdir' end, event='BufWritePre'},
    {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, lazy=true}, -- undo tree
    {'thinca/vim-ref'}, -- integrated reference viewer for help with separated window
    {'nvim-telescope/telescope.nvim', -- modern fuzzy-finder over lists
        dependencies={
            'nvim-lua/plenary.nvim', -- lua functions
            'neg-serg/telescope-pathogen.nvim', -- telescope change directory on the fly
            'debugloop/telescope-undo.nvim', -- telescope show undo
            'jvgrootveld/telescope-zoxide', -- telescope zoxide integration
            'MrcJkb/telescope-manix', -- manix support
            'nvim-telescope/telescope-frecency.nvim', -- MRU frecency
            'natecraddock/telescope-zf-native.nvim', -- zf native sorter
            'renerocksai/telekasten.nvim', -- telescope + telekasten
        },
        config=function() require'cfg.telescope' end,
    },
    {'haya14busa/vim-asterisk', -- smartcase star
        config=function() require'cfg.asterisk' end},
    {'windwp/windline.nvim', -- most modern statusline
        config=function() require'cfg.windline' end},
    {'stevearc/dressing.nvim', -- better select ui
        config=function() require'cfg.dressing' end},
    {'stevearc/oil.nvim',  -- nice netrw replacement
        config=function() require'cfg.oil' end},
    {'chrisgrieser/nvim-alt-substitute', -- alternative substitute
        config=function() require'cfg.alt-substitute' end},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Completion                                                                   │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'hrsh7th/nvim-cmp', -- completion engine
        config=function() require'cfg.cmp' end,
        dependencies={
            'hrsh7th/cmp-nvim-lsp', -- cmp lsp support
            'hrsh7th/cmp-nvim-lsp-signature-help', -- experiment with signature-help
            'hrsh7th/cmp-nvim-lua', -- cmp neovim lua api support
            'hrsh7th/cmp-path', -- cmp path completion support
            'lukas-reineke/cmp-under-comparator', -- better nvim-cmp sorter
    }},
    {'folke/noice.nvim', -- better UX
        event='VimEnter',
        config=function() require'cfg.noice' end,
        dependencies={'MunifTanjim/nui.nvim'}},
    {'L3MON4D3/LuaSnip', -- snippets engine
        config=function() require'cfg.luasnip' end,
        dependencies={
            'rafamadriz/friendly-snippets', -- additional snippets'
            'hrsh7th/nvim-cmp', -- autocompletion engine
        }, 
        event={'BufRead','BufNewFile','InsertEnter'}},
    {'neovim/nvim-lspconfig', -- lsp config
        config=function() require'cfg.lsp' end,
        dependencies={
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig',
            'jay-babu/mason-null-ls.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        }, event={'InsertEnter'}},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Dev                                                                          │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'folke/trouble.nvim', -- pretty list for diagnostics
        dependencies={'kyazdani42/nvim-web-devicons'},
        cmd={'Trouble','TroubleClose','TroubleToggle','TroubleRefresh'},
        config=function() require'cfg.trouble' end,
        keys={'<leader>X'}, lazy=true},
    {'potamides/pantran.nvim', config=function() require'cfg.pantran' end},
    {'jamessan/vim-gnupg', ft='gpg'}, -- transparent work with gpg-encrypted files
    {'lervag/vimtex', ft={'tex','latex'}}, -- modern TeX support
    {'numToStr/Comment.nvim', -- modern commenter
        config=function() require'cfg.comment' end,
        event={'BufNewFile','BufRead'}}, -- commenter plugin
    'tpope/vim-apathy', -- better include jump
    {'tpope/vim-dispatch', -- provide async build
        config=function() require'cfg.dispatch' end,
        keys={'MK','MC','[QLeader]cc','[QLeader]mc'},
        cmd={'Dispatch','Make','Focus','Start'}},
    {'windwp/nvim-autopairs', -- super powerful autopairs
        config=function() require'cfg.autopairs' end,
        event={'InsertEnter'}},
    {'willchao612/vim-diagon', cmd='Diagon'}, -- creates diagrams from text. dependencies diagon from snap.
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Debug                                                                        │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'mfussenegger/nvim-dap', -- neovim debugger protocol support
        dependencies={
            {'rcarriga/nvim-dap-ui'}, -- better ui for nvim-dap
            {'theHamsta/nvim-dap-virtual-text'}},  -- virtual debugging text support
        config=function() require'cfg.nvim-dap' end,
        event={'BufNewFile','BufRead'}},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Text                                                                         │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'plasticboy/vim-markdown', ft='md'}, -- markdown vim mode
    {'mzlogin/vim-markdown-toc', ft='md'}, -- table of contents generator
    {'cstsunfu/md-bullets.nvim', -- markdown org-like bullets(better highlighting)
        config=function() require'cfg.bullets' end},
    {'nvim-orgmode/orgmode', config=function() require'orgmode'.setup{} end,
        ft={'org'},
        dependencies={'nvim-treesitter/nvim-treesitter'}},
    {'superhawk610/ascii-blocks.nvim'}, -- box printer
    {'renerocksai/telekasten.nvim', -- better md wiki stuff
        ft={'md'},
        config=function() require'cfg.telekasten' end},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Edit                                                                         │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'andymass/vim-matchup', -- generic matcher
        config=function() require'cfg.matchup' end,
        event={'BufRead','BufNewFile'}},
    {'FooSoft/vim-argwrap', -- vim arg wrapper
        config=function() require'cfg.argwrap' end},
    {'junegunn/vim-easy-align', -- use easy-align, instead of tabular
        config=function() require'cfg.vim-easy-align' end, keys={'ga'}},
    {'phaazon/hop.nvim', -- speed motions
        config=function() require'cfg.hop' end},
    {'folke/flash.nvim', event='VeryLazy',
        opts={},
        config=function() require'flash'.toggle() end,
        keys={
            {'s', mode={'o','x'}, function() require'flash'.jump() end, desc='Flash'},
            {'S', mode={'o','x'}, function() require'flash'.treesitter() end, desc='Flash Treesitter'},
            {'r', mode='o', function() require'flash'.remote() end, desc='Remote Flash'},
            {'R', mode={'o','x'}, function() require'flash'.treesitter_search() end, desc='Treesitter Search'},
    }},
    {'kylechui/nvim-surround', -- alternative surround
        config=function() require'cfg.surround' end},
    'wellle/targets.vim', -- new text objects
    'lambdalisue/suda.vim', -- sudo write commands
    {'cappyzawa/trim.nvim', -- trim trailing whitespace etc
        config=function() require'cfg.trim' end},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Appearance                                                                   │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'neg-serg/neg.nvim', -- my pure-dark neovim colorscheme
        config=function() vim.cmd'colorscheme neg' end},
    {'Tsuzat/NeoSolarized.nvim'}, -- NeoSolarized colorscheme
    {'mvllow/modes.nvim', -- simple mode-dependent cursor highlight
        config=function() require'cfg.modes' end},
    {'nvim-treesitter/nvim-treesitter', -- nvim treesitter support
        cmd='TSUpdate',
        event={'BufRead','BufNewFile','InsertEnter'},
        build=':TSUpdate',  -- better highlight
        config=function() require'cfg.treesitter' end,
        dependencies={
            {'nvim-treesitter/nvim-treesitter-textobjects',
            config=function() require'cfg.treesitter' end},
            {'RRethy/nvim-treesitter-endwise'}, -- ts-based endwise
    }},
    {'hiphish/rainbow-delimiters.nvim', -- rainbow parenthesis
        config=function() require'cfg.rainbow-delimiters' end},
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ Filetypes                                                                    │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'chr4/nginx.vim', ft='nginx'}, -- nginx better ft
    {'imsnif/kdl.vim', ft='kdl'}, -- kdl ft
    -- ┌───────────────────────────────────────────────────────────────────────────────────┐
    -- │ █▓▒░ DCVS                                                                         │
    -- └───────────────────────────────────────────────────────────────────────────────────┘
    {'akinsho/git-conflict.nvim', -- visualize and resolve git conflicts
        config=function() require'cfg.gitconflict' end,
            cmd={'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth',
                'GitConflictChooseNone', 'GitConflictNextConflict', 'GitConflictPrevConflict',
                'GitConflictListQf'}},
    {'sindrets/diffview.nvim', -- diff view for multiple files
        config=function() require'cfg.diffview' end,
        cmd={'DiffviewOpen','DiffviewFileHistory'},
        dependencies={'kyazdani42/nvim-web-devicons','nvim-lua/plenary.nvim'},
        keys={'<C-S-G>','\\a','\\c','\\r','\\f','\\0','\\1','\\2','\\3','\\4'}, lazy=true},
    {'lewis6991/gitsigns.nvim', -- fast git decorations
        dependencies='plenary.nvim',
        config=function() require'cfg.gitsigns' end,
        event={'BufNewFile','BufRead'}}, -- async gitsigns
})

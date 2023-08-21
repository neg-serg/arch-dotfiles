local fn=vim.fn
local install_path=fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.api.nvim_cmd({cmd='packadd', args={'packer.nvim'}}, {})
return require'packer'.startup({function(use)
    use {'wbthomason/packer.nvim'} -- lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Performance / Fixes                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'dstein64/vim-startuptime', cmd='StartupTime'} -- startup time measurement
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'akinsho/toggleterm.nvim', -- better way to toggle term
        config=function() require'cfg.toggleterm' end,
        keys={'[Qleader]t'}}
    use {'folke/persistence.nvim', config=function() require'cfg.persistence' end}
    use {'ahmedkhalf/project.nvim', config=function() require'cfg.project' end}
    use {'kyazdani42/nvim-web-devicons', -- better icons
        config=function() require'cfg.devicons' end}
    use {'ghillb/cybu.nvim', -- fancy menu changing
         config=function() require'cfg.cybu' end,
         keys={'<Tab>','<S-Tab>'}}
    use 'kopischke/vim-fetch' -- vim path/to/file.ext:12:3
    use {'jghauser/mkdir.nvim', -- auto make dir when needed
        config=function() require'mkdir' end, event='BufWritePre'}
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use {'nvim-telescope/telescope.nvim', -- modern fuzzy-finder over lists
        requires={
            'nvim-lua/plenary.nvim', -- lua functions
            'neg-serg/telescope-pathogen.nvim', -- telescope change directory on the fly
            'debugloop/telescope-undo.nvim', -- telescope show undo
            'jvgrootveld/telescope-zoxide', -- telescope zoxide integration
            {'nvim-telescope/telescope-frecency.nvim', requires={'tami5/sqlite.lua'}},
        },
        module='telescope',
        keys={'cd','E','<M-C-o>','<M-o>','<M-l>','<M-d>','<C-f>',
              '<leader>.','<leader>l',
              '[Qleader]c','[Qleader]e','[Qleader]f'},
        config=function() require'cfg.telescope' end}
    use {'haya14busa/vim-asterisk', -- smartcase star
        config=function() require'cfg.asterisk' end}
    use {'windwp/windline.nvim', -- most modern statusline
        config=function() require'cfg.windline' end}
    use{'stevearc/dressing.nvim', -- better select ui
        config=function() require'cfg.dressing' end}
    use{'stevearc/oil.nvim',  -- nice netrw replacement
        config=function() require'cfg.oil' end}
    use{'chrisgrieser/nvim-alt-substitute', -- alternative substitute
        config=function() require'cfg.alt-substitute' end}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'hrsh7th/nvim-cmp', -- completion engine
        config=function() require'cfg.cmp' end, after={'LuaSnip'},
        requires={
            {'hrsh7th/cmp-nvim-lsp', after='nvim-cmp'}, -- cmp lsp support
            {'lukas-reineke/cmp-under-comparator'}, -- better nvim-cmp sorter
            {'hrsh7th/cmp-nvim-lua', after='nvim-cmp'}, -- cmp neovim lua api support
            {'hrsh7th/cmp-nvim-lsp-signature-help', after='nvim-cmp'}, -- experiment with signature-help
            {'hrsh7th/cmp-path', after='nvim-cmp'}, -- cmp path completion support
    }}
    use {'folke/noice.nvim', -- better UX
        event='VimEnter',
        config=function() require'cfg.noice' end,
        requires={'MunifTanjim/nui.nvim'}}
    use {'L3MON4D3/LuaSnip', -- snippets engine
        config=function() require'cfg.luasnip' end,
        requires='rafamadriz/friendly-snippets', -- additional snippets'
        event={'BufRead','BufNewFile','InsertEnter'}}
    use {'neovim/nvim-lspconfig', -- lsp config
        config=function() require'cfg.lsp' end,
        requires={
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig',
            'jay-babu/mason-null-ls.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        }, event={'InsertEnter'}}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'folke/trouble.nvim', -- pretty list for diagnostics
        requires={'kyazdani42/nvim-web-devicons', after='trouble.nvim'},
        cmd={'Trouble','TroubleClose','TroubleToggle','TroubleRefresh'},
        config=function() require'cfg.trouble' end,
        keys={'<leader>X'}, opt=true}
    use {'potamides/pantran.nvim', config=function() require'cfg.pantran' end}
    use {'jamessan/vim-gnupg', ft='gpg'} -- transparent work with gpg-encrypted files
    use {'lervag/vimtex', ft={'tex','latex'}} -- modern TeX support
    use {'numToStr/Comment.nvim', -- modern commenter
        config=function() require'cfg.comment' end,
        event={'BufNewFile','BufRead'}} -- commenter plugin
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', -- provide async build
        config=function() require'cfg.dispatch' end,
        keys={'MK','MC','[QLeader]cc','[QLeader]mc'},
        cmd={'Dispatch','Make','Focus','Start'}}
    use {'windwp/nvim-autopairs', -- super powerful autopairs
        config=function() require'cfg.autopairs' end,
        event={'InsertEnter'}}
    use {'willchao612/vim-diagon', cmd='Diagon'} -- creates diagrams from text. Requires diagon from snap.
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
    use {'mzlogin/vim-markdown-toc', ft='md'} -- table of contents generator
    use {'cstsunfu/md-bullets.nvim', -- markdown org-like bullets(better highlighting)
        config=function() require'cfg.bullets' end}
    use {'nvim-orgmode/orgmode', config=function() require'orgmode'.setup{} end,
        ft={'org'},
        requires={'nvim-treesitter/nvim-treesitter'}}
    use {'superhawk610/ascii-blocks.nvim'} -- box printer
    use {'renerocksai/telekasten.nvim', -- better md wiki stuff
         event={'BufNewFile','BufRead'},
         config=function() require'cfg.telekasten' end}
    use {'lukas-reineke/headlines.nvim',
        ft={'markdown'},
        dependencies='nvim-treesitter',
        config=function() require'cfg.headline' end}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'andymass/vim-matchup', -- generic matcher
        config=function() require'cfg.matchup' end,
        event={'BufRead','BufNewFile'}}
    use {'FooSoft/vim-argwrap', -- vim arg wrapper
        config=function() require'cfg.argwrap' end}
    use {'junegunn/vim-easy-align', -- use easy-align, instead of tabular
        config=function() require'cfg.vim-easy-align' end, keys={'ga'}}
    use {'phaazon/hop.nvim', -- speed motions
        config=function() require'cfg.hop' end}
    use {'svermeulen/vim-NotableFt', -- better f-t-bindings
        config=function() require'cfg.ft' end}
    use {'kylechui/nvim-surround', -- alternative surround
        config=function() require'cfg.surround' end}
    use 'wellle/targets.vim' -- new text objects
    use 'lambdalisue/suda.vim' -- sudo write commands
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neg-serg/neg.nvim', -- my pure-dark neovim colorscheme
        config=function() vim.cmd'colorscheme neg' end}
    use {'Tsuzat/NeoSolarized.nvim'} -- NeoSolarized colorscheme
    use {'mvllow/modes.nvim', -- simple mode-dependent cursor highlight
        config=function() require'cfg.modes' end}
    use {'nvim-treesitter/nvim-treesitter', -- nvim treesitter support
        cmd='TSUpdate',
        event={'BufRead','BufNewFile','InsertEnter'},
        run=':TSUpdate',  -- better highlight
        config=function() require'cfg.treesitter' end,
        requires={
            {'nvim-treesitter/nvim-treesitter-textobjects',
                after='nvim-treesitter',
                config=function() require'cfg.treesitter' end},
            {'https://gitlab.com/HiPhish/nvim-ts-rainbow2', after='nvim-treesitter'}, -- treesitter-based rainbow
            {'RRethy/nvim-treesitter-endwise', after='nvim-treesitter'}, -- ts-based endwise
            {'nvim-treesitter/nvim-treesitter-refactor', after='nvim-treesitter'} -- refactor modules for ts
    }}
    use {'RRethy/vim-hexokinase', -- best way to display colors in the file
        run='cd ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase && make hexokinase'}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Filetypes                                                                    │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'chr4/nginx.vim', ft='nginx'} -- nginx better ft
    use {'imsnif/kdl.vim', ft='kdl'} -- kdl ft
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
        keys={'<C-S-G>','\\a','\\c','\\r','\\f','\\0','\\1','\\2','\\3','\\4'},opt=true}
    use {'lewis6991/gitsigns.nvim', -- fast git decorations
        requires='plenary.nvim',
        config=function() require'cfg.gitsigns' end,
        event={'BufNewFile','BufRead'}} -- async gitsigns
end, config={
    display={
        title='Packer',
        open_cmd='85vnew \\[packer\\]', -- An optional command to open a window for packer's display
        keybindings={toggle_info='<TAB>'},
    },
    auto_clean=true,
    compile_on_sync=true,
    compile_path=vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
    profile={enable=true, threshold=0.0001}}
})

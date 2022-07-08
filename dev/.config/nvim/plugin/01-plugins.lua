local present, packer = pcall(require, 'packer')
if not present then
    local packer_path=vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
    vim.fn.delete(packer_path, "rf")
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})
    present, packer = pcall(require, "packer")
    if present then
        print "Packer cloned successfully."
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim' -- lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Performance / Fixes                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'lewis6991/impatient.nvim' -- faster loading
    use 'dstein64/vim-startuptime' -- startup time measurement
    use 'antoinemadec/FixCursorHold.nvim' -- fix cursorhold slowdown
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'neg-serg/NeoRoot.lua' -- autochdir for project root or for current dir
    use 'ghillb/cybu.nvim' -- fancy menu changing
    use 'kopischke/vim-fetch' -- vim path/to/file.ext:12:3
    use {'jghauser/mkdir.nvim', config=[[require('mkdir')]], event='BufWritePre'}
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use 'thinca/vim-ref' -- integrated reference viewer for help with separated window
    use {'nvim-telescope/telescope.nvim', requires={
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
        {"nvim-telescope/telescope-frecency.nvim", requires={"tami5/sqlite.lua"}}
    }}
    use 'haya14busa/vim-asterisk' -- smartcase star
    use 'gelguy/wilder.nvim' -- better cmdline menu
    use 'romgrk/fzy-lua-native' -- fzy native lua integration
    use({"nvim-lualine/lualine.nvim", requires={"arkav/lualine-lsp-progress"} })
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Completion                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'folke/trouble.nvim', requires="kyazdani42/nvim-web-devicons"}
    use {'hrsh7th/nvim-cmp', -- completion engine
          requires = {
            'hrsh7th/cmp-nvim-lsp', -- cmp lsp support
            'hrsh7th/cmp-nvim-lua', -- cmp neovim lua api support
            'hrsh7th/cmp-path', -- cmp path completion support
            'lukas-reineke/cmp-under-comparator', -- better nvim-cmp sorter
            'saadparwaiz1/cmp_luasnip', -- lua snippets nvim-cmp support
    }}
    use 'neovim/nvim-lspconfig' -- lspconfig
    use 'onsails/lspkind-nvim' -- lsp pictograms
    use 'williamboman/nvim-lsp-installer' -- lsp-servers autoinstaller
    use 'L3MON4D3/LuaSnip' -- snippets engine
    use 'rafamadriz/friendly-snippets' -- additional snippets
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'jamessan/vim-gnupg', ft='gpg'} -- transparent work with gpg-encrypted files
    use {'kevinhwang91/nvim-bqf', ft='qf'} -- better quickfix
    use 'lervag/vimtex' -- modern TeX support
    use {'lewis6991/gitsigns.nvim', after='plenary.nvim'} -- async gitsigns
    use 'numToStr/Comment.nvim' -- commenter plugin
    use 'tpope/vim-apathy' -- better include jump
    use {'tpope/vim-dispatch', cmd={'Dispatch','Make','Focus','Start'}} -- provide async build
    use {'windwp/nvim-autopairs'} -- super powerful autopairs
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Debug                                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'mfussenegger/nvim-dap', opt=true} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt=true} -- virtual debugging text support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Text                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'plasticboy/vim-markdown', ft='md'} -- markdown vim mode
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'andymass/vim-matchup' -- generic matcher
    use 'FooSoft/vim-argwrap' -- vim arg wrapper
    use 'junegunn/vim-easy-align' -- use easy-align, instead of tabular
    use 'ntpeters/vim-better-whitespace' -- delete whitespaces with ease
    use 'svermeulen/vim-NotableFt' -- better f-t-bindings
    use 'tpope/vim-repeat' -- dot for surround
    use 'tpope/vim-surround' -- new commands to vim for generic brackets
    use 'wellle/targets.vim' -- new text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'nathom/filetype.nvim' -- faster filetype alternative
    use 'neg-serg/neg.nvim' -- my pure-dark neovim colorscheme
    use 'nvim-treesitter/nvim-treesitter-refactor' -- refactor modules for ts
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate',  -- better highlight
          requires = {
            'p00f/nvim-ts-rainbow', -- treesitter-based rainbow
            'RRethy/nvim-treesitter-endwise', -- ts-based endwise
    }}
    use {'RRethy/vim-hexokinase', run='make hexokinase'} -- best way to display colors in the file
    use {'yamatsum/nvim-nonicons', requires={'kyazdani42/nvim-web-devicons'}} -- fancy webicons
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use 'akinsho/git-conflict.nvim'
    use {'sindrets/diffview.nvim', cmd={'DiffviewOpen'}, config=[[require("diffview").setup()]], opt=true} -- diff view for multiple files
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

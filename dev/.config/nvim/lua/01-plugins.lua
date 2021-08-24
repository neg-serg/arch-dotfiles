local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command
vim.o.termguicolors = true
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt=true} -- no lazy packer
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'norcalli/nvim_utils'} -- neovim lua utils
    use {'svermeulen/vimpeccable'} -- neovim lua extensions
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=[[require'plugcfg/treesitter']]} -- better highlight
    use {'airblade/vim-rooter', config=[[require'plugcfg/vim-rooter']]} -- autochdir for project root or for current dir
    use {'jamessan/vim-gnupg', ft={'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'nacro90/numb.nvim', config=[[require('numb').setup()]] } -- interactive number with :<num>
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil', opt=true,
          cmd={'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'},
          ft={'txt', 'markdown', 'rst'}} -- better text support
    use {'reedes/vim-wordy', opt=false} -- style check for english
    use {'romgrk/winteract.vim',
          cmd={'InteractiveWindow'},
          config=[[require'plugcfg/wininteract']],
          opt=true} -- interactive window resize
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
    use {'vimwiki/vimwiki'} -- personal wiki for vim
    use {'p00f/nvim-ts-rainbow'} -- treesitter-based rainbow
    use {'antoinemadec/FixCursorHold.nvim'} -- fix cursorhold slowdown
    use {'MTDL9/vim-log-highlighting'} -- better log highlighter
    use {'justinmk/vim-gtfo'} -- open filemanager or terminal in current dir
    use {'nvim-telescope/telescope.nvim', requires={
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run='make'},
            {'nvim-telescope/telescope-media-files.nvim'},
            {'nvim-telescope/telescope-frecency.nvim',
                config = [[require'telescope'.load_extension('frecency')]],
                requires = {'tami5/sql.nvim'}
            }
        }
    }
    use {'neg-serg/lusty', opt=true} -- best file navigator
    use {'dstein64/vim-startuptime'} -- startup time measurement
    use {'rmagatti/auto-session'} -- best modern autosession plugin
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'kevinhwang91/nvim-bqf'} -- better quickfix
    use {'b3nj5m1n/kommentary', event = 'BufEnter'} -- alternative commenter
    use {'dense-analysis/ale', config=[[require'plugcfg/ale']]} -- async linter with lsp support
    use {'windwp/nvim-autopairs',
        config=[[require('nvim-autopairs').setup({break_line_filetype=nil})]],
        event = 'InsertEnter',
    } -- try new autopairs
    use {'ElPiloto/sidekick.nvim'} -- experimental outline window
    use {'lervag/vimtex'} -- modern TeX support
    use {'lewis6991/gitsigns.nvim',
        after="plenary.nvim", config=[[require'plugcfg/gitsigns']], event = 'BufRead'
    } -- async gitsigns
    use {'pwntester/octo.nvim', config=[[require"octo".setup()]]} -- github review support
    use {'lewis6991/spellsitter.nvim'} -- treesitter-based spellsitter
    use {'Olical/conjure', ft={'fennel', 'clojure'},
        config=function()
            vim.g['conjure#highlight#enabled'] = 1
            vim.g['conjure#highlight#timeout'] = 500
            vim.g['conjure#highlight#group'] = 'IncSearch'
            vim.g['conjure#mapping#doc_word'] = 'K'
        end,
    }
    use {'neoclide/coc.nvim',
        branch = 'master', run = 'yarn install --frozen-lockfile',
        config=[[require'plugcfg/coc']],
    } -- lsp autocomplete
    use {'plasticboy/vim-markdown', opt=true} -- markdown vim mode
    use {'mfussenegger/nvim-dap', opt=true, config=[[require'plugcfg/dap']]} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt=true} -- virtual debugging text support
    use {'tpope/vim-apathy'} -- better include jump
    use {'tpope/vim-dispatch',
        opt=true,
        cmd={'Dispatch', 'Make', 'Focus', 'Start'},
        config=[[require'plugcfg/vim-dispatch']]
    } -- provide async build
    use {'rstacruz/sparkup'} -- better emmet-vim
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'AndrewRadev/splitjoin.vim'} -- one-line <-> multiline converter
    use {'andymass/vim-matchup', event = 'VimEnter', config=[[require'plugcfg/vim-matchup']]} -- generic matcher
    use {'FooSoft/vim-argwrap', cmd={'ArgWrap'}, opt=true, config=[[require'plugcfg/argwrap']]} -- vim arg wrapper
    use {'junegunn/vim-easy-align', config=[[require'plugcfg/easyalign']]} -- use easy-align, instead of tabular
    use {'David-Kunz/treesitter-unit'} -- treesitter-based selection
    use {'mizlan/iswap.nvim'} -- intellectual swap
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'tommcdo/vim-exchange'} -- exchange operator
    use {'tpope/vim-repeat'} -- dot for surround
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'machakann/vim-sandwich'} -- support sandwich surrounds
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'brooth/far.vim'} -- better find and replace
    use {'eugen0329/vim-esearch', config=[[require'plugcfg/esearch']]} -- the best of the best way to search
    use {'haya14busa/vim-asterisk', config=[[require'plugcfg/vim-asterisk']]} -- smartcase star
    use {'windwp/nvim-spectre'} -- yet another interactive find and replace
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {"aouelete/sway-vim-syntax"} -- add sway syntax
    use {'Bakudankun/PICO-8.vim'} -- pico-8 cartridge files
    use {'folke/todo-comments.nvim'} -- better highlight TODO, HACK, etc
    use {'ishan9299/nvim-solarized-lua'} -- solarized colorscheme
    use {'kyazdani42/nvim-web-devicons', config=[[require'plugcfg/nvim-web-devicons']]} -- fancy webicons
    use {'yamatsum/nvim-nonicons', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'neg-serg/neg', config=[[vim.cmd("colorscheme neg")]]} -- my pure-dark neovim colorscheme
    use {'rodjek/vim-puppet'} -- puppet syntax highlighting
    use {'RRethy/vim-hexokinase', run="make hexokinase"} -- best color highlighting
    use {'seanjbl/tonight.nvim'} -- darker variant of tommorow
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'tjdevries/colorbuddy.vim'} -- for future experiments with new colorschemes
    use {'tridactyl/vim-tridactyl'} -- tridactyl support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'saltstack/salt-vim'} -- salt sls support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'iberianpig/tig-explorer.vim'} -- tig integration
    use {'rhysd/conflict-marker.vim',
        config=function()
            vim.cmd[[highlight ConflictMarkerBegin guibg=#2f7366]]
            vim.cmd[[highlight ConflictMarkerOurs guibg=#2e5049]]
            vim.cmd[[highlight ConflictMarkerTheirs guibg=#344f69]]
            vim.cmd[[highlight ConflictMarkerEnd guibg=#2f628e]]
            vim.cmd[[highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81]]
        end
    } -- good conflict marker
    use {'sindrets/diffview.nvim',
        cmd={'DiffviewLoad'},
        config=[[require'plugcfg/diffview']]
    } -- diff view for multiple files
    use {'tpope/vim-fugitive'} -- git stuff old
end, config={display = {open_fn = require('packer.util').float}}
})

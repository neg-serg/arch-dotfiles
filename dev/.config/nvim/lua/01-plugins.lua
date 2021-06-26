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
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=[[require'plugcfg/treesitter']]} -- better highlight
    use {'airblade/vim-rooter', config=[[require'plugcfg/vim-rooter']]} -- autochdir for project root or for current dir
    use {'FooSoft/vim-argwrap', cmd={'ArgWrap'}, opt=false, config=[[require'plugcfg/argwrap']]} -- vim arg wrapper
    use {'jamessan/vim-gnupg', ft={'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'nacro90/numb.nvim', config=[[require('numb').setup()]] }
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'neg-serg/lusty',
          config=function()
            vim.g.LustyJugglerDefaultMappings = 0
            vim.g.LustyExplorerDefaultMappings = 0
            vim.g.LustyExplorerAlwaysShowDotFiles = 1
          end,
          cmd={'LustyFilesystemExplorerFromHere'},
          opt=true,
    } -- file/buffer explorer
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'ojroques/nvim-bufdel'} -- better buffer delete
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil',
          opt=true,
          cmd={'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'},
          ft={'txt', 'markdown', 'rst'}
    } -- better text support
    use {'reedes/vim-wordy', opt=false} -- style check for english
    use {'romgrk/winteract.vim',
          cmd={'InteractiveWindow'},
          config=function() require'plugcfg/wininteract' end,
          opt=false
    } -- interactive window resize
    use {'simnalamburt/vim-mundo', cmd={'MundoToggle'}, opt=true} -- undo tree
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
    use {'vimwiki/vimwiki'} -- personal wiki for vim
    use {'p00f/nvim-ts-rainbow'} -- treesitter-based rainbow
    use {'antoinemadec/FixCursorHold.nvim'} -- fix cursorhold slowdown
    use {'MTDL9/vim-log-highlighting'} -- better log highlighter
    use {'justinmk/vim-gtfo'} -- open filemanager or terminal in current dir
    use {'akinsho/nvim-bufferline.lua'} -- fancy bufferline
    use {'akinsho/nvim-toggleterm.lua',
        config=function()
            vim.cmd('nnoremap <C-Space> :ToggleTerm<CR>')
            vim.cmd('inoremap <silent><C-Space> <Esc>:<c-u>exe v:count1 . "ToggleTerm"<CR>')
            vim.cmd([[autocmd TermEnter term://*toggleterm#* tnoremap <silent><C-Space> <C-\><C-n>:exe v:count1 . "ToggleTerm"<CR>]])
        end
    } -- fast terminal toggle
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Neovim lua stuff                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'norcalli/nvim_utils'} -- new neovim extensions
    use {'svermeulen/vimpeccable'} -- neovim lua extensions
    use {'Olical/aniseed',
        config=[[require('aniseed.env').init({module='dotfiles.init'})]]
    } -- fennel support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'antoinemadec/coc-fzf'} -- coc fzf support
    use {'kevinhwang91/nvim-bqf'} -- better quickfix
    use {'b3nj5m1n/kommentary'} -- alternative commenter
    use {'dense-analysis/ale', config=[[require'plugcfg/ale']]} -- async linter with lsp support
    use {'windwp/nvim-autopairs', config=[[require('nvim-autopairs').setup({break_line_filetype=nil})]]} -- try new autopairs
    use {'ElPiloto/sidekick.nvim'} -- experimental outline window
    use {'eraserhd/parinfer-rust',
        run='cargo build --release',
        ft={"clojure", "fennel", "lisp", "scheme"},
    } -- support lisps
    use 'mizlan/iswap.nvim' -- intellectual swap
    use {'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config=[[require'plugcfg/gitsigns']]
    } -- async gitsigns
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        }
    }
    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = [[require"telescope".load_extension("frecency")]],
        requires = {
            {'tami5/sql.nvim'},
        }
    }
    use {'jvgrootveld/telescope-zoxide'} -- zoxide cd history
    use {'lewis6991/spellsitter.nvim'} -- treesitter-based spellsitter
    use {'mattn/vim-sonictemplate', cmd='Template'} -- snippets alternative
    use {'metakirby5/codi.vim', cmd={'Codi', 'CodiUpdate'}, opt=true} -- nice scratchpad for hackers
    use {'Olical/conjure', ft={'fennel', 'clojure'},
        config=function()
            vim.g['conjure#highlight#enabled'] = 1
            vim.g['conjure#highlight#timeout'] = 500
            vim.g['conjure#highlight#group'] = 'IncSearch'
            vim.g['conjure#mapping#doc_word'] = 'K'
        end,
    }
    use {'neoclide/coc.nvim', config=[[require'plugcfg/coc']]} -- lsp autocomplete
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
    use {'junegunn/vim-easy-align', config=[[require'plugcfg/easyalign']]} -- use easy-align, instead of tabular
    use {'machakann/vim-sandwich'} -- support sandwich surrounds
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'andymass/vim-matchup', event = 'VimEnter', config=[[require'plugcfg/vim-matchup']]} -- generic matcher
    use {'tommcdo/vim-exchange'} -- exchange operator
    use {'tpope/vim-repeat'} -- dot for surround
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'brooth/far.vim'} -- better find and replace
    use {'windwp/nvim-spectre'} -- yet another interactive find and replace
    use {'eugen0329/vim-esearch', config=[[require'plugcfg/esearch']]} -- the best of the best way to search
    use {'haya14busa/vim-asterisk', config=[[require'plugcfg/vim-asterisk']]} -- smartcase star
    use {'junegunn/fzf.vim', config=[[require'plugcfg/fzf']]} -- fzf vim bindings
    use {'yuki-ycino/fzf-preview.vim'} -- integration fzf preview with coc
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {"aouelete/sway-vim-syntax"} -- add sway syntax
    use {'Bakudankun/PICO-8.vim'} -- pico-8 cartridge files
    use {'kyazdani42/nvim-web-devicons', config=[[require'plugcfg/nvim-web-devicons']]} -- fancy webicons
    use {'tjdevries/colorbuddy.vim'} -- for future experiments with new colorschemes
    use {'neg-serg/neg', config=[[vim.cmd("colorscheme neg")]]} -- my pure-dark neovim colorscheme
    use {'ishan9299/nvim-solarized-lua'} -- solarized colorscheme
    use {'RRethy/vim-hexokinase', run="make hexokinase"} -- best color highlighting
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'tridactyl/vim-tridactyl'} -- tridactyl support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'pearofducks/ansible-vim', opt=true, ft='ansible', config=[[require'plugcfg/ansible']]} -- ansible support
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
        config=function() require'plugcfg/diffview' end
    } -- diff view for multiple files
    use {'tpope/vim-fugitive'} -- git stuff old
end, config={
    display = {
        open_fn = require('packer.util').float, }
    }
})

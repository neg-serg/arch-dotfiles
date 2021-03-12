local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- better highlight
    use {'airblade/vim-rooter'} -- autochdir for project root or for current dir
    use {'FooSoft/vim-argwrap', cmd = {'ArgWrap'}, opt=true} -- vim arg wrapper
    use {'jamessan/vim-gnupg', ft = {'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'kristijanhusak/vim-packager', opt=true}
    use {'neg-serg/lusty', opt=true} -- file/buffer explorer
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'ojroques/nvim-bufdel'} -- better buffer delete
    use {'mg979/vim-visual-multi'} -- visual multiline
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil', opt=true,
      cmd = {
        'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'
      }
    } -- better text support
    use {'reedes/vim-wordy', opt=true} -- style check for english
    use {'romgrk/winteract.vim', cmd = {'InteractiveWindow'}, opt=true} -- interactive window resize
    use {'simnalamburt/vim-mundo', cmd = {'MundoToggle'}, opt=true} -- undo tree
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
    use {'vimwiki/vimwiki', ft = {'wiki'}, opt=true} -- personal wiki for vim
    use {'p00f/nvim-ts-rainbow'} -- treesitter-based rainbow
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Neovim lua stuff                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tjdevries/nlua.nvim'} -- neovim lua autocompletion
    use {'norcalli/nvim_utils'} -- new neovim extensions
    use {'svermeulen/vimpeccable'} -- neovim lua extensions
    use {'svermeulen/nvim-moonmaker'} -- moonscript neovim extensions
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neoclide/coc.nvim'} -- lsp autocomplete
    -- branch': 'master', 'do': 'yarn install --frozen-lockfile'
    use {'antoinemadec/coc-fzf'} -- coc fzf support
    use {'dense-analysis/ale'} -- async linter with lsp support
    use {'liuchengxu/vista.vim', opt=true} -- lsp-symbols tag searcher
    use {'mfussenegger/nvim-dap', opt=true} -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt=true} -- virtual debugging text support
    use {'plasticboy/vim-markdown', opt=true} -- markdown vim mode
    use {'tpope/vim-dispatch', opt=true,
        cmd={
          'Dispatch', 'Make', 'Focus', 'Start'
        }
    } -- provide async build
    use {'radenling/vim-dispatch-neovim'} -- neovim support for vim-dispatch
    use {'tpope/vim-apathy', opt=true} -- better include jump
    use {'Olical/conjure', opt=true} -- interactive repl
    use {'metakirby5/codi.vim', opt=true} -- nice scratchpad for hackers
    use {'b3nj5m1n/kommentary'} -- alternative commenter
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'andymass/vim-matchup'} -- generic matcher
    use {'junegunn/vim-easy-align'} -- use easy-align, instead of tabular
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'tpope/vim-repeat'} -- dot for surround
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {"junegunn/fzf", run = function() vim.fn["fzf#install"]() end}  -- fzf binary
    use {'junegunn/fzf.vim'} -- fzf vim bindings
    use {'pbogut/fzf-mru.vim'} -- fzf mru source
    use {'yuki-ycino/fzf-preview.vim'} -- integration fzf preview with coc
    use {'eugen0329/vim-esearch'} -- the best of the best way to search
    use {'haya14busa/vim-asterisk'} -- smartcase star
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neg-serg/neg'} -- my colorscheme
    use {'RRethy/vim-hexokinase', run = "make hexokinase"} -- best color highlighting
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'tridactyl/vim-tridactyl', opt=true} -- tridactyl support
    use {'kyazdani42/nvim-web-devicons'} -- fancy webicons
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'pearofducks/ansible-vim', opt=true, ft = 'yaml'} -- ansible support
    use {'saltstack/salt-vim', opt=true, ft = 'sls'} -- salt sls support
    use {'rodjek/vim-puppet', opt=true, ft = 'pp'} -- puppet support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tpope/vim-fugitive'} -- git stuff old
    use {'rhysd/conflict-marker.vim'} -- good conflict marker
end)

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
    use {'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate',
          config = function() require'plugcfg/treesitter' end
    } -- better highlight
    use {'airblade/vim-rooter',
         config = function() require'plugcfg/vim-rooter' end
    } -- autochdir for project root or for current dir
    use {'FooSoft/vim-argwrap',
        cmd = {'ArgWrap'},
        opt=true,
        config = function() require'plugcfg/argwrap' end
    } -- vim arg wrapper
    use {'jamessan/vim-gnupg', ft = {'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'kristijanhusak/vim-packager', opt=true}
    use {'neg-serg/lusty',
          config = function()
            vim.g.LustyJugglerDefaultMappings = 0
            vim.g.LustyExplorerDefaultMappings = 0
            vim.g.LustyExplorerAlwaysShowDotFiles = 1
          end,
          cmd = {'LustyFilesystemExplorerFromHere'},
          opt = true,
    } -- file/buffer explorer
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'ojroques/nvim-bufdel'} -- better buffer delete
    use {'mg979/vim-visual-multi'} -- visual multiline
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil',
          opt=true,
          cmd = {
            'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'
          }
    } -- better text support
    use {'reedes/vim-wordy', opt=true} -- style check for english
    use {'romgrk/winteract.vim',
          cmd = {'InteractiveWindow'},
          config = function() require'plugcfg/wininteract' end,
          opt=true
    } -- interactive window resize
    use {'simnalamburt/vim-mundo', cmd = {'MundoToggle'}, opt=true} -- undo tree
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
    use {'vimwiki/vimwiki',
          ft = {'wiki'},
          opt=true,
          config = function() require'plugcfg/vimwiki' end
    } -- personal wiki for vim
    use {'p00f/nvim-ts-rainbow'} -- treesitter-based rainbow
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Neovim lua stuff                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tjdevries/nlua.nvim'} -- neovim lua autocompletion
    use {'norcalli/nvim_utils'} -- new neovim extensions
    use {'svermeulen/vimpeccable'} -- neovim lua extensions
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neoclide/coc.nvim',
          config = function() require'plugcfg/coc' end
    } -- lsp autocomplete
    -- branch': 'master', 'do': 'yarn install --frozen-lockfile'
    use {'antoinemadec/coc-fzf'} -- coc fzf support
    use {'dense-analysis/ale',
         config = function() require'plugcfg/ale' end
    } -- async linter with lsp support
    use {'liuchengxu/vista.vim',
          config = function() require'plugcfg/vista' end,
          opt = true
    } -- lsp-symbols tag searcher
    use {'mfussenegger/nvim-dap', opt = true,
          config = function() require'plugcfg/dap' end
    } -- neovim debugger protocol support
    use {'theHamsta/nvim-dap-virtual-text', opt = true} -- virtual debugging text support
    use {'plasticboy/vim-markdown', opt = true} -- markdown vim mode
    use {'tpope/vim-dispatch', opt = true,
        cmd = {
          'Dispatch', 'Make', 'Focus', 'Start'
        },
        config = function() require'plugcfg/vim-dispatch' end
    } -- provide async build
    use {'radenling/vim-dispatch-neovim'} -- neovim support for vim-dispatch
    use {'tpope/vim-apathy', opt = true} -- better include jump
    use {'metakirby5/codi.vim', opt = true} -- nice scratchpad for hackers
    use {'b3nj5m1n/kommentary'} -- alternative commenter
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'andymass/vim-matchup',
          config = function() require'plugcfg/vim-matchup' end
    } -- generic matcher
    use {'junegunn/vim-easy-align',
          config = function() require'plugcfg/easyalign' end
    } -- use easy-align, instead of tabular
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'tpope/vim-repeat'} -- dot for surround
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {"junegunn/fzf",
      run = function() vim.fn["fzf#install"]() end,
      config = function() require'plugcfg/fzf' end
    }  -- fzf binary
    use {'junegunn/fzf.vim'} -- fzf vim bindings
    use {'pbogut/fzf-mru.vim',
      config = function() require'plugcfg/fzfmru' end
    } -- fzf mru source
    use {'yuki-ycino/fzf-preview.vim'} -- integration fzf preview with coc
    use {'eugen0329/vim-esearch',
      config = function() require'plugcfg/esearch' end
    } -- the best of the best way to search
    use {'haya14busa/vim-asterisk',
          config = function() require'plugcfg/vim-asterisk' end
    } -- smartcase star
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'neg-serg/neg'} -- my colorscheme
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'RRethy/vim-hexokinase', run = "make hexokinase"} -- best color highlighting
    use {'tridactyl/vim-tridactyl', ft = 'tridactyl', opt = true} -- tridactyl support
    use {'kyazdani42/nvim-web-devicons',
          config = function() require'plugcfg/nvim-web-devicons' end
    } -- fancy webicons
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'pearofducks/ansible-vim',
        opt = true,
        ft = 'ansible',
        config = function() require'plugcfg/ansible' end
    } -- ansible support
    use {'saltstack/salt-vim', opt = true, ft = 'salt'} -- salt sls support
    use {'rodjek/vim-puppet', opt = true, ft = 'puppet'} -- puppet support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tpope/vim-fugitive'} -- git stuff old
    use {'rhysd/conflict-marker.vim'} -- good conflict marker
end)

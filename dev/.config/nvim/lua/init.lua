_, nvim_utils = pcall(require, "nvim_utils")
require '00-helpers'
require '00-settings'
require '01-plugins'
require '02-bindings'
require '04-aucmds'
require '08-cmds'
require '14-abbr'
require '21-lang'
require '31-statusline'
require '62-sort-operator'

require 'plugcfg/ansible'
require 'plugcfg/vim-dispatch'
require 'plugcfg/ale'
require 'plugcfg/vim-asterisk'
require 'plugcfg/nvim-web-devicons'
require 'plugcfg/vim-matchup'
require 'plugcfg/vimwiki'
require 'plugcfg/vim-rooter'
require 'plugcfg/autopairs'
require 'plugcfg/wininteract'
require 'plugcfg/lusty'
require 'plugcfg/easyalign'
require 'plugcfg/vista'
require 'plugcfg/coc'
require 'plugcfg/dap'
require 'plugcfg/fzf'
require 'plugcfg/argwrap'
require 'plugcfg/fzfmru'
require 'plugcfg/oscyank'
require 'plugcfg/esearch'
require 'plugcfg/telescope'

-- vim.api.nvim_set_keymap('n', '++', '<Plug>kommentary_line_default', { silent = true })
-- vim.api.nvim_set_keymap('v', '++', '<Plug>kommentary_visual_default', { silent = true })
-- utils.nnoremap('<leader>t', '<CMD>lua require"FTerm".toggle()<CR>')
-- utils.tnoremap('<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')

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

-- --SET LEADER GLOBALLY
-- g.mapleader = ' '

-- --TELESCOPE MAPPINGS
-- utils.nnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'s', ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'S', ":lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'G', ":lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'b', ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'c', ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'f', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'f', ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({}))<cr>")
--
-- utils.nnoremap(leader..'5', ":Startify<cr>")
-- utils.vnoremap(leader..'5', ":Startify<cr>")
-- utils.nnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'4', ":lua require'telescope.builtin'.man_pages(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.nnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
-- utils.vnoremap(leader..'3', ":lua require'telescope.builtin'.symbols(require('telescope.themes').get_dropdown({sources = {'emoji'}}))<cr>")
-- utils.nnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.vnoremap(leader..'2', ":lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))<cr>")
-- utils.noremap('',leader..'1', ":lua require'telescope.builtin'.builtin()<cr>")
--
-- --KOMMENTARY MAPPINGS
-- vim.api.nvim_set_keymap('n', '++', '<Plug>kommentary_line_default', { silent = true })
-- vim.api.nvim_set_keymap('v', '++', '<Plug>kommentary_visual_default', { silent = true })
--
-- --TERMINAL MAPPINGS
-- utils.nnoremap('<leader>t', '<CMD>lua require"FTerm".toggle()<CR>')
-- utils.tnoremap('<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')
--

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

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = ">",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {},
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
-- vim.api.nvim_set_keymap('n', '++', '<Plug>kommentary_line_default', { silent = true })
-- vim.api.nvim_set_keymap('v', '++', '<Plug>kommentary_visual_default', { silent = true })
-- utils.nnoremap('<leader>t', '<CMD>lua require"FTerm".toggle()<CR>')
-- utils.tnoremap('<leader>t', '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>')

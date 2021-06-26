--              *
--         *                *
--         _..._      *
--       .'     '.      _
--   *  /    .-""-\   _/ \
--    .-|   /:.   |  |   |
--    |  \  |:.   /.-'-./
--    | .-'-;:__.'    =/
--    .'=  *=|NVIM _.='
--   /   _.  |    ;
--  ;-.-'|    \   |     *
--  |  | \    _\  _\
--  |_/'._;.  ==' ==\     *
--          \    \   |
--          /    /   / *
--    *     /-._/-._/
--        * \   `\  \
--           `-._/._/
require '00-helpers'
require '00-settings'
require '01-plugins'
_, nvim_utils = pcall(require, "nvim_utils")
require '02-bindings'
require '04-aucmds'
require '08-cmds'
require '14-abbr'
require '21-lang'
require '31-statusline'
require '62-sort-operator'

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
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
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

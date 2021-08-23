require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case'
    },
    prompt_prefix = "❯> ",
    selection_caret = "• ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
      -- prompt_position = "bottom",
      horizontal = {mirror = false},
      vertical = {mirror = false},
      height = 8
    },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = { shorten = 5 },
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = false,
    set_env = {['COLORTERM'] = 'truecolor'},
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      border = false,
      previewer = false,
      sorting_strategy = "descending",
      prompt_position = "bottom",
      prompt_title = false,
    },
    oldfiles = {
      theme = "ivy",
      border = false,
      previewer = false,
      sorting_strategy = "descending",
      prompt_position = "bottom",
      prompt_title = false,
    },
  },
}

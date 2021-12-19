require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never', '--no-heading', '--with-filename',
      '--line-number', '--column', '--smart-case'
    },
    dynamic_preview_title = true,
    prompt_prefix = "❯> ",
    selection_caret = "• ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "bottom",
      horizontal = {mirror = false},
      vertical = {mirror = false},
    },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = { "node_modules", ".git" },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = { shorten = 5 },
    winblend = 8,
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
    frecency = {
      show_unindexed = true,
      db_safe_mode = false,
      auto_validate = true,
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      border = false,
      previewer = false,
      sorting_strategy = "descending",
      prompt_title = false,
      find_command={'rg','--files','--hidden','-g','!.git'},
      layout_config = {
        height = 12
      },
    },
    oldfiles = {
      theme = "ivy",
      border = false,
      previewer = false,
      sorting_strategy = "descending",
      prompt_title = false,
    },
  },
}

require('telescope').load_extension('fzf')

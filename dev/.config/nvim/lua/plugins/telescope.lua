return {
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    lazy = true,
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>ft', '<cmd>Telescope live_grep<cr>', desc = 'Search Text in Files' },
      { '<leader>bi', '<cmd>Telescope buffers<cr>', desc = 'List Buffers' },
      { '<M-x>', '<cmd>Telescope commands<cr>', desc = 'Run Command' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = '   ',
          selection_caret = '  ',
          initial_mode = 'normal',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          path_display = { 'truncate' },
          winblend = 0,
          -- border = {},
          borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          -- Keymaps
          mappings = {
            n = {
              ['d'] = require('telescope.actions').delete_buffer,
            },
          },
        },
      }

      -- Theming
      local colors = require('catppuccin.palettes').get_palette()
      local TelescopeColor = {
        TelescopeMatching = { fg = colors.flamingo },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
        TelescopePromptPrefix = { fg = colors.red },
        TelescopePromptNormal = { bg = colors.surface0 },
        TelescopeResultsNormal = { bg = colors.mantle },
        TelescopePreviewNormal = { bg = colors.mantle },
        TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
        TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
        TelescopePromptTitle = { bg = colors.red, fg = colors.mantle },
        TelescopeResultsTitle = { fg = colors.mantle },
        TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      }

      for hl, col in pairs(TelescopeColor) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
  },
  -- Repo Jumping
  {
    'cljoly/telescope-repo.nvim',
    keys = {
      { '<leader>rr', '<cmd>Telescope repo list<cr>', desc = 'Open git repository' },
    },
    config = function()
      require('telescope').load_extension 'repo'
    end,
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    config = function()
      require('telescope').load_extension 'media_files'
    end,
  },
  {
    'mrcjkb/telescope-manix',
    keys = {
      { '<leader>fm', '<cmd>Telescope manix<cr>', desc = 'Search Nix Options and Utils' },
    },
    -- ...
  },
}

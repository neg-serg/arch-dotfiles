-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1d\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    after = { "nvim-cmp", "cmp_luasnip" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.luasnip\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["NeoRoot.lua"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.neoroot\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/NeoRoot.lua",
    url = "https://github.com/neg-serg/NeoRoot.lua"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  cmp_luasnip = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      LuaSnip = true,
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["cybu.nvim"] = {
    config = { "\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rcfg.cybu\frequire\0" },
    keys = { { "", "<Tab>" }, { "", "<S-Tab>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/cybu.nvim",
    url = "https://github.com/ghillb/cybu.nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.filetype\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzy-lua-native"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzy-lua-native",
    url = "https://github.com/romgrk/fzy-lua-native"
  },
  ["git-conflict.nvim"] = {
    commands = { "GitConflictChooseOurs", "GitConflictChooseTheirs", "GitConflictChooseBoth", "GitConflictChooseNone", "GitConflictNextConflict", "GitConflictPrevConflict", "GitConflictListQf" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20cfg.gitconflict\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["headlines.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18cfg.headlines\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/headlines.nvim",
    url = "https://github.com/lukas-reineke/headlines.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fcfg.hop\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["md-bullets.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.bullets\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/md-bullets.nvim",
    url = "https://github.com/cstsunfu/md-bullets.nvim"
  },
  ["mkdir.nvim"] = {
    config = { "\27LJ\2\n%\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\nmkdir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/mkdir.nvim",
    url = "https://github.com/jghauser/mkdir.nvim"
  },
  ["neg.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\20colorscheme neg\bcmd\bvim\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/neg.nvim",
    url = "https://github.com/neg-serg/neg.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15cfg.neogen\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18cfg.autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs",
    wants = { "nvim-cmp" }
  },
  ["nvim-bqf"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lsp", "cmp-nvim-lsp-signature-help", "cmp-nvim-lua", "cmp-path", "cmp_luasnip" },
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fcfg.cmp\frequire\0" },
    load_after = {
      LuaSnip = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.nvim-dap\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fcfg.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-nonicons"] = {
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-nonicons",
    url = "https://github.com/yamatsum/nvim-nonicons"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-endwise", "nvim-treesitter-refactor", "nvim-ts-rainbow", "nvim-treesitter-textobjects" },
    commands = { "TSUpdate" },
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19cfg.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19cfg.treesitter\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    after = { "nvim-nonicons" },
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.devicons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["pantran.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18cfg.translate\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/pantran.nvim",
    url = "https://github.com/potamides/pantran.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18cfg.telescope\frequire\0" },
    keys = { { "", "<M-b>" }, { "", "<M-f>" }, { "", "<M-C-o>" }, { "", "<M-o>" }, { "", "<M-d>" }, { "", "<leader>." }, { "", "[Qleader]e" }, { "", "[Qleader]f" }, { "", "[Qleader]c" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19cfg.toggleterm\frequire\0" },
    keys = { { "", "<leader>l" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.trouble\frequire\0" },
    keys = { { "", "<leader>X" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-NotableFt"] = {
    config = { "\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vcfg.ft\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-NotableFt",
    url = "https://github.com/svermeulen/vim-NotableFt"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-apathy",
    url = "https://github.com/tpope/vim-apathy"
  },
  ["vim-argwrap"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.argwrap\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-argwrap",
    url = "https://github.com/FooSoft/vim-argwrap"
  },
  ["vim-asterisk"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.asterisk\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk",
    url = "https://github.com/haya14busa/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-diagon"] = {
    commands = { "Diagon" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-diagon",
    url = "https://github.com/willchao612/vim-diagon"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.dispatch\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23cfg.vim-easy-align\frequire\0" },
    keys = { { "", "ga" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-exchange",
    url = "https://github.com/tommcdo/vim-exchange"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-fetch",
    url = "https://github.com/kopischke/vim-fetch"
  },
  ["vim-gnupg"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-gnupg",
    url = "https://github.com/jamessan/vim-gnupg"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-hexokinase",
    url = "https://github.com/RRethy/vim-hexokinase"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-matchup"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.matchup\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-mundo"] = {
    commands = { "MundoToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-mundo",
    url = "https://github.com/simnalamburt/vim-mundo"
  },
  ["vim-ref"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-ref",
    url = "https://github.com/thinca/vim-ref"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["wilder.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15cfg.wilder\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  },
  ["windline.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.wildline\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/windline.nvim",
    url = "https://github.com/windwp/windline.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: neg.nvim
time([[Config for neg.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\20colorscheme neg\bcmd\bvim\0", "config", "neg.nvim")
time([[Config for neg.nvim]], false)
-- Config for: vim-asterisk
time([[Config for vim-asterisk]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.asterisk\frequire\0", "config", "vim-asterisk")
time([[Config for vim-asterisk]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15cfg.neogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: FixCursorHold.nvim
time([[Config for FixCursorHold.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1d\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0", "config", "FixCursorHold.nvim")
time([[Config for FixCursorHold.nvim]], false)
-- Config for: pantran.nvim
time([[Config for pantran.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18cfg.translate\frequire\0", "config", "pantran.nvim")
time([[Config for pantran.nvim]], false)
-- Config for: md-bullets.nvim
time([[Config for md-bullets.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.bullets\frequire\0", "config", "md-bullets.nvim")
time([[Config for md-bullets.nvim]], false)
-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.filetype\frequire\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: vim-NotableFt
time([[Config for vim-NotableFt]], true)
try_loadstring("\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vcfg.ft\frequire\0", "config", "vim-NotableFt")
time([[Config for vim-NotableFt]], false)
-- Config for: vim-argwrap
time([[Config for vim-argwrap]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.argwrap\frequire\0", "config", "vim-argwrap")
time([[Config for vim-argwrap]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fcfg.hop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: NeoRoot.lua
time([[Config for NeoRoot.lua]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16cfg.neoroot\frequire\0", "config", "NeoRoot.lua")
time([[Config for NeoRoot.lua]], false)
-- Config for: windline.nvim
time([[Config for windline.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17cfg.wildline\frequire\0", "config", "windline.nvim")
time([[Config for windline.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-dap-virtual-text ]]
vim.cmd [[ packadd nvim-dap-ui ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseOurs lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseOurs", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseTheirs lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseTheirs", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseBoth lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseBoth", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictChooseNone lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictChooseNone", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictNextConflict lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictNextConflict", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictPrevConflict lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictPrevConflict", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GitConflictListQf lua require("packer.load")({'git-conflict.nvim'}, { cmd = "GitConflictListQf", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Diagon lua require("packer.load")({'vim-diagon'}, { cmd = "Diagon", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUpdate lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleRefresh lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleClose lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> ga <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "ga", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-o> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-o>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>l <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>leader>l", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>. <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>leader>.", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-f> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-f>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <S-Tab> <cmd>lua require("packer.load")({'cybu.nvim'}, { keys = "<lt>S-Tab>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Tab> <cmd>lua require("packer.load")({'cybu.nvim'}, { keys = "<lt>Tab>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> [Qleader]c <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "[Qleader]c", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> [Qleader]f <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "[Qleader]f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-b> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-b>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-C-o> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-C-o>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> [Qleader]e <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "[Qleader]e", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <M-d> <cmd>lua require("packer.load")({'telescope.nvim'}, { keys = "<lt>M-d>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>X <cmd>lua require("packer.load")({'trouble.nvim'}, { keys = "<lt>leader>X", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'vim-markdown'}, { ft = "md" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType latex ++once lua require("packer.load")({'vimtex'}, { ft = "latex" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'headlines.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vimwiki ++once lua require("packer.load")({'headlines.nvim'}, { ft = "vimwiki" }, _G.packer_plugins)]]
vim.cmd [[au FileType gpg ++once lua require("packer.load")({'vim-gnupg'}, { ft = "gpg" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'wilder.nvim'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-treesitter', 'nvim-autopairs', 'nvim-lspconfig', 'LuaSnip', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au UIEnter * ++once lua require("packer.load")({'nvim-web-devicons', 'nvim-nonicons'}, { event = "UIEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'gitsigns.nvim', 'nvim-treesitter', 'vim-repeat', 'Comment.nvim', 'LuaSnip', 'vim-matchup', 'nvim-dap'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au BufWritePre * ++once lua require("packer.load")({'mkdir.nvim'}, { event = "BufWritePre *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'gitsigns.nvim', 'nvim-treesitter', 'vim-repeat', 'Comment.nvim', 'LuaSnip', 'vim-matchup', 'nvim-dap'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(0) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

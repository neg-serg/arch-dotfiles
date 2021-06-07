" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
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

time("Luarocks path setup", true)
local package_path_str = "/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/neg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["PICO-8.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/PICO-8.vim"
  },
  ale = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/ale\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["ansible-vim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugcfg/ansible\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc-fzf"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/coc\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["codi.vim"] = {
    commands = { "Codi", "CodiUpdate" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/codi.vim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewLoad" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugcfg/diffview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/far.vim"
  },
  fzf = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-mru.vim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19plugcfg/fzfmru\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-mru.vim"
  },
  ["fzf-preview.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-preview.vim"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/fzf\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugcfg/gitsigns\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  lusty = {
    commands = { "LustyFilesystemExplorerFromHere" },
    config = { "\27LJ\2\nš\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0$LustyExplorerAlwaysShowDotFiles!LustyExplorerDefaultMappings LustyJugglerDefaultMappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/lusty"
  },
  neg = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/neg"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["numb.nvim"] = {
    config = { "require('numb').setup()" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/dap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugcfg/treesitter\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugcfg/nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_utils = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim_utils"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/parinfer-rust"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["salt-vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/salt-vim"
  },
  ["sidekick.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/sidekick.nvim"
  },
  ["spellsitter.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/spellsitter.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["sway-vim-syntax"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/sway-vim-syntax"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["tig-explorer.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/tig-explorer.vim"
  },
  ["vim-NotableFt"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-NotableFt"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-argwrap"] = {
    commands = { "ArgWrap" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugcfg/argwrap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-asterisk"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugcfg/vim-asterisk\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-closer.git"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-closer.git"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugcfg/vim-dispatch\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugcfg/easyalign\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-esearch"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugcfg/esearch\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-esearch"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-fetch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gnupg"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-gnupg"
  },
  ["vim-gtfo"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-gtfo"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-log-highlighting"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-log-highlighting"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-matchup"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugcfg/vim-matchup\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["vim-mkdir"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-mkdir"
  },
  ["vim-mundo"] = {
    commands = { "MundoToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-mundo"
  },
  ["vim-pencil"] = {
    commands = { "Pencil", "PencilHard", "PencilSoft", "PencilToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-pencil"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-ref"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-ref"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugcfg/vim-rooter\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-sonictemplate"] = {
    commands = { "Template" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tridactyl"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-tridactyl"
  },
  ["vim-wordy"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-wordy"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vimpeccable"
  },
  vimwiki = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["winteract.vim"] = {
    commands = { "InteractiveWindow" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugcfg/wininteract\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/winteract.vim"
  }
}

time("Defining packer_plugins", false)
-- Config for: vim-easy-align
time("Config for vim-easy-align", true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugcfg/easyalign\frequire\0", "config", "vim-easy-align")
time("Config for vim-easy-align", false)
-- Config for: fzf.vim
time("Config for fzf.vim", true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/fzf\frequire\0", "config", "fzf.vim")
time("Config for fzf.vim", false)
-- Config for: nvim-web-devicons
time("Config for nvim-web-devicons", true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugcfg/nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time("Config for nvim-web-devicons", false)
-- Config for: numb.nvim
time("Config for numb.nvim", true)
require('numb').setup()
time("Config for numb.nvim", false)
-- Config for: fzf-mru.vim
time("Config for fzf-mru.vim", true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19plugcfg/fzfmru\frequire\0", "config", "fzf-mru.vim")
time("Config for fzf-mru.vim", false)
-- Config for: vim-esearch
time("Config for vim-esearch", true)
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugcfg/esearch\frequire\0", "config", "vim-esearch")
time("Config for vim-esearch", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugcfg/gitsigns\frequire\0", "config", "gitsigns.nvim")
time("Config for gitsigns.nvim", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugcfg/treesitter\frequire\0", "config", "nvim-treesitter")
time("Config for nvim-treesitter", false)
-- Config for: vim-rooter
time("Config for vim-rooter", true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugcfg/vim-rooter\frequire\0", "config", "vim-rooter")
time("Config for vim-rooter", false)
-- Config for: vim-asterisk
time("Config for vim-asterisk", true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugcfg/vim-asterisk\frequire\0", "config", "vim-asterisk")
time("Config for vim-asterisk", false)
-- Config for: coc.nvim
time("Config for coc.nvim", true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/coc\frequire\0", "config", "coc.nvim")
time("Config for coc.nvim", false)
-- Config for: ale
time("Config for ale", true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugcfg/ale\frequire\0", "config", "ale")
time("Config for ale", false)

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file LustyFilesystemExplorerFromHere lua require("packer.load")({'lusty'}, { cmd = "LustyFilesystemExplorerFromHere", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilSoft lua require("packer.load")({'vim-pencil'}, { cmd = "PencilSoft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewLoad lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewLoad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Pencil lua require("packer.load")({'vim-pencil'}, { cmd = "Pencil", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilHard lua require("packer.load")({'vim-pencil'}, { cmd = "PencilHard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilToggle lua require("packer.load")({'vim-pencil'}, { cmd = "PencilToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Template lua require("packer.load")({'vim-sonictemplate'}, { cmd = "Template", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Codi lua require("packer.load")({'codi.vim'}, { cmd = "Codi", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file CodiUpdate lua require("packer.load")({'codi.vim'}, { cmd = "CodiUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file InteractiveWindow lua require("packer.load")({'winteract.vim'}, { cmd = "InteractiveWindow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType gpg ++once lua require("packer.load")({'vim-gnupg'}, { ft = "gpg" }, _G.packer_plugins)]]
vim.cmd [[au FileType txt ++once lua require("packer.load")({'vim-pencil'}, { ft = "txt" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-pencil'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType rst ++once lua require("packer.load")({'vim-pencil'}, { ft = "rst" }, _G.packer_plugins)]]
vim.cmd [[au FileType ansible ++once lua require("packer.load")({'ansible-vim'}, { ft = "ansible" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
  -- Event lazy-loads
time("Defining lazy-load event autocommands", true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-matchup'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time("Defining lazy-load event autocommands", false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time("Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim/ftdetect/ansible.vim", true)
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim/ftdetect/ansible.vim]]
time("Sourcing ftdetect script at: /home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim/ftdetect/ansible.vim", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry

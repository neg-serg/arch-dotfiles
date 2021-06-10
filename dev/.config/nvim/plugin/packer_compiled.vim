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
    config = { "require'plugcfg/ale'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/ale"
  },
  aniseed = {
    config = { "require('aniseed.env').init({module='dotfiles.init'})" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/aniseed"
  },
  ["ansible-vim"] = {
    config = { "require'plugcfg/ansible'" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc-fzf"
  },
  ["coc.nvim"] = {
    config = { "require'plugcfg/coc'" },
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
    config = { "\27LJ\2\nÀ\2\0\0\3\0\a\0\0216\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\1K\0\1\0>highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81.highlight ConflictMarkerEnd guibg=#2f628e1highlight ConflictMarkerTheirs guibg=#344f69/highlight ConflictMarkerOurs guibg=#2e50490highlight ConflictMarkerBegin guibg=#2f7366\bcmd\bvim\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  conjure = {
    config = { "\27LJ\2\n¬\1\0\0\2\0\b\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1Ù\1=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0K\0\1\0\6K\29conjure#mapping#doc_word\14IncSearch\28conjure#highlight#group\30conjure#highlight#timeout\30conjure#highlight#enabled\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/conjure"
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
    config = { "require'plugcfg/fzfmru'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-mru.vim"
  },
  ["fzf-preview.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-preview.vim"
  },
  ["fzf.vim"] = {
    config = { "require'plugcfg/fzf'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "require'plugcfg/gitsigns'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  lusty = {
    commands = { "LustyFilesystemExplorerFromHere" },
    config = { "\27LJ\2\nö\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0$LustyExplorerAlwaysShowDotFiles!LustyExplorerDefaultMappings LustyJugglerDefaultMappings\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/lusty"
  },
  neg = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/neg"
  },
  ["numb.nvim"] = {
    config = { "require('numb').setup()" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "require('nvim-autopairs').setup()" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
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
    config = { "require'plugcfg/dap'" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-solarized-lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-solarized-lua"
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\n√\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0qautocmd TermEnter term://*toggleterm#* tnoremap <silent><C-Space> <C-\\><C-n>:exe v:count1 . \"ToggleTerm\"<CR>'nnoremap <C-Space> :ToggleTerm<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require'plugcfg/treesitter'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "require'plugcfg/nvim-web-devicons'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_utils = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim_utils"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/parinfer-rust"
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
    config = { "require'plugcfg/argwrap'" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-asterisk"] = {
    config = { "require'plugcfg/vim-asterisk'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    config = { "require'plugcfg/vim-dispatch'" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-easy-align"] = {
    config = { "require'plugcfg/easyalign'" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-esearch"] = {
    config = { "require'plugcfg/esearch'" },
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
    config = { "require'plugcfg/vim-matchup'" },
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
    config = { "require'plugcfg/vim-rooter'" },
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
-- Config for: vim-rooter
time("Config for vim-rooter", true)
require'plugcfg/vim-rooter'
time("Config for vim-rooter", false)
-- Config for: gitsigns.nvim
time("Config for gitsigns.nvim", true)
require'plugcfg/gitsigns'
time("Config for gitsigns.nvim", false)
-- Config for: aniseed
time("Config for aniseed", true)
require('aniseed.env').init({module='dotfiles.init'})
time("Config for aniseed", false)
-- Config for: ale
time("Config for ale", true)
require'plugcfg/ale'
time("Config for ale", false)
-- Config for: nvim-toggleterm.lua
time("Config for nvim-toggleterm.lua", true)
try_loadstring("\27LJ\2\n√\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0qautocmd TermEnter term://*toggleterm#* tnoremap <silent><C-Space> <C-\\><C-n>:exe v:count1 . \"ToggleTerm\"<CR>'nnoremap <C-Space> :ToggleTerm<CR>\bcmd\bvim\0", "config", "nvim-toggleterm.lua")
time("Config for nvim-toggleterm.lua", false)
-- Config for: nvim-autopairs
time("Config for nvim-autopairs", true)
require('nvim-autopairs').setup()
time("Config for nvim-autopairs", false)
-- Config for: vim-easy-align
time("Config for vim-easy-align", true)
require'plugcfg/easyalign'
time("Config for vim-easy-align", false)
-- Config for: vim-esearch
time("Config for vim-esearch", true)
require'plugcfg/esearch'
time("Config for vim-esearch", false)
-- Config for: numb.nvim
time("Config for numb.nvim", true)
require('numb').setup()
time("Config for numb.nvim", false)
-- Config for: fzf-mru.vim
time("Config for fzf-mru.vim", true)
require'plugcfg/fzfmru'
time("Config for fzf-mru.vim", false)
-- Config for: nvim-web-devicons
time("Config for nvim-web-devicons", true)
require'plugcfg/nvim-web-devicons'
time("Config for nvim-web-devicons", false)
-- Config for: vim-asterisk
time("Config for vim-asterisk", true)
require'plugcfg/vim-asterisk'
time("Config for vim-asterisk", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
require'plugcfg/treesitter'
time("Config for nvim-treesitter", false)
-- Config for: conflict-marker.vim
time("Config for conflict-marker.vim", true)
try_loadstring("\27LJ\2\nÀ\2\0\0\3\0\a\0\0216\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\1K\0\1\0>highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81.highlight ConflictMarkerEnd guibg=#2f628e1highlight ConflictMarkerTheirs guibg=#344f69/highlight ConflictMarkerOurs guibg=#2e50490highlight ConflictMarkerBegin guibg=#2f7366\bcmd\bvim\0", "config", "conflict-marker.vim")
time("Config for conflict-marker.vim", false)
-- Config for: coc.nvim
time("Config for coc.nvim", true)
require'plugcfg/coc'
time("Config for coc.nvim", false)
-- Config for: fzf.vim
time("Config for fzf.vim", true)
require'plugcfg/fzf'
time("Config for fzf.vim", false)

-- Command lazy-loads
time("Defining lazy-load commands", true)
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilHard lua require("packer.load")({'vim-pencil'}, { cmd = "PencilHard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilSoft lua require("packer.load")({'vim-pencil'}, { cmd = "PencilSoft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilToggle lua require("packer.load")({'vim-pencil'}, { cmd = "PencilToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewLoad lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewLoad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file InteractiveWindow lua require("packer.load")({'winteract.vim'}, { cmd = "InteractiveWindow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file LustyFilesystemExplorerFromHere lua require("packer.load")({'lusty'}, { cmd = "LustyFilesystemExplorerFromHere", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Template lua require("packer.load")({'vim-sonictemplate'}, { cmd = "Template", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Pencil lua require("packer.load")({'vim-pencil'}, { cmd = "Pencil", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Codi lua require("packer.load")({'codi.vim'}, { cmd = "Codi", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file CodiUpdate lua require("packer.load")({'codi.vim'}, { cmd = "CodiUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time("Defining lazy-load commands", false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType gpg ++once lua require("packer.load")({'vim-gnupg'}, { ft = "gpg" }, _G.packer_plugins)]]
vim.cmd [[au FileType lisp ++once lua require("packer.load")({'parinfer-rust'}, { ft = "lisp" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-pencil'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType rst ++once lua require("packer.load")({'vim-pencil'}, { ft = "rst" }, _G.packer_plugins)]]
vim.cmd [[au FileType ansible ++once lua require("packer.load")({'ansible-vim'}, { ft = "ansible" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'parinfer-rust', 'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd [[au FileType txt ++once lua require("packer.load")({'vim-pencil'}, { ft = "txt" }, _G.packer_plugins)]]
vim.cmd [[au FileType scheme ++once lua require("packer.load")({'parinfer-rust'}, { ft = "scheme" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'parinfer-rust', 'conjure'}, { ft = "fennel" }, _G.packer_plugins)]]
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

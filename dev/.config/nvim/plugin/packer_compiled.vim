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
local package_path_str = "/home/neg/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/neg/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/neg/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/neg/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ale = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/ale\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["ansible-vim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugcfg/ansible\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc-fzf"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/coc\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["codi.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/codi.vim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  conjure = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/conjure"
  },
  fzf = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/fzf\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-mru.vim"] = {
    config = { "\27LJ\1\2.\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\19plugcfg/fzfmru\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-mru.vim"
  },
  ["fzf-preview.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf-preview.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  kommentary = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  lusty = {
    commands = { "LustyFilesystemExplorerFromHere" },
    config = { "\27LJ\1\2ò\1\0\0\5\0\n\0\0194\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\0\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\1\vsilent\2):LustyFilesystemExplorerFromHere<CR>\14<leader>l\6n\bmap$LustyExplorerAlwaysShowDotFiles!LustyExplorerDefaultMappings LustyJugglerDefaultMappings\6g\bvim\0" },
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
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/dap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-moonmaker"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-moonmaker"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugcfg/treesitter\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30plugcfg/nvim-web-devicons\frequire\0" },
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
  ["salt-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/salt-vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["vim-NotableFt"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-NotableFt"
  },
  ["vim-apathy"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-apathy"
  },
  ["vim-argwrap"] = {
    commands = { "ArgWrap" },
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugcfg/argwrap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-asterisk"] = {
    config = { "\27LJ\1\0024\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\25plugcfg/vim-asterisk\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    config = { "\27LJ\1\0024\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\25plugcfg/vim-dispatch\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugcfg/easyalign\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-esearch"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugcfg/esearch\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-esearch"
  },
  ["vim-fetch"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-fetch"
  },
  ["vim-flipdir"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-flipdir"
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
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\1\0023\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\24plugcfg/vim-matchup\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-matchup"
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
  ["vim-packager"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-packager"
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
  ["vim-puppet"] = {
    after_files = { "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-puppet/after/plugin/gutentags.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-puppet"
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
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugcfg/vim-rooter\frequire\0" },
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-rooter"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tridactyl"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-tridactyl"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-wordy"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-wordy"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vimpeccable"
  },
  vimwiki = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugcfg/vimwiki\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vimwiki"
  },
  ["vista.vim"] = {
    config = { "\27LJ\1\2-\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\18plugcfg/vista\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vista.vim"
  },
  ["winteract.vim"] = {
    commands = { "InteractiveWindow" },
    config = { "\27LJ\1\0023\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\24plugcfg/wininteract\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/winteract.vim"
  }
}

-- Config for: nvim-treesitter
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugcfg/treesitter\frequire\0", "config", "nvim-treesitter")
-- Config for: nvim-web-devicons
try_loadstring("\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30plugcfg/nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
-- Config for: fzf-mru.vim
try_loadstring("\27LJ\1\2.\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\19plugcfg/fzfmru\frequire\0", "config", "fzf-mru.vim")
-- Config for: ale
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/ale\frequire\0", "config", "ale")
-- Config for: coc.nvim
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/coc\frequire\0", "config", "coc.nvim")
-- Config for: vim-asterisk
try_loadstring("\27LJ\1\0024\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\25plugcfg/vim-asterisk\frequire\0", "config", "vim-asterisk")
-- Config for: vim-esearch
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugcfg/esearch\frequire\0", "config", "vim-esearch")
-- Config for: vim-easy-align
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugcfg/easyalign\frequire\0", "config", "vim-easy-align")
-- Config for: vim-matchup
try_loadstring("\27LJ\1\0023\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\24plugcfg/vim-matchup\frequire\0", "config", "vim-matchup")
-- Config for: fzf
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugcfg/fzf\frequire\0", "config", "fzf")
-- Config for: vim-rooter
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23plugcfg/vim-rooter\frequire\0", "config", "vim-rooter")

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file InteractiveWindow lua require("packer.load")({'winteract.vim'}, { cmd = "InteractiveWindow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file LustyFilesystemExplorerFromHere lua require("packer.load")({'lusty'}, { cmd = "LustyFilesystemExplorerFromHere", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilToggle lua require("packer.load")({'vim-pencil'}, { cmd = "PencilToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilSoft lua require("packer.load")({'vim-pencil'}, { cmd = "PencilSoft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilHard lua require("packer.load")({'vim-pencil'}, { cmd = "PencilHard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Pencil lua require("packer.load")({'vim-pencil'}, { cmd = "Pencil", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType wiki ++once lua require("packer.load")({'vimwiki'}, { ft = "wiki" }, _G.packer_plugins)]]
vim.cmd [[au FileType sls ++once lua require("packer.load")({'salt-vim'}, { ft = "sls" }, _G.packer_plugins)]]
vim.cmd [[au FileType gpg ++once lua require("packer.load")({'vim-gnupg'}, { ft = "gpg" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'ansible-vim'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType pp ++once lua require("packer.load")({'vim-puppet'}, { ft = "pp" }, _G.packer_plugins)]]
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim/ftdetect/ansible.vim]]
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/salt-vim/ftdetect/sls.vim]]
vim.cmd [[source /home/neg/.local/share/nvim/site/pack/packer/opt/vim-puppet/ftdetect/puppet.vim]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry

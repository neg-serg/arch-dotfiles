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
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["ansible-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc-fzf"
  },
  ["coc.nvim"] = {
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
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-mru.vim"] = {
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
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
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
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-argwrap"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-esearch"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-esearch"
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
    loaded = false,
    needs_bufread = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vimwiki"
  },
  ["vista.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vista.vim"
  },
  ["winteract.vim"] = {
    commands = { "InteractiveWindow" },
    loaded = false,
    needs_bufread = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/winteract.vim"
  }
}


-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file InteractiveWindow lua require("packer.load")({'winteract.vim'}, { cmd = "InteractiveWindow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Pencil lua require("packer.load")({'vim-pencil'}, { cmd = "Pencil", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file ArgWrap lua require("packer.load")({'vim-argwrap'}, { cmd = "ArgWrap", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilToggle lua require("packer.load")({'vim-pencil'}, { cmd = "PencilToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilSoft lua require("packer.load")({'vim-pencil'}, { cmd = "PencilSoft", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file PencilHard lua require("packer.load")({'vim-pencil'}, { cmd = "PencilHard", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

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

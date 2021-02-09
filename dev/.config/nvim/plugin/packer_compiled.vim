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
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["ansible-vim"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/ansible-vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["coc-fzf"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc-fzf"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  ["committia.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/committia.vim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
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
  ["gina.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  indentLine = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/indentLine"
  },
  lusty = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/lusty"
  },
  neg = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/neg"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/rainbow"
  },
  ["salt-vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/salt-vim"
  },
  ["searchReplace.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/searchReplace.vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  tcomment_vim = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/tcomment_vim"
  },
  ["todoist.nvim"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/todoist.nvim"
  },
  ["vim-NotableFt"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-NotableFt"
  },
  ["vim-ansible-vault"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-ansible-vault"
  },
  ["vim-apathy"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-apathy"
  },
  ["vim-argwrap"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-argwrap"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-better-whitespace"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-dispatch"
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
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-gnupg"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-hexokinase"
  },
  ["vim-markdown"] = {
    loaded = false,
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
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-mundo"
  },
  ["vim-packager"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-packager"
  },
  ["vim-pencil"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-pencil"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-puppet"] = {
    loaded = false,
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
  ["vim-subversive"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-syntax-extra"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/vim-syntax-extra"
  },
  ["vim-tridactyl"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-tridactyl"
  },
  ["vim-wordy"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vim-wordy"
  },
  vimwiki = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vimwiki"
  },
  ["vista.vim"] = {
    loaded = false,
    path = "/home/neg/.local/share/nvim/site/pack/packer/opt/vista.vim"
  },
  ["winteract.vim"] = {
    loaded = true,
    path = "/home/neg/.local/share/nvim/site/pack/packer/start/winteract.vim"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry

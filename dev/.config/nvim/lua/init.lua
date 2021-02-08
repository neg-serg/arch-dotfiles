local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
require '00-plugins'
require '01-settings'
require '02-bindings'
require '04-aucmds'
require '08-cmds'
require '14-abbr'
require '21-lang'
require '62-sort-operator'

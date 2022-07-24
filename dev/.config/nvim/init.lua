require'filetype_nvim'

require'00-settings'
require'01-helpers'
if vim.g.plugin_operations then
    require'01-plugins'
end
require'02-bindings'
require'04-aucmds'
require'08-cmds'
require'14-abbr'
require'21-lang'
require'62-sort-operator'
require'packer_compiled'

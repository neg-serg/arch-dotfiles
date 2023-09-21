if vim.fn.has("nvim-0.8.1") ~= 1 then
    -- Check version, thx to doom-neovim
    local message = table.concat({"You are using an unsupported version of Neovim."}, "\n")
    vim.notify(message, vim.log.levels.ERROR)
end
require'filetype_nvim'
require'00-settings'
require'01-helpers'
require'01-plugins'
require'02-bindings'
require'04-aucmds'
require'08-cmds'
require'14-abbr'
require'21-lang'
require'62-sort-operator'

function _G.map(mod, lhs, rhs, opt)
    vim.api.nvim_set_keymap(mod, lhs, rhs, opt or {})
end
_G.Map=_G.vim.keymap.set
local M = {}
return M

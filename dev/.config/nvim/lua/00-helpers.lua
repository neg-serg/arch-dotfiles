local o = vim.o
local g = vim.g
local a = vim.api

function _G.nvim_set_au(au_type, where, dispatch)
    vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end

function _G.map(mod, lhs, rhs, opt)
    a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local o = vim.o
local g = vim.g
local a = vim.api
api = vim.api

function _G.nvim_set_au(au_type, where, dispatch)
    vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end

function _G.map(mod, lhs, rhs, opt)
    a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

local M = {}

function M.sudo_exec(cmd, print_output)
    -- vim.api_nvim_set_keymap('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })
    local password = vim.fn.inputsecret("Password: ")
    if not password or #password == 0 then
        M.warn("Invalid password, sudo aborted")
        return false
    end
    local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
    if vim.v.shell_error ~= 0 then
        print("\r\n")
        M.err(out)
        return false
    end
    if print_output then print("\r\n", out) end
    return true
end

 function M.sudo_write(tmpfile, filepath)
    if not tmpfile then tmpfile = vim.fn.tempname() end
    if not filepath then filepath = vim.fn.expand("%") end
    if not filepath or #filepath == 0 then
        M.err("E32: No file name")
        return
    end
    -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
    -- Both `bs=1M` and `bs=1m` are non-POSIX
    local cmd = string.format("dd if=%s of=%s bs=1048576",
        vim.fn.shellescape(tmpfile),
        vim.fn.shellescape(filepath))
    -- no need to check error as this fails the entire function
    vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
    if M.sudo_exec(cmd) then
        M.info(string.format('\r\n"%s" written', filepath))
        vim.cmd("e!")
    end
    vim.fn.delete(tmpfile)
end

return M

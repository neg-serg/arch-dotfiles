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

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

-- For autocommands, extracted from https://github.com/norcalli/nvim_utils
function _G.create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		Execute('augroup ' .. group_name)
		Execute('autocmd!')
		for _, def in ipairs(definition) do
			local command =
				table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
			Execute(command)
		end
		Execute('augroup END')
	end
end

function _G.reload(package)
    package.loaded[package] = nil
    return require(package)
end

local M = {}

M._if = function(bool, a, b)
    if bool then
        return a
    else
        return b
    end
end

function M._echo_multiline(msg)
    for _, s in ipairs(vim.fn.split(msg, "\n")) do
        vim.cmd("echom '" .. s:gsub("'", "''").."'")
    end
end

function M.info(msg)
    vim.cmd('echohl Directory')
    M._echo_multiline(msg)
    vim.cmd('echohl None')
end

function M.warn(msg)
    vim.cmd('echohl WarningMsg')
    M._echo_multiline(msg)
    vim.cmd('echohl None')
end

function M.err(msg)
    vim.cmd('echohl ErrorMsg')
    M._echo_multiline(msg)
    vim.cmd('echohl None')
end

function M.has_neovim_v05()
    if vim.fn.has('nvim-0.5') == 1 then
        return true
    end
    return false
end

function M.is_root()
    local output = vim.fn.systemlist "id -u"
    return ((output[1] or "") == "0")
end

function M.shell_error()
    return vim.v.shell_error ~= 0
end

function M.shell_type(file)
    vim.fn.system(string.format("type '%s'", file))
    if vim.v.shell_error ~= 0 then return false
    else return true end
end

function M.is_git_repo()
    vim.fn.system("git status")
    return M._if(M.shell_error(), false, true)
end

-- Can also use #T ?
function M.tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- taken from:
-- https://www.reddit.com/r/neovim/comments/o1byad/what_lua_code_do_you_have_to_enhance_neovim/
--
-- tmux like <C-b>z: focus on one buffer in extra tab
-- put current window in new tab with cursor restored
function M.tabedit()
    -- skip if there is only one window open
    if vim.tbl_count(vim.api.nvim_tabpage_list_wins(0)) == 1 then
        print('Cannot expand single buffer')
        return
    end
    local buf = vim.api.nvim_get_current_buf()
    local view = vim.fn.winsaveview()
    -- note: tabedit % does not properly work with terminal buffer
    vim.cmd [[tabedit]]
    -- set buffer and remove one opened by tabedit
    local tabedit_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_delete(tabedit_buf, {force = true})
    -- restore original view
    vim.fn.winrestview(view)
end

-- restore old view with cursor retained
function M.tabclose()
    local buf = vim.api.nvim_get_current_buf()
    local view = vim.fn.winsaveview()
    vim.cmd [[tabclose]]
    -- if we accidentally land somewhere else, do not restore
    local new_buf = vim.api.nvim_get_current_buf()
    if buf == new_buf then vim.fn.winrestview(view) end
end

-- expand or minimize current buffer in a more natural direction (tmux-like)
-- ':resize <+-n>' or ':vert resize <+-n>' increases or decreasese current
-- window horizontally or vertically. When mapped to '<leader><arrow>' this
-- can get confusing as left might actually be right, etc
-- the below can be mapped to arrows and will work similar to the tmux binds
-- map to: "<cmd>lua require'utils'.resize(false, -5)<CR>"
function M.resize(vertical, margin)
    local cur_win = vim.api.nvim_get_current_win()
    -- go (possibly) right
    vim.cmd(string.format('wincmd %s', vertical and 'l' or 'j'))
    local new_win = vim.api.nvim_get_current_win()

    -- determine direction cond on increase and existing right-hand buffer
    local not_last = not (cur_win == new_win)
    local sign = margin > 0
    -- go to previous window if required otherwise flip sign
    if not_last == true then
        vim.cmd [[wincmd p]]
    else
        sign = not sign
    end

    sign = sign and '+' or '-'
    local dir = vertical and 'vertical ' or ''
    local cmd = dir .. 'resize ' .. sign .. math.abs(margin) .. '<CR>'
    vim.cmd(cmd)
end

function M.sudo_exec(cmd, print_output)
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

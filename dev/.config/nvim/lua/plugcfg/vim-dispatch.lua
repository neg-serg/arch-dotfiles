local a = vim.api
local function nvim_set_au(au_type, where, dispatch)
    vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end
local function map(mod, lhs, rhs, opt)
    a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ tpope/vim-dispatch.git                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
map('n', 'MK', ':Make -j9')
map('n', 'MC', ':Make clean<cr>')
map('n', '[QLeader]cc', ':Make -j10<cr>')
map('n', '[QLeader]mc', ':Make distclean<cr>')

local a = vim.api
local function nvim_set_au(au_type, where, dispatch)
    vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end
local function map(mod, lhs, rhs, opt)
    a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ haya14busa/vim-asterisk                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
map('n', '*',   '<Plug>(asterisk-#)')
map('n', '#',   '<Plug>(asterisk-*)')
map('n', 'g*',  '<Plug>(asterisk-g#)')
map('n', 'g#',  '<Plug>(asterisk-g*)')
map('n', 'z*',  '<Plug>(asterisk-z#)')
map('n', 'gz*', '<Plug>(asterisk-gz#)')
map('n', 'z#',  '<Plug>(asterisk-z*)')
map('n', 'gz#', '<Plug>(asterisk-gz*)')

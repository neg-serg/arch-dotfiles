-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ cappyzawa/trim.nvim                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require'trim'.setup{
    ft_blocklist = {"markdown"},
    trim_on_write = false,
    trim_last_line = false,
    trim_first_line = false,
}

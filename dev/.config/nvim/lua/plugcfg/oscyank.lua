-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ojroques/vim-oscyank                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.api.nvim_exec([[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
]], true)

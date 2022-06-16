-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ FooSoft/vim-argwrap                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-argwrap"] then
    api.nvim_command('nnoremap <silent> <leader>a :ArgWrap<CR>')
end

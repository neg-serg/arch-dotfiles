-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ tpope/vim-dispatch.git                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-dispatch.git"] and _G.packer_plugins["vim-dispatch.git"].loaded then
    map('n', 'MK', ':Make -j9')
    map('n', 'MC', ':Make clean<cr>')
    map('n', '[QLeader]cc', ':Make -j10<cr>')
    map('n', '[QLeader]mc', ':Make distclean<cr>')
end

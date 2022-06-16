-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ junegunn/vim-easy-align                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-easy-align"] and _G.packer_plugins["vim-easy-align"].loaded then
    map('n', 'ga', '<Plug>(EasyAlign)')
    map('x', 'ga', '<Plug>(EasyAlign)')
end

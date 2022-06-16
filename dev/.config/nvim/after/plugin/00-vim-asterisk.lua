-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ haya14busa/vim-asterisk                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-asterisk"] and _G.packer_plugins["vim-asterisk"].loaded then
    map('n', '*',   '<Plug>(asterisk-#)')
    map('n', '#',   '<Plug>(asterisk-*)')
    map('n', 'g*',  '<Plug>(asterisk-g#)')
    map('n', 'g#',  '<Plug>(asterisk-g*)')
    map('n', 'z*',  '<Plug>(asterisk-z#)')
    map('n', 'gz*', '<Plug>(asterisk-gz#)')
    map('n', 'z#',  '<Plug>(asterisk-z*)')
    map('n', 'gz#', '<Plug>(asterisk-gz*)')
end

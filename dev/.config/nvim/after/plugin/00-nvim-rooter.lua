-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ notjedi/nvim-rooter.lua                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-rooter.lua"] and _G.packer_plugins["nvim-rooter.lua"].loaded then
    require('nvim-rooter').setup {
        rooter_patterns = {'.git', '.hg', '.svn'},
        trigger_patterns = {'*'},
        manual = false,
    }
end

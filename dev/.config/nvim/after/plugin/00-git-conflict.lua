-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ akinsho/git-conflict.nvim                                                    │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["git-conflict.nvim"] and _G.packer_plugins["git-conflict.nvim"].loaded then
    require('git-conflict').setup()
end

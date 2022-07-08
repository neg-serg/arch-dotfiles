-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neg-serg/neg                                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["neg.nvim"] and _G.packer_plugins["neg.nvim"].loaded then
    require("neg").colorscheme()
end

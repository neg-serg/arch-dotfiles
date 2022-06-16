-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ numToStr/Comment.nvim                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["Comment.nvim"] and _G.packer_plugins["Comment.nvim"].loaded then
    require('Comment').setup()
end

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ antoinemadec/FixCursorHold.nvim                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["FixCursorHold.nvim"] and _G.packer_plugins["FixCursorHold.nvim"].loaded then
    vim.g.cursorhold_updatetime = 100
end

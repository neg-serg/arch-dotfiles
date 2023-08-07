-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ L3MON4D3/LuaSnip                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, vscode_snips = pcall(require, 'luasnip.loaders.from_vscode')
if (not status) then return end
vscode_snips.lazy_load()

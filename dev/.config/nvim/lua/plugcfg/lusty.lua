-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │  █▓▒░ sjbach/lusty.git                                                            │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.LustyJugglerDefaultMappings = 0
vim.g.LustyExplorerDefaultMappings = 0
vim.g.LustyExplorerAlwaysShowDotFiles = 1
map('n', '<leader>l', ':packadd lusty<CR>:LustyFilesystemExplorerFromHere<CR>', {silent=true})

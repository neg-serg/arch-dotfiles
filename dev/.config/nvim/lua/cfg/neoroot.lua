-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nyngwang/NeoRoot.lua                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require('neo-root').setup {
  CUR_MODE = 1 -- 1 for file/buffer mode, 2 for proj-mode
}
vim.cmd'au BufWinEnter * NeoRoot'
map('n', '<leader>r', function() vim.cmd('NeoRootSwitchMode') end, {})
map('n', '<leader>R', function() vim.cmd('NeoRootChange') end, {})

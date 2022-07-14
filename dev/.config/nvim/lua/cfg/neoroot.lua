-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nyngwang/NeoRoot.lua                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require('neo-root').setup {
  CUR_MODE = 1 -- 1 for file/buffer mode, 2 for proj-mode
}
vim.cmd'au BufWinEnter * NeoRoot'
vim.keymap.set('n', '<Space>r', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
vim.keymap.set('n', '<Space>R', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)

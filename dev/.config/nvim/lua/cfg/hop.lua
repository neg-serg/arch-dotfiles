-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ phaazon/hop.nvim                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, hop = pcall(require, 'hop')
if (not status) then return end
map('n', '<Space>', '<cmd>HopLineStart<cr>')
map('n', 'F', '<cmd>HopChar2<cr>')
hop.setup({keys = 'wersdfa'})
local hi = vim.api.nvim_set_hl

hi(0, 'HopNextKey', {bg = '', fg = '#367cb0'})
hi(0, 'HopNextKey1', {bg = '', fg='#496280'})
hi(0, 'HopNextKey2', {bg = '', fg='#6d839e'})
hi(0, 'HopUnmatched', {bg='NONE', fg='#546c8a'})
hi(0, 'HopCursor', {link = 'Normal'})
hi(0, 'HopPreview', {link = 'Constant'})

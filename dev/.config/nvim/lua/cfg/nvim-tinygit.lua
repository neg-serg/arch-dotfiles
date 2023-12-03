vim.keymap.set('n', 'ga', '<cmd>Gitsigns add_hunk<CR>') -- gitsigns.nvim
vim.keymap.set('n', 'gc', function() require('tinygit').smartCommit() end)
vim.keymap.set('n', 'gp', function() require('tinygit').push() end)

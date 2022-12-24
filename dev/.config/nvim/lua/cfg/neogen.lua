local status, neogen = pcall(require, 'neogen')
if (not status) then return end
vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('neogen').generate()<CR>", {noremap=true, silent=true})
neogen.setup{}

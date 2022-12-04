vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('neogen').generate()<CR>", {noremap=true, silent=true})
require('neogen').setup{}

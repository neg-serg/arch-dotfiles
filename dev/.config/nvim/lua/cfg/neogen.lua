vim.api.nvim_set_keymap("n", "<Leader>f", ":lua require('neogen').generate()<CR>", {noremap=true, silent=true})
require('neogen').setup {}

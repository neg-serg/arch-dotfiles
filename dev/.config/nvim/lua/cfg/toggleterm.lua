require("toggleterm").setup()
local Terminal=require('toggleterm.terminal').Terminal
navigator=Terminal:new({cmd="zsh", env={NEOVIM_TERMINAL=1}})
vim.api.nvim_set_keymap("n", "<leader>l", "<Cmd>lua navigator:toggle()<CR>", {noremap=true, silent=true})

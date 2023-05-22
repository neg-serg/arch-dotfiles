require'lspsaga'.setup{
    ui={
        title=false, -- This option only works in Neovim 0.9
        border="single", -- Border type can be single, double, rounded, solid, shadow.
        winblend=0,
        expand="",
        collapse="",
        code_action="💡",
        incoming=" ",
        outgoing=" ",
        hover=' ',
        kind={},
}}
local map=vim.keymap.set
map("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>")
map({"n","v"}, "<leader>ca", "<Cmd>Lspsaga code_action<CR>")
map("n", "gr", "<Cmd>Lspsaga rename<CR>")
map("n", "gr", "<Cmd>Lspsaga rename ++project<CR>")
map("n", "gp", "<Cmd>Lspsaga peek_definition<CR>")
map("n", "gd", "<Cmd>Lspsaga goto_definition<CR>")
map("n", "gt", "<Cmd>Lspsaga peek_type_definition<CR>")
map("n", "gt", "<Cmd>Lspsaga goto_type_definition<CR>")
map("n", "[e", "<Cmd>Lspsaga diagnostic_jump_prev<CR>")
map("n", "]e", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "[E", function() require'lspsaga.diagnostic':goto_prev({severity=vim.diagnostic.severity.ERROR}) end)
map("n", "]E", function() require'lspsaga.diagnostic':goto_next({severity=vim.diagnostic.severity.ERROR}) end)
map("n", "<leader>o", "<Cmd>Lspsaga outline<CR>")
map("n", "K", "<Cmd>Lspsaga hover_doc<CR>")
map("n", "K", "<Cmd>Lspsaga hover_doc ++keep<CR>")
map("n", "<leader>ci", "<Cmd>Lspsaga incoming_calls<CR>")
map("n", "<leader>co", "<Cmd>Lspsaga outgoing_calls<CR>")

map('i', '<C-j>', '<ESC>', {nowait = true})
map('v', '<C-j>', '<ESC>', {nowait = true})
map('n', '<C-j>', '<C-w>j', {nowait = true})
map('n', '<C-k>', '<C-w>k', {nowait = true})
map('n', '<C-l>', '<C-w>l', {nowait = true})
map('n', '<C-h>', '<C-w>h', {nowait = true})
map('n', 'q', '<NOP>')
map('n', 'Q', '<NOP>')
map('n', '<F1>', '')
map('i', '<F1>', '')

-- Escape as normal
map('t', '<Esc>', '<C-\\><C-n>', {silent=true})
map('n', '<Tab>', ':bn<CR>', {silent=true})
map('n', '<S-Tab>', ':bp<CR>', {silent=true})
map('n', '<leader><Tab>', ':b#<CR>', {silent=true})

-- Don't use arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

map('n', '_', "<Cmd>exe 'e ' . getcwd()<CR>")
map('n', '<M-b>', '<Cmd>Telescope buffers<CR>')
map('n', '<M-f>', '<Cmd>Telescope live_grep<CR>')
map('n', '<M-C-o>', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
map('n', '<M-o>', '<Cmd>Telescope lsp_document_symbols<CR>')
map('n', '<M-d>', '<Cmd>Telescope lsp_document_diagnostics<CR>')

map('n', '[Qleader]n', ':normal :<C-u>cnext<CR>', {silent=true})
map('n', '[Qleader]p', ':normal :<C-u>cprevious<CR>', {silent=true})
map('n', '[Qleader]R', ':normal :<C-u>crewind<CR>', {silent=true})
map('n', '[Qleader]N', ':normal :<C-u>cfirst<CR>', {silent=true})
map('n', '[Qleader]P', ':normal :<C-u>clast<CR>', {silent=true})
map('n', '[Qleader]l', ':normal :<C-u>clist<CR>', {silent=true})
map('n', '[Qleader]w', ':w!<cr>', {silent=true})
map('n', '[Qleader]W', ':SudoWrite<cr>', {silent=true})
-- Fix for floating windows
map('n', '<C-c>', '<C-[>')
map('i', '<C-c>', '<C-[>')
-- These create newlines like o and O but stay in normal mode
map('n', 'zJ', 'o<Esc>k', {silent=true})
map('n', 'zK', 'O<Esc>j', {silent=true})
-- Toggle hlsearch for current results, start highlight
map('n', ',,', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<CR><C-l>')
-- Visual shifting (does not exit Visual mode)
map('v', '<', '<gv')
map('v', '>', '>gv')
map('n', '<C-g>', 'g<C-g>')
-- Easier to type, and I never use the default behavior.
map('n', 'H', '^')
map('n', 'L', 'g_')
map('n', 'e', '[Qleader]')
-- Swap implementations of ` and ' jump to markers
-- By default, ' jumps to the marked line, ` jumps to the marked line and
-- column, so swap them
map('n', "'", "`")
map('n', "`", "'")
-- like firefox tabs
map('n', '<M-w>', ':bd<CR>', {silent=true})
map('i', '<C-V>', '<C-R>+')
vim.g.mapleader = ','
map('n', "<leader>.", "<Cmd>lua require'plugcfg/telescope';require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy({layout_config = {height = 8}, border=false}))<CR>", {noremap=true, silent=true})
map('c', '<C-a>', '<home>', {noremap=true})
map('c', '<C-b>', '<left>', {noremap=true})
map('c', '<C-n>', '<down>', {noremap=true})
map('c', '<C-p>', '<up>', {noremap=true})
map('c', '<C-d>', '<Del>', {noremap=true})
map('c', '<M-f>', '<S-Right>', {noremap=true})
map('i', '<C-d>', '<Del>', {noremap=true})
map('i', '<C-b>', '<left>', {noremap=true})
map('i', '<C-f>', '<right>', {noremap=true})
map('i', '<C-u>', '<C-o>:ISwap<CR>', {noremap=true})
map('i', '<M-b>', '<S-Left>', {noremap=true})
map('i', '<M-d>', '<C-o>dw', {noremap=true})
map('i', '<M-f>', '<C-o>e<Right>', {noremap=true})
map('o', '<M-b>', '<Left>', {noremap=true})
map('o', '<M-e>', '<End>', {noremap=true})
map('o', '<M-f>', '<C-o>e<Right>', {noremap=true})
map('i', '<C-a>', "<C-o>^", {noremap=true})
map('i', '<C-e>', "<C-o>$", {noremap=true})
vim.cmd('nnoremap <expr> G &wrap ? "G$g0" : "G"')
vim.cmd('nnoremap <expr> 0 &wrap ? "g0" : "0"')
vim.cmd('nnoremap <expr> $ &wrap ? "g$" : "$"')
vim.cmd('nnoremap <expr> j (v:count == 0 ? "gj" : "j")')
vim.cmd('nnoremap <expr> k (v:count == 0 ? "gk" : "k")')
map('i', '<C-v>', 'paste#paste_cmd["i"]', {expr=true})
map('v', '<C-v>', 'paste#paste_cmd["v"]', {expr=true})
-- thx to ralismark.xyz/2020/08/29/how-i-use-vim-1.html
-- Fixed I/A for visual
vim.api.nvim_exec([[
    xnoremap <expr> I mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"
    xnoremap <expr> A mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"
]], true)
map('n', '<leader>l', ':new +resize8 term://NEOVIM_TERMINAL=1 zsh<CR>', {silent=true, noremap=true})
map('n', '[Qleader]e', "<Cmd>lua require'plugcfg/telescope';require('telescope.builtin').find_files{}<CR>", {silent=true, noremap=true})
map('n', '[Qleader]f', "<Cmd>lua require'plugcfg/telescope';require('telescope.builtin').live_grep{}<CR>", {silent=true, noremap=true})
map('n', '[Qleader]c', "<Cmd>lua require'plugcfg/telescope';require('telescope.builtin').git_commits{}<CR>", {silent=true, noremap=true})
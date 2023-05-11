map('i', '<C-j>', '<ESC>', {nowait = true})
map('v', '<C-j>', '<ESC>', {nowait = true})
map('n', '<C-j>', '<C-w>j', {nowait = true})
map('n', '<C-k>', '<C-w>k', {nowait = true})
map('n', '<C-l>', '<C-w>l', {nowait = true})
map('n', '<C-h>', '<C-w>h', {nowait = true})

map('n', '_', "<Cmd>exe 'e ' . getcwd()<CR>")

map('n', 'q', '<NOP>')
map('n', 'Q', '<NOP>')
map('', '<F1>', '<NOP>')

-- Escape as normal
map('t', '<Esc>', '<C-\\><C-n>', {silent=true})

-- Don't use arrow keys
map('', '<up>', '<NOP>')
map('', '<down>', '<NOP>')
map('', '<left>', '<NOP>')
map('', '<right>', '<NOP>')

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
map('c', '<C-a>', '<home>', {noremap=true})
map('c', '<C-b>', '<left>', {noremap=true})
map('c', '<C-n>', '<down>', {noremap=true})
map('c', '<C-p>', '<up>', {noremap=true})
map('c', '<C-d>', '<Del>', {noremap=true})
map('c', '<M-f>', '<S-Right>', {noremap=true})
map('i', '<C-d>', '<Del>', {noremap=true})
map('i', '<C-b>', '<left>', {noremap=true})
map('i', '<C-f>', '<right>', {noremap=true})
map('i', '<M-b>', '<S-Left>', {noremap=true})
map('i', '<M-d>', '<C-o>dw', {noremap=true})
map('i', '<M-f>', '<C-o>e<Right>', {noremap=true})
map('o', '<M-b>', '<Left>', {noremap=true})
map('o', '<M-e>', '<End>', {noremap=true})
map('o', '<M-f>', '<C-o>e<Right>', {noremap=true})
map('i', '<C-a>', "<C-o>^", {noremap=true})
map('i', '<C-e>', "<C-o>$", {noremap=true})
map('i', '<C-v>', 'paste#paste_cmd["i"]', {expr=true})
map('v', '<C-v>', 'paste#paste_cmd["v"]', {expr=true})
-- Navigate buffers, thx to nvim-basic-ide
map('n', '<S-l>', ':bnext<CR>', {silent=true})
map('n', '<S-h>', ':bprevious<CR>', {silent=true})

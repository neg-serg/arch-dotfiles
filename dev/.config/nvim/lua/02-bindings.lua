local o = vim.o
local g = vim.g
local a = vim.api

map('i', '<C-j>', '<ESC>', {nowait = true})
map('v', '<C-j>', '<ESC>', {nowait = true})
map('n', '<C-j>', '<C-w>j', {nowait = true})
map('n', '<C-k>', '<C-w>k', {nowait = true})
map('n', '<C-l>', '<C-w>l', {nowait = true})
map('n', '<C-h>', '<C-w>h', {nowait = true})
map('n', '<Space><Space>', '<C-^>')
map('n', 'q', '<NOP>')
map('n', 'Q', 'q')
map('n', '<F1>', '')
map('i', '<F1>', '')

-- Escape as normal
map('t', '<Esc>', '<C-\\><C-n>', {silent=true})
map('n', '<Tab>', ':bn<CR>', {silent=true})
map('n', '<S-Tab>', ':bp<CR>', {silent=true})
map('n', '<leader><Tab>', ':b#<CR>', {silent=true})

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
map('n', 'K', ":call CocActionAsync('doHover')<CR>", {silent=true})
vim.g.mapleader = ','
map('n', 'Y', 'y$')
map('n', 'w', 'W', {noremap=true})
map('n', 'W', 'w', {noremap=true})
map('o', 'w', 'W', {noremap=true})
map('o', 'W', 'w', {noremap=true})
map('x', 'w', 'W', {noremap=true})
map('x', 'W', 'w', {noremap=true})
map('n', 'b', 'B', {noremap=true})
map('n', 'B', 'b', {noremap=true})
map('o', 'b', 'B', {noremap=true})
map('o', 'B', 'b', {noremap=true})
map('x', 'b', 'B', {noremap=true})
map('x', 'B', 'b', {noremap=true})
map('n', "<leader>.", "<Cmd>lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy({layout_config = {height = 8}, border=false}))<CR>", {noremap=true, silent=true})
vim.cmd('nnoremap <expr> G &wrap ? "G$g0" : "G"')
vim.cmd('nnoremap <expr> 0 &wrap ? "g0" : "0"')
vim.cmd('nnoremap <expr> $ &wrap ? "g$" : "$"')
vim.cmd('nnoremap <expr> j (v:count == 0 ? "gj" : "j")')
vim.cmd('nnoremap <expr> k (v:count == 0 ? "gk" : "k")')
map('n', '<leader>l', ':LustyFilesystemExplorerFromHere<CR>', {silent=true})
vim.api.nvim_exec([[
    exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
]], true)
-- thx to ralismark.xyz/2020/08/29/how-i-use-vim-1.html
-- Fixed I/A for visual
vim.api.nvim_exec([[
    xnoremap <expr> I mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"
    xnoremap <expr> A mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"
]], true)
vim.cmd('cnoremap <C-a> <home>')
vim.cmd('cnoremap <C-b> <left>')
vim.cmd('cnoremap <C-e> <end>')
vim.cmd('cnoremap <C-n> <down>')
vim.cmd('cnoremap <C-p> <up>')
vim.cmd('cnoremap <C-d> <Del>')
vim.cmd('cnoremap <M-f> <S-Right>')
vim.cmd('inoremap <C-d> <Del>')
vim.cmd('inoremap <C-b> <left>')
vim.cmd('inoremap <C-f> <right>')
vim.cmd('inoremap <C-x>b <C-o>:Buffers<CR>')
vim.cmd('inoremap <M-b> <S-Left>')
vim.cmd('inoremap <M-d> <C-o>dw')
vim.cmd('inoremap <M-f> <C-o>e<Right>')
vim.cmd('inoremap <silent> <c-a> <esc>I')
vim.cmd('nnoremap <C-x>b <C-o>:Buffers<CR>')
vim.cmd('omap <M-b> <Left>')
vim.cmd('omap <M-e> <End>')
vim.cmd('onoremap <M-f> <C-o>e<Right>')
vim.cmd('inoremap <C-a> <C-o>^')
vim.cmd('inoremap <C-e> <C-o>$')
vim.cmd('nnoremap / /' .. '\\' ..'V')
-- -- Move in command line mode using hjkl
-- for b in [["<C-h>", "<left>"],
-- 	\ ["<C-j>", "<down>"],
-- 	\ ["<C-k>", "<up>"],
-- 	\ ["<C-l>", "<right>"],
-- 	\ ["<C-a>", "<Home>"],
-- 	\ ["<C-e>", "<End>"]]
--     execute('lnoremap ' . b[0] . ' ' . b[1])
--     execute('cnoremap ' . b[0] . ' ' . b[1])
--     " Warning: Unexpected behavior might ensue when it comes to closing
--     " completion menu because of <C-e>
--     execute('inoremap <expr> ' . b[0] . ' (pumvisible() ? "\<C-e>" : "") . "\' . b[1] . '"')
-- endfor

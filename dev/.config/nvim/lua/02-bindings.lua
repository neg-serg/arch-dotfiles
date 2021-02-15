local o = vim.o
local g = vim.g
local a = vim.api

map('', '<C-j>', '', { nowait = true })
map('i', '<C-j>', '<ESC>', { nowait = true })
map('v', '<C-j>', '<ESC>', { nowait = true })
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')
map('n', '<space><space>', '<c-^>')
map('n', 'q', '<NOP>')
map('n', 'Q', 'q')
map('n', '<F1>', '')
map('i', '<F1>', '')

-- Escape as normal
map('t', '<Esc>', '<C-\\><C-n>', {silent=true})
map('n', '<Tab>', ':bn<CR>', {silent=true})
map('n', '<S-Tab>', ':bp<CR>', {silent=true})
map('n', '<leader><Tab>', ':b#<CR>', {silent=true})
map('n', '<M-1>', ':b 1<CR>', {silent=true})
map('n', '<M-2>', ':b 2<CR>', {silent=true})
map('n', '<M-3>', ':b 3<CR>', {silent=true})
map('n', '<M-4>', ':b 4<CR>', {silent=true})
map('n', '<M-5>', ':b 5<CR>', {silent=true})

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
map('i', '<C-Space>', 'coc#refresh()', {silent=true})
map('i', '<CR>', 'complete_info()["selected"] != "-1" ? "<C-y>" : "<C-g>u<CR>"', {silent=true})
map('n', '<leader>d', '<Plug>(coc-diagnostic-prev)', {silent=true})
map('n', '<leader>s', '<Plug>(coc-diagnostic-next)', {silent=true})
map('n', 'gd', '<Plug>(coc-definition)', {silent=true})
map('n', 'gr', '<Plug>(coc-references)', {silent=true})
map('n', 'K', ":call CocActionAsync('doHover')<CR>", {silent=true})

local result = vim.api.nvim_exec(
[[
    let mapleader = ','
    let g:mapleader = ','
    nnoremap Y y$
    noremap <expr> G &wrap ? "G$g0" : "G"
    noremap <expr> 0 &wrap ? 'g0' : '0'
    noremap <expr> $ &wrap ? "g$" : "$"
    noremap <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <expr> k (v:count == 0 ? 'gk' : 'k')
    " thx to ralismark.xyz/2020/08/29/how-i-use-vim-1.html
    " Fixed I/A for visual
    xnoremap <expr> I mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"
    xnoremap <expr> A mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"
    exe 'inoremap <script> <C-v> <C-g>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-v> ' . paste#paste_cmd['v']
]],
true)

local o = vim.o
local g = vim.g
local a = vim.api
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
require 'plugins'

o.updatetime = 250
o.termguicolors = true
o.mouse= 'n' -- Enable mouse
o.ignorecase = true -- Ignore case
o.confirm = true -- Disable 'no write'
o.scrolloff = 1 -- Lines from the cursor
o.incsearch = true -- Move cursor during search
o.splitright = true -- Splits open on the right
o.splitbelow = true -- Splits open on the bottom
o.wildmenu = true -- Command line completion mode
o.wildmode = 'full' -- Command line completion mode
o.hlsearch = true -- Highlight search results (enforce)
o.showmatch = true -- Show matching brackets/parenthesis
o.showmode = false -- Do not output message on the bottom
o.inccommand = 'split' -- Show effects of command as you type in a split
o.clipboard = 'unnamedplus' -- Use system clipboard
o.shortmess = vim.o.shortmess .. 'c'

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local function map(mod, lhs, rhs, opt)
  a.nvim_set_keymap(mod, lhs, rhs, opt or {})
end

local function nvim_set_au(au_type, where, dispatch)
    vim.cmd(string.format("au! %s %s %s", au_type, where, dispatch))
end

vim.cmd "cabbrev W w"

map('', '<C-j>', '', { nowait = true })
map('i', '<C-j>', '<ESC>', { nowait = true })
map('v', '<C-j>', '<ESC>', { nowait = true })
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')
map('n', '<leader>v', ':noh<CR>', { silent=true })
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
map('n', '<Leader><Leader>', ':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<CR><C-l>')
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
-- cmap <C-V> <C-R>+
-- exe 'inoremap <script> <C-v> <C-g>u' . paste#paste_cmd['i']
-- exe 'vnoremap <script> <C-v> ' . paste#paste_cmd['v']

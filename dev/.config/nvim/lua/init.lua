require '01-plugins'
require '00-profile'
_, nvim_utils = pcall(require, "nvim_utils")
require '00-helpers'
require '00-settings'
require '02-bindings'
require '04-aucmds'
require '08-cmds'
require '14-abbr'
require '21-lang'
require '31-statusline'
require '62-sort-operator'
require '70-rsi'
require'plugcfg/gitsigns'

vim.cmd('nnoremap <C-Space> :ToggleTerm<CR>')
vim.cmd([[autocmd TermEnter term://*toggleterm#* tnoremap <silent><C-Space> <C-\><C-n>:exe v:count1 . "ToggleTerm"<CR>]])

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ eugen0329/vim-esearch                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
api.nvim_command('nmap <C-f>f <Plug>(esearch)')
api.nvim_command('map <C-f> <Plug>(esearch-prefill)')
vim.g.esearch = {}
-- Use regex matching with the smart case mode by default and avoid matching text-objects.
vim.g.esearch.default_mappings = 0
vim.g.esearch.regex = 'auto'
vim.g.esearch.textobj = 0
vim.g.esearch.adapter = 'rg'
vim.g.esearch.case = 'smart'
vim.g.esearch.win_contexts_syntax = 0
-- Set the initial pattern content using the highlighted search pattern (if
-- v:hlsearch is true), the last searched pattern or the clipboard content.
vim.g.esearch.prefill = {'hlsearch', 'clipboard'}
-- Open the search window in a vertical split and reuse it for all searches.
-- api.nvim_command([[let g:esearch.win_new = {-> esearch#buf#goto_or_open('[Search]', 'vnew') }]])
-- Redefine the default highlights (see :help highlight and :help esearch-appearance)
api.nvim_command('hi esearchHeader gui=bold')
api.nvim_command('hi link esearchStatistics esearchFilename')
api.nvim_command('hi link esearchFilename Label')
api.nvim_command('hi esearchMatch gui=underline,italic,bold guifg=#6C7E96 guibg=#002D59')


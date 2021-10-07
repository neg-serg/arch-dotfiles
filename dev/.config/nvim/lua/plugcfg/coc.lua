-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neoclide/coc.nvim                                                            │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.coc_status_warning_sign = ''
vim.g.coc_status_error_sign = ''
vim.g.coc_snippet_next = '<tab>'
api.nvim_command('inoremap <expr> <C-Space> pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "" : "<Space>"')
api.nvim_command('inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "" : <SID>check_back_space() ? "<TAB>" : coc#refresh()')
api.nvim_command('inoremap <expr> <S-Tab> pumvisible() ? "<C-n>" : "<S-Tab>"')
api.nvim_command([[
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])
api.nvim_command('nnoremap <leader>d <Cmd>Telescope coc diagnostics<CR>')
-- Remap keys for gotos
map('n', 'gD', '<Cmd>Telescope coc definitions<CR>', {silent=true})
map('n', 'gI', '<Cmd>Telescope coc implementations<CR>', {silent=true})
map('n', 'gR', '<Cmd>Telescope coc references<CR>', {silent=true})
map('n', '[Qleader]c', '<Plug>(coc-diagnostic-next)', {silent=true})
map('n', '[Qleader]C', '<Plug>(coc-diagnostic-prev)', {silent=true})
map('n', '<M-CR>', '<Plug>(coc-fix-current)', {silent=true})
-- Remap for rename current word
map('n', '[Qleader]r', '<Plug>(coc-rename)', {silent=true})
-- Remap keys for applying codeAction to the current buffer.
map('n', '[Qleader]ac', '<Plug>(coc-codeaction)', {silent=true})
-- Reformat command
vim.g.coc_global_extensions = {
  'coc-diagnostic',
  'coc-git',
  'coc-lists',
  'coc-prettier',
  'coc-pyright',
  'coc-snippets',
  'coc-solargraph',
  'coc-stylelint',
}
-- Map function and class text objects
-- Requires 'textDocument.documentSymbol' support from the language server.
api.nvim_command('xmap if <Plug>(coc-funcobj-i)')
api.nvim_command('omap if <Plug>(coc-funcobj-i)')
api.nvim_command('xmap af <Plug>(coc-funcobj-a)')
api.nvim_command('omap af <Plug>(coc-funcobj-a)')
api.nvim_command('xmap ic <Plug>(coc-classobj-i)')
api.nvim_command('omap ic <Plug>(coc-classobj-i)')
api.nvim_command('xmap ac <Plug>(coc-classobj-a)')
api.nvim_command('omap ac <Plug>(coc-classobj-a)')

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neoclide/coc.nvim                                                            │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.coc_status_warning_sign = ''
vim.g.coc_status_error_sign = ''
vim.g.coc_snippet_next = '<tab>'
api.nvim_command('inoremap <expr> <C-Space> pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "" : "<Space>"')
api.nvim_command('inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "" : <SID>check_back_space() ? "<TAB>" : coc#refresh()')
api.nvim_command([[
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])
api.nvim_command('inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"')
api.nvim_command('nnoremap <leader>d <Plug>(coc-diagnostic-prev)')
api.nvim_command('nnoremap <leader>s <Plug>(coc-diagnostic-next)')
-- Remap keys for gotos
map('n', 'gD', '<Plug>(coc-definition)', {silent=true})
map('n', 'gI', '<Plug>(coc-implementation)', {silent=true})
map('n', 'gR', '<Plug>(coc-references)', {silent=true})
map('n', '[Qleader]c', '<Plug>(coc-diagnostic-next)', {silent=true})
map('n', '[Qleader]C', '<Plug>(coc-diagnostic-prev)', {silent=true})
map('n', '<M-CR>', '<Plug>(coc-fix-current)', {silent=true})
-- Remap for rename current word
map('n', '[Qleader]r', '<Plug>(coc-rename)', {silent=true})
-- Reformat command
vim.g.coc_global_extensions = {
  'coc-calc',
  'coc-diagnostic',
  'coc-grammarly',
  'coc-lists',
  'coc-pairs',
  'coc-prettier',
  'coc-pyright',
  'coc-rust-analyzer',
  'coc-snippets',
  'coc-solargraph',
  'coc-stylelint',
  'coc-toml',
  'coc-yaml',
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
-- Remap keys for applying codeAction to the current buffer.
api.nvim_command('nmap <leader>ac  <Plug>(coc-codeaction)')
-- Apply AutoFix to problem on the current line.
api.nvim_command('nmap <leader>qf  <Plug>(coc-fix-current)')

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
api.nvim_command('nnoremap gd <Plug>(coc-definition)')
api.nvim_command('nnoremap gr <Plug>(coc-references)')
api.nvim_command("nnoremap K :call CocActionAsync('doHover')<CR>")
map('n', '[Qleader]c', '<Plug>(coc-diagnostic-next)', {silent=true})
map('n', '[Qleader]C', '<Plug>(coc-diagnostic-prev)', {silent=true})
map('n', '<M-CR>', '<Plug>(coc-fix-current)', {silent=true})
-- Remap keys for gotos
map('n', 'gd', '<Plug>(coc-definition)', {silent=true})
map('n', 'gi', '<Plug>(coc-implementation)', {silent=true})
map('n', 'gy', ':<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>', {silent=true})
map('n', 'gr', ':<C-u>CocCommand fzf-preview.CocReferences<CR>', {silent=true})
-- Remap for rename current word
map('n', '[Qleader]r', '<Plug>(coc-rename)', {silent=true})
-- Reformat command
vim.g.coc_global_extensions = {
  'coc-calc',
  'coc-diagnostic',
  'coc-git',
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
vim.api.nvim_exec([[
command! -nargs=0 Format :call CocAction('format')
]], true)

--[[ " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
 ]]

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
vim.api.nvim_exec([[
command! -nargs=0 Format :call CocAction('format')
let g:coc_global_extensions = ['coc-actions', 'coc-browser', 'coc-clangd', 'coc-diagnostic', 'coc-git', 'coc-json', 'coc-lists', 'coc-prettier', 'coc-python', 'coc-rust-analyzer', 'coc-snippets', 'coc-solargraph', 'coc-stylelint', 'coc-translator', 'coc-yaml']
]], true)

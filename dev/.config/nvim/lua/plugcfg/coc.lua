-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neoclide/coc.nvim                                                            │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.api.nvim_exec([[
inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]], true)
vim.g.coc_status_warning_sign = ''
vim.g.coc_status_error_sign = ''
vim.g.coc_snippet_next = '<tab>'
-- Use <c-space> to trigger completion.
map('i', '<expr>', '<C-space>', 'coc#refresh()', {silent=true})
-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
-- Coc only does snippet and additional edit on confirm.
map('i', '<cr>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', {silent=true})
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

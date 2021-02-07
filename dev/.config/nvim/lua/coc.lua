local M = {}
function M.setup()
    vim.fn.execute([[
        set hidden
        set nobackup
        set nowritebackup
        set cmdheight=2
        set updatetime=300
        set shortmess+=c
        set signcolumn=number

        fun! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <c-space> coc#refresh()
        inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        nmap <silent> <leader>d <Plug>(coc-diagnostic-prev)
        nmap <silent> <leader>s <Plug>(coc-diagnostic-next)
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gr <Plug>(coc-references)
        nnoremap <silent> K :call CocActionAsync('doHover')<CR>

        command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
    ]], "")
end
return M

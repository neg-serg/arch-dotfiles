" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Shougo/deoplete.nvim                                                     │
" │ https://github.com/Shougo/deoplete.nvim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('deoplete.nvim')
    if has("nvim")
        let g:deoplete#enable_at_startup = 1 
    endif
    let g:deoplete#ignore_sources      = {}
    let g:deoplete#omni#input_patterns = {}
    let g:deoplete#omni_patterns       = {}

    let g:deoplete#enable_at_startup     = 1
    let g:deoplete#enable_ignore_case    = 1
    let g:deoplete#enable_smart_case     = 1
    let g:deoplete#enable_camel_case     = 1
    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#max_abbr_width        = 0
    let g:deoplete#max_menu_width        = 0

    let g:deoplete#complete_method   = "complete"
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#max_list          = 500
    let g:deoplete#max_menu_width    = 8

    " java && jsp
    let g:deoplete#omni#input_patterns.java = [
                \'[^. \t0-9]\.\w*',
                \'[^. \t0-9]\->\w*',
                \'[^. \t0-9]\::\w*',
                \]
    let g:deoplete#omni#input_patterns.jsp = ['[^. \t0-9]\.\w*']

    " perl
    let g:deoplete#omni#input_patterns.perl = [
                \'[^. \t0-9]\.\w*',
                \'[^. \t0-9]\->\w*',
                \'[^. \t0-9]\::\w*',
                \]

    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
    set isfname-==

    " deoplete tab-complete
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
    inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<Tab>"
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - davidhalter/jedi-vim.git                                                 │
" │ https://github.com/davidhalter/jedi-vim.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('jedi-vim')
    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#usages_command = "<leader>z"
    function! s:jedi_settings()
        nnoremap <buffer><leader>r :<C-u>call jedi#rename()<CR>
        nnoremap <buffer><leader>g :<C-u>call jedi#goto_assignments()<CR>
        nnoremap <buffer><leader>d :<C-u>call jedi#goto_definitions()<CR>
        nnoremap <buffer>K :<C-u>call jedi#show_documentation()<CR>
        nnoremap <buffer><leader>u :<C-u>call jedi#usages()<CR>
        nnoremap <buffer><leader>i :<C-u>Pyimport<leader>
        setlocal omnifunc=jedi#completions
        command! -nargs=0 JediRename call jedi#rename()
    endfunction
    autocmd Filetype python call <SID>jedi_settings()
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - majutsushi/tagbar.git                                                    │
" │ https://github.com/majutsushi/tagbar.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('tagbar')
    nnoremap <silent> <leader>t :TagbarToggle<CR>
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
        \ ]
    \ }
    let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
        \ 'kinds' : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
        \ ]
    \ }
    let g:tagbar_type_ruby = {
        \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'f:methods',
            \ 'F:singleton methods'
        \ ]
    \ }
    let g:tagbar_width   = 30
    let g:tagbar_left    = 0
    let g:tagbar_sort    = 0
    let g:tagbar_compact = 1
endif

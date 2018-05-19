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

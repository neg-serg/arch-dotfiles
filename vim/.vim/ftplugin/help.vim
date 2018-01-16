function! s:on_FileType_help_define_mappings()
    if &l:readonly
        nnoremap <buffer>J <C-]>
        nnoremap <buffer>K <C-t>
    endif
endfunction
autocmd vimrc Filetype help call s:on_FileType_help_define_mappings()


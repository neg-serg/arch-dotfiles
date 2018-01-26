setlocal expandtab shiftwidth=4 softtabstop=4 nospell
let g:racer_experimental_completer = 1
let g:racer_cmd = $HOME.'/.cargo/bin/racer'
nnoremap <buffer><silent> gd <Plug>(rust-def)
nnoremap <buffer><silent> gs <Plug>(rust-def-split)
nnoremap <buffer><silent> gx <Plug>(rust-def-vertical)
nnoremap <buffer><silent> <leader>gd <Plug>(rust-doc)

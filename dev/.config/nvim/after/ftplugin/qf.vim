nnoremap <buffer> <Left> :call quickfixed#history(0)<CR>
nnoremap <buffer> <Right> :call quickfixed#history(1)<CR>
nnoremap <buffer> <CR> <CR>
nnoremap <buffer> p :cnext<CR>
nnoremap <buffer> n :cprevious<CR>
nnoremap <nowait><buffer> q :wincmd c<CR>

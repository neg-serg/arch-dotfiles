command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang W :call CreateFoldersAndWrite(<bang>0)
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

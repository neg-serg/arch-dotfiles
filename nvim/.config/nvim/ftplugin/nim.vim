let b:MarkMargin = 80

compiler nim

function! CompileNim(threads) abort
  let l:filename = expand('%:t')
  if a:threads == 1
    exec printf(':!nim c -r --threads:on %s', l:filename)
  else
    exec printf(':!nim c -r %s', l:filename)
  endif
endfunction

command! -nargs=1 CompileNim call CompileNim(<q-args>)
nnoremap <silent>rcf CompileNim
setlocal suffixesadd+=.nim
setlocal define=proc\\s
setlocal include=import\\s
setlocal path+=./**
set list

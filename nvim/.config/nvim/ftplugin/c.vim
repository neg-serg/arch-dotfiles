" This handles c++ files with the ".cc" extension.
augroup ccfiles
  autocmd!
  autocmd BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  autocmd BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  autocmd BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  autocmd BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END


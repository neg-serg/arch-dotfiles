function paranoicbackup#init()
  augroup pb_paranoicbackup
    autocmd!
    autocmd BufWritePre * call local#paranoicbackup#write()
  augroup END
endfunction

function! paranoicbackup#write()
  let dir = get(g:, 'paranoic_backup_dir' , '~/.vim/paranoic_backup')
  let filedir = l:dir . '/' . expand('%:p:h')
  let filename = expand('%:t')
  let timestamp = strftime('%Y-%m-%d %H:%M:%S')
  let fullpath = l:filedir . '/' . l:filename
  let escdir = fnameescape(l:filedir)
  let escfile = fnameescape(l:fullpath)
  let message = l:timestamp . ' '
        \ . substitute(l:fullpath, '^.\{4,}\(.\{27}\)$', '...\1','')
  silent execute '!mkdir -p ' . l:escdir
  silent execute 'keepalt w! ' . l:escfile
  silent execute "!sh -c \"cd " . l:escdir .
        \ ' && git add ' . l:escfile .
        \ ' && git commit '. l:escfile . " -m'" . l:message . "'\" > /dev/null &"
endfunction

" We reset the vimrc augroup. Autocommands are added to this group throughout the file
augroup vimrc
    autocmd!
    au BufRead *.session let g:session = expand('%:p:h') | so % | bd #
    au VimLeave * if exists('g:session') | call Mks(g:session) | endif
augroup end
au StdinReadPost * set buftype=nofile
au BufReadCmd file:///* exe "bd!|edit ".substitute(expand("<afile>"),"file:/*","","")

fun! Mks(path)
    exe "mksession! ".a:path."/".fnamemodify(a:path, ':t').".session"
endfun

" Return to last edit position (You want this!) *N*
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

augroup modechange_settings
    autocmd!
    " Clear search context when entering insert mode, which implicitly stops the
    " highlighting of whatever was searched for with hlsearch on. It should also
    " not be persisted between sessions.
    autocmd InsertEnter * let @/ = ''
    autocmd BufReadPre,FileReadPre * let @/ = ''
    autocmd InsertLeave * setlocal nopaste
augroup END

function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

autocmd BufEnter * call <SID>AutoProjectRootCD()

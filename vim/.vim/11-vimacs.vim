if exists("g:loaded_vim_like_emacs") || v:version < 700 || &cp
  finish
endif
let g:loaded_vim_like_emacs = 1

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap        <C-B> <Left>
inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
inoremap <expr> <C-E> col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"
inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

noremap! <expr> <SID>transposition getcmdpos()>strlen(getcmdline())?"\<Left>":getcmdpos()>1?'':"\<Right>"
noremap! <expr> <SID>transpose "\<BS>\<Right>".matchstr(getcmdline()[0 : getcmdpos()-2], '.$')
cmap <script> <C-T> <SID>transposition<SID>transpose

omap <C-b> <Left>
omap <C-e> <End>

inoremap <C-x>b <C-o>:Unite -silent buffer<CR>
inoremap <M-f> <C-o>e<Right>
inoremap <M-b> <S-Left>
inoremap <M-d> <C-O>dw
onoremap <M-f> e<Right>

inoremap   <C-o>u
inoremap <silent> <c-a> <esc>I

cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <expr> <C-d> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-f> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <C-_> <c-f>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <M-d> <S-Right><C-w>
cnoremap <C-y> <C-r><C-o>"
cnoremap <M-f> <S-Right>

inoremap <silent> <C-k><C-k> <C-r>=<SID>KillLine()<CR>
inoremap <M-z> <C-o>dt

function! <SID>KillLine()
  if col('.') > strlen(getline('.'))
    " At EOL; join with next line
    return "\<Del>"
  else
    " Not at EOL; kill until end of line
    return "\<C-o>d$"
  endif
endfunction

function! <SID>ttext(mode) range
   let last_search = histget('search', -1)
   if a:mode =~ 'v'
      let save_cursor = getpos("'>")
      " visual interactive :)
      if 'vi' == a:mode
         let operators = input('Pivot: ')
      else
         let comparison_ops = ['===', '!==',  '<>', '==#', '!=#',  '>#',
                              \'>=#',  '<#', '<=#', '=~#', '!~#', '==?',
                              \'!=?',  '>?', '>=?',  '<?', '<=?', '=~?',
                              \'!~?',  '==',  '!=',  '>=',  '<=',  '=~',
                              \ '~=',  '!~']
         let logical_ops    = [ '&&',  '||']
         let assignment_ops = [ '+=',  '-=',  '*=',  '/=',  '%=',  '&=',
                              \ '|=',  '^=', '<<=', '>>=']
         let scope_ops      = [ '::']
         let pointer_ops    = ['->*',  '->',  '.*']
         let bitwise_ops    = [ '<<',  '>>']
         let misc_ops       = [  '>',   '<',   '=',   '+',   '-',   '*',
                              \  '/',   '%',   '&',   '|',   '^',   '.',
                              \  '?',   ':',   ',',  "'=",  "'<",  "'>",
                              \ '!<',  '!>']
         let operators_list = comparison_ops
         " If a count is used, swap on comparison operators only
         if v:count < 1
            let operators_list += assignment_ops + logical_ops +
                                \ scope_ops      + pointer_ops +
                                \ bitwise_ops
            if exists('g:swap_custom_ops')
               " let g:swap_custom_ops = ['ope1', 'ope2', ...]
               let operators_list += g:swap_custom_ops
            endif
            let operators_list += misc_ops
         endif
         let operators = join(operators_list, '\|')
         let operators = escape(operators, '*/~.^$')
      endif
      " Whole lines
      if 'V' ==# visualmode() ||
         \ 'v' ==# visualmode() && line("'<") != line("'>")
         execute 'silent ' . a:firstline . ',' . a:lastline .
            \'substitute/'           .
            \  '^[[:space:]]*\zs'    .
            \'\([^[:space:]].\{-}\)' .
            \ '\([[:space:]]*\%('    . operators . '\)[[:space:]]*\)' .
            \'\([^[:space:]].\{-}\)' .
            \'\ze[[:space:]]*$/\3\2\1/e'
      else
         if col("'<") < col("'>")
            let col_start = col("'<")
            if col("'>") >= col('$')
               let col_end = col('$')
            else
               let col_end = col("'>") + 1
            endif
         else
            let col_start = col("'>")
            if col("'<") >= col('$')
               let col_end = col('$')
            else
               let col_end = col("'<") + 1
            endif
         endif
         execute 'silent ' . a:firstline . ',' . a:lastline .
            \'substitute/\%'         . col_start . 'c[[:space:]]*\zs' .
            \'\([^[:space:]].\{-}\)' .
            \ '\([[:space:]]*\%('    . operators . '\)[[:space:]]*\)' .
            \'\([^[:space:]].\{-}\)' .
            \'\ze[[:space:]]*\%'     . col_end   . 'c/\3\2\1/e'
      endif
   " Swap Words
   elseif a:mode =~ 'n'
      let save_cursor = getpos(".")
      " swap with Word on the left
      if 'nl' == a:mode
         call search('[^[:space:]]\+'  .
            \'\_[[:space:]]\+'  .
            \ '[^[:space:]]*\%#', 'bW')
      endif
      " swap with Word on the right
      execute 'silent substitute/'              .
         \ '\([^[:space:]]*\%#[^[:space:]]*\)' .
         \'\(\_[[:space:]]\+\)'                .
         \ '\([^[:space:]]\+\)/\3\2\1/e'
   endif
   " Repeat
   let virtualedit_bak = &virtualedit
   set virtualedit=
   if 'nr' == a:mode
      silent! call repeat#set("\<plug>SwapSwapWithR_WORD")
   elseif 'nl' == a:mode
      silent! call repeat#set("\<plug>SwapSwapWithL_WORD")
   endif
   " Restore saved values
   let &virtualedit = virtualedit_bak
   if histget('search', -1) != last_search
      call histdel('search', -1)
   endif
   if &virtualedit == 'all' && a:mode =~ 'v'
      " wrong cursor position is better than crash
      " https://groups.google.com/forum/#!topic/vim_dev/AK_HZ-5TeuU
      set virtualedit=
      call setpos('.', save_cursor)
      set virtualedit=all
   else
      call setpos('.', save_cursor)
   endif
endfunction

if exists('g:loaded_swap') || &compatible || v:version < 700
   if &compatible && &verbose
      echo "Swap is not designed to work in compatible mode."
   elseif v:version < 700
      echo "Swap needs Vim 7.0 or above to work correctly."
   endif
   finish
endif

let g:loaded_swap = 1

let s:savecpo = &cpoptions
set cpoptions&vim

xmap <silent> <plug>SwapSwapOperands      :     call <SID>ttext('v' )<cr>
xmap <silent> <plug>SwapSwapPivotOperands :     call <SID>ttext('vi')<cr>
nmap <silent> <plug>SwapSwapWithR_WORD    :<c-u>call <SID>ttext('nr')<cr>
nmap <silent> <plug>SwapSwapWithL_WORD    :<c-u>call <SID>ttext('nl')<cr>
imap <m-t> <c-o><m-t>

function! s:map(mode, lhs, rhs)
    if !hasmapto(a:rhs, a:mode)
        execute a:mode . 'map ' . a:lhs . ' ' . a:rhs
    endif
endfunction

call s:map('x', '<m-t>', '<plug>SwapSwapOperands')
call s:map('n', '<m-t>', '<plug>SwapSwapWithR_WORD')

let &cpoptions = s:savecpo
unlet s:savecpo

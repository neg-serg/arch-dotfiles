nnoremap [Qleader]e :call RunBroot()<CR>i

fun! RunBroot()
  let l:command = 'broot -h --conf ~/.config/nvim/nvim-broot.toml'
  enew
  call termopen(l:command, {'on_exit': 'BrootOnExit'})
endfun

fun! BrootOnExit(job_id, code, event) dict
  let l:filename = getline(1)
  enew | bd! #

  if (l:filename != '')
    execute 'edit ' . l:filename
  else
    bp
  endif
endfun

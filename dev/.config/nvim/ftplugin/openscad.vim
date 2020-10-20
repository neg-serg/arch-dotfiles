function! s:exit(src, dest, c, exit_code, exit_type)
  echo 'Generating ' . a:dest . ' from ' . a:src . ' finished.'
endfunction

function! s:log(src, dest, c, lines, stream)
  echo 'Generating ' . a:dest . ' from ' . a:src
endfunction

function! s:openscad(...)
  if a:0 == 0
    if !empty(get(b:, 'openscad', 0))
      try
        call chansend(b:openscad, '')
        echo 'OpenScad is already opened.'
        return
      catch
      endtry
    endif

    let b:openscad = jobstart(['openscad', expand('%')])
    return
  endif

  if a:1 ==# 'ex' || a:1 ==# 'export'
    let l:file = expand('%')
    if a:0 == 1
      let l:dest = substitute(l:file, '\(.*\)\.scad$', '\1.stl', '')
    else
      let l:dest = a:2
    endif
    call jobstart(['openscad', '-o', l:dest, l:file], {
          \   'on_stdout': function('s:log', [l:file, l:dest]),
          \   'on_stderr': function('s:log', [l:file, l:dest]),
          \   'on_exit': function('s:exit', [l:file, l:dest]),
          \   'stdout_buffered': v:false
          \ })
    return
  endif
endfunction

command! -nargs=* OpenScad call s:openscad(<f-args>)

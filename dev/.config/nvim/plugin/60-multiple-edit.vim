function! MultipleEdit(p_list)
  for p in a:p_list
    for c in glob(p, 0, 1)
      execute 'edit ' . c
    endfor
  endfor
endfunction

command! -bar -bang -nargs=+ -complete=file Edit call MultipleEdit([<f-args>])

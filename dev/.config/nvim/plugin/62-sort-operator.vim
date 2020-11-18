" usage: <key>ip <key>G
function! Sort(type, ...)
    '[,']sort
endfunction
nmap <silent> <leader>s :set opfunc=Sort<CR>g@

" Use a bunch of standard UNIX commands for quick an dirty
" whitespace-based alignment
function! Align()
	'<,'>!column -t|sed 's/  \(\S\)/ \1/g'
	normal gv=
endfunction
xnoremap <silent> <leader><S-a> :<C-u>silent call Align()<CR>

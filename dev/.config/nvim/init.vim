if !1 | finish | endif
lua require 'init'

augroup MY_GENERAL_AUGROUP
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif

	au BufUnload * wshada

	" This is equivalent to :set autochdir but lets buffer-local
	" autocommands change the dir. Autochdir doesn't.
	au BufEnter * if exists('b:shelley') && exists('b:shelley["path"]')
					\ | execute('lcd ' . b:shelley['path'])
				\ | else
					\ | let dir = expand('%:p:h')
					\ | if isdirectory(dir)
						\ | execute("lcd " . dir)
					\ | endif
				\ | endif
augroup END

augroup MY_UPDATE_AUGROUP
	autocmd!
	au BufWritePost ~/.config/xorg/Xdefaults !xrdb -merge ~/.config/xorg/Xdefaults
	au BufWritePost fonts.conf !fc-cache
augroup END

" Yanking in visual mode doesn't move the cursor back to where it was
vnoremap <expr>y "my\"" . v:register . "y`y"

" Move in command line mode using hjkl
for b in [["<C-h>", "<left>"],
	\ ["<C-j>", "<down>"],
	\ ["<C-k>", "<up>"],
	\ ["<C-l>", "<right>"],
	\ ["<C-a>", "<Home>"],
	\ ["<C-e>", "<End>"]]
    execute('lnoremap ' . b[0] . ' ' . b[1])
    execute('cnoremap ' . b[0] . ' ' . b[1])
    " Warning: Unexpected behavior might ensue when it comes to closing
    " completion menu because of <C-e>
    execute('inoremap <expr> ' . b[0] . ' (pumvisible() ? "\<C-e>" : "") . "\' . b[1] . '"')
endfor

" " Completes 'if' with 'endif', opening brackets with closing brackets...
" call minpac#add('https://github.com/rstacruz/vim-closer.git')
" call minpac#add('https://github.com/tpope/vim-endwise')

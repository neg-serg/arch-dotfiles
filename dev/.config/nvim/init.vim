"              *
"         *                *
"         _..._      *
"       .'     '.      _
"   *  /    .-""-\   _/ \
"    .-|   /:.   |  |   |
"    |  \  |:.   /.-'-./
"    | .-'-;:__.'    =/
"    .'=  *=|NVIM _.='
"   /   _.  |    ;
"  ;-.-'|    \   |     *
"  |  | \    _\  _\
"  |_/'._;.  ==' ==\     *
"          \    \   |
"          /    /   / *
"    *     /-._/-._/
"        * \   `\  \
"           `-._/._/
if !1 | finish | endif
lua require 'init'

augroup general
	autocmd!
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
				\| exe "normal! g`\"" | endif

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

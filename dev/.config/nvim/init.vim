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

augroup custom_updates
	autocmd!
	au BufWritePost ~/.config/xorg/Xdefaults !xrdb -merge ~/.config/xorg/Xdefaults
	au BufWritePost fonts.conf !fc-cache
augroup END

" Yanking in visual mode doesn't move the cursor back to where it was
vnoremap <expr>y "my\"" . v:register . "y`y"
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

""UNDER TESTING -- FZF PREVIEW VIM AS REPLACEMENT FOR FZF VIM, ITS S SUPER UP
"VERSION, BASICALLY A PREMADE CONFIG OF FZF WITH DEV ICONS ETC.
"let g:fzf_preview_use_dev_icons = 1
"let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" https://github.com/yuki-ycino/fzf-preview.vim/blob/master/README.md

" " Disables automatic commenting on newline:
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" " Enable Goyo by default for mutt writting
" " Goyo's width will be the line limit in mutt.
" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" " Update binds when sxhkdrc is updated.
" autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" " Run xrdb whenever Xdefaults or Xresources are updated.
" autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

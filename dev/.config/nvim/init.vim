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

"ESCAPE VIM TERMINAL MODE WITH ESC LIKE ALL OTHER MODES
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif

"VIM QUICKSCOPE --> COMPANION CONFIG TO unblevable/quick-scope
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

"HOW TO SEARCH AND REPLACE IN MULTIPLE FILES --
"All we have to do is be in a file with the string to replace and do this
":grep \"string" -- if we arent in file with string to replace yet
":cfdo %s/test/success/g | update -- all we need to do is pipe the result of
"the first find and replace to :update and it will save the file for us then
"ripgrep recursively does the rest automatically as we have set it up to work
"that way
"NOTE - We can also F&R multiple open files only using buffers like so -- :bufdo %s/pizza/donut/g | update

"WHY RIPGREP MAKES OUR LIFE EASIER
"Otherwise we would have to search recursively each time like so :grep \"test" . -R
"Now we can just do :grep \"test" and we get a recursive search


" " Completes 'if' with 'endif', opening brackets with closing brackets...
" call minpac#add('https://github.com/rstacruz/vim-closer.git')
" call minpac#add('https://github.com/tpope/vim-endwise')

" " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " cnoreabbrev fzf FZF
" "
" "ESCAPE VIM TERMINAL MODE WITH ESC LIKE ALL OTHER MODES
" if has("nvim")
"   au TermOpen * tnoremap <Esc> <c-\><c-n>
"   au FileType fzf tunmap <Esc>
" endif
"
" "NOTE: DEPRECTATED THIS HAS A BUG THAT STOPS FZF CLOSING WHEN ESC PRESSED
" "if has('nvim')
"   "tnoremap <Esc> <C-\><C-n>
"   "tnoremap <M-[> <Esc>
"   "tnoremap <C-v><Esc> <Esc>
" "endif

" "SHOW GIT COMMIT / GIT BLAME POPUP
" "Show git commit that introduced line after cursor, bit like GIT BLAME, BUT
" "NOW WE CAN INCLUDE OUR VIM ;) Note leader-gm is mapped automatically too
" nnoremap <silent><leader>6 :GitMessenger<CR>
"
"
""Removed because I ended up just configuring fzf myself before I even got into
"using this plugin
"=========
""UNDER TESTING -- FZF PREVIEW VIM AS REPLACEMENT FOR FZF VIM, ITS S SUPER UP
"VERSION, BASICALLY A PREMADE CONFIG OF FZF WITH DEV ICONS ETC.
"let g:fzf_preview_use_dev_icons = 1
"let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" https://github.com/yuki-ycino/fzf-preview.vim/blob/master/README.md
"========
"

" "Explanation: The 0 (Zero) register is special because it only stores the last item you yank
" "and only if you yank it, not if you delete it with any of d,x,c,s.
" "We use this because we have the vim register synced with the system
" "clipboard. Meaning we can't do simple text replacement easily as deleting
" "text will overwrite yanked text in the register.
" nnoremap yp "0p
" nnoremap yP "0P

" command! Hl :help local-additions
" command! Fl :help function-list

" " >>> Clever gf {{{1
" nnoremap <silent> gf :call ka#utils#clever_gf()<CR>
" nnoremap <silent> gF :call ka#utils#clever_gf(1)<CR>
" " 1}}}

" nnoremap cd "+d
" nnoremap cp "+p
" nnoremap cP "+P
" nnoremap cy "+y
" nnoremap cY "+y$
" xnoremap Cd "+d
" xnoremap Cp "+p
" xnoremap CP "+P
" xnoremap Cy "+y

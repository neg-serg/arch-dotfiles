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

augroup MY_GENERAL_AUGROUP
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

" fun! ka#terminal#toggle(...) abort
"     let term_buf_nr = get(g:, 'term_buf_nr', 0)
"     if !term_buf_nr
"         let cwd = exists('a:1') ? expand('%:p:h') : getcwd()
"         let g:term_buf_nr = term_start(&shell, {
"                     \   'term_name': 'term',
"                     \   'cwd': cwd
"                     \ })
"         augroup Term
"             autocmd!
"             autocmd BufDelete,BufWipeout <buffer>
"                         \ unlet! g:term_buf_nr
"         augroup END
"     elseif bufexists(term_buf_nr)
"         let term_win_nr = bufwinnr(term_buf_nr)
"         silent execute term_win_nr isnot# -1
"                     \ ? term_win_nr . 'hide'
"                     \ : term_buf_nr . 'sbuffer'
"     endif
" endfun

" fun! ka#terminal#kill() abort
"     let term_buf_nr = get(g:, 'term_buf_nr', 0)
"     if term_buf_nr && index(term_list(), term_buf_nr) isnot# -1
"                 \ && bufloaded(term_buf_nr)
"         silent execute term_buf_nr . 'bwipeout!'
"         unlet! g:term_buf_nr
"     endif
" endfun

" fun! ka#ui#echo(title, msg, ...) abort
"     let title = !empty(a:title) ? a:title . ' ' : ''
"     let higroup = get(a:, 1, 'Normal')
"     let keep_in_history = get(a:, 2, 0)

"     redraw
"     execute 'echohl ' . higroup
"     if keep_in_history
"         echomsg title . a:msg
"         echohl None
"     else
"         echon title
"         echohl None
"         echon a:msg
"     endif
" endfun

" fun! ka#operator#sort(...) abort
"     execute printf('%d,%d:!sort', line("'["), line("']"))
" endfun

" fun! ka#sys#open_here(type, ...) abort
"     " type: (t)erminal, (f)ilemanager
"     " a:1: Location (pwd by default)

"     let cmd = {
"                 \ 't': (g:is_unix ?
"                 \   'exo-open --launch TerminalEmulator ' .
"                 \       '--working-directory %s 2> /dev/null &' :
"                 \   'start cmd /k cd %s'),
"                 \ 'f': (g:is_unix ?
"                 \   'xdg-open %s 2> /dev/null &' :
"                 \   'start explorer %s')
"                 \ }
"     exe printf('silent !' . cmd[a:type],
"                 \   (exists('a:1') ? shellescape(a:1) : getcwd())
"                 \ )

"     if !g:is_gui | redraw! | endif
" endfun

" fun! ka#sys#open_url() abort
"     " Open the current URL
"     " - If line begins with "Plug" open the github page
"     " of the plugin.

"     let cl = getline('.')
"     let url = escape(matchstr(cl, '[a-z]*:\/\/\/\?[^ >,;()]*'), '#%')
"     if cl =~# 'Plug'
"         let pn = cl[match(cl, "'", 0, 1) + 1 :
"                     \ match(cl, "'", 0, 2) - 1]
"         let url = printf('https://github.com/%s', pn)
"     endif
"     if !empty(url)
"         let url = substitute(url, "'", '', 'g')
"         let wmctrl = executable('wmctrl') && v:windowid isnot# 0 ?
"                     \ ' && wmctrl -ia ' . v:windowid : ''
"         exe 'silent :!' . (g:is_unix ?
"                     \   'x-www-browser ' . shellescape(url) :
"                     \   ' start "' . shellescape(url)) .
"                     \ wmctrl .
"                     \ (g:is_unix ? ' 2> /dev/null &' : '')
"         if !g:is_gui | redraw! | endif
"     endif

" endfun


" fun! ka#tabline#get() abort " {{{1
"     let hi_selected = '%#User4#'
"     let hi_cwd = '%#TabLine#'

"     let tabline = '%=' . hi_selected . '%( %{ka#tabline#buffer_info()} %)'
"     let tabline .= hi_cwd . '%( %{ka#tabline#cwd()} %)'
"     let tabline .= hi_selected . '%( %{ka#tabline#tab()} %)'
"     return tabline
" endfun
" " 1}}}

" fun! ka#tabline#buffer_info() abort " {{{1
"     let current = bufnr('%')
"     let buffers = filter(range(1, bufnr('$')), {i, v ->
"                 \  buflisted(v) && getbufvar(v, '&filetype') isnot# 'qf'
"                 \ })
"     let index_current = index(buffers, current) + 1
"     let modified = getbufvar(current, '&modified') ? '+' : ''
"     let count_buffers = len(buffers)
"     return index_current isnot# 0 && count_buffers ># 1
"                 \ ? printf('%s/%s', index_current, count_buffers)
"                 \ : ''
" endfun
" " 1}}}

" fun! ka#tabline#cwd() abort " {{{1
"     let cwd = fnamemodify(getcwd(), ':~')
"     if cwd isnot# '~/'
"         let cwd = len(cwd) <=# 15 ? pathshorten(cwd) : cwd
"         return cwd
"     else
"         return ''
"     endif
" endfun
" " 1}}}

" fun! ka#tabline#tab() abort " {{{1
"     let count_tabs = tabpagenr('$')
"     return count_tabs isnot# 1
"                 \ ? printf('T%d/%d', tabpagenr(), count_tabs)
"                 \ : ''
" endfun


" fun! ka#utils#clever_gf(...) abort " {{{1
"     " Expand 2 times in case we have $HOME or ~
"     let cf = fnamemodify(expand(expand('<cfile>')), '%:p')
"     if isdirectory(cf)
"         return ''
"     endif
"     if exists('a:1')
"         execute 'vsplit ' . cf
"     else
"         execute filereadable(cf)
"                     \ ? 'normal! gf'
"                     \ : 'edit ' . cf
"     endif
" endfun
" " 1}}}

" fun! ka#utils#go_to_tag_custom(...) abort " {{{1
"     " tjump to a tag <cexpr>, and if it does not exist search for a tag
"     " containing the expression with 'tselect /expr'

"     let split = get(a:, 1, 0)
"     try
"         let exp = expand('<cexpr>')
"         let cmd = split ? 'vertical stjump' : 'tjump'
"         execute cmd . ' ' . exp
"         normal! ztzv
"     catch /^Vim\%((\a\+)\)\=:E426/
"         " E426: no tag found
"         try
"             let cmd = split ? 'vertical stselect' : 'tselect'
"             execute cmd . ' /' . exp
"         catch /^Vim\%((\a\+)\)\=:\(E426\|E349\)/
"             " E349: no identifier on cursor
"             call ka#ui#echo('[E]', v:exception, 'Error')
"         endtry
"     endtry
" endfun
" " 1}}}

" fun! ka#utils#random_id() abort " {{{1
"     " Generate a random number (https://stackoverflow.com/a/12739441)
"     return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
" endfun
" " 1}}}

" fun! ka#utils#make_text_objs(to) abort " {{{1
"     let to = a:to

"     " For all ft
"     for [k, m] in to._
"         execute 'onoremap <silent> ' . k . ' :normal! ' . m . '<CR>'
"         execute 'xnoremap <silent> ' . k . ' :<C-u>normal! ' . m . '<CR>'
"     endfor
"     call remove(to, '_')

"     augroup MyTextObjects
"         autocmd!
"         for ft in keys(to)
"             for [k, m] in to[ft]
"                 execute 'autocmd FileType ' . ft .
"                             \ ' onoremap <buffer> <silent> ' . k .
"                             \ ' :normal! ' . m . '<CR>'
"                 execute 'autocmd FileType ' . ft .
"                             \ ' xnoremap <buffer> <silent> ' . k .
"                             \ ' :<C-u>normal! ' . m . '<CR>'
"             endfor
"         endfor
"     augroup END
" endfun
" " 1}}}

" fun! ka#utils#auto_mkdir() abort " {{{1
"     let dir = expand('<afile>:p:h')
"     let file = expand('<afile>:t')
"     if !isdirectory(dir)
"         echohl Question
"         let ans = input(dir . ' does not exist, create it [y/N]? ')
"         echohl None
"         if empty(ans) || ans =~? '^n$'
"             echomsg 'no'
"             return
"         endif
"         call mkdir(dir, 'p')
"         silent execute 'saveas ' . dir . '/' . file
"         " Then wipeout the alternative buffer if it have the same name.
"         if bufname('#') is# dir . '/' . file
"             silent execute 'bwipeout! ' . bufnr('#')
"         endif
"     endif
" endfun
" " 1}}}

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
"choice=$( rofi -dmenu -config /usr/share/rofi/themes/dmenu2.rasi -p "Search     :     ")

" Plug 'PotatoesMaster/i3-vim-syntax'
" Plug 'kovetskiy/sxhkd-vim'
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

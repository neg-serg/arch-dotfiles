packadd vim-wordy
setlocal wrap
setlocal linebreak
setlocal spell
setlocal textwidth=0

syntax region CodeFence start=+```\w\++ end=+```+ contains=@NoSpell
syntax region CodeBlock start=+`\w\++ end=+`+ contains=@NoSpell
syntax match UrlNoSpell /\w\+:\/\/[^[:space:]]\+/ contains=@NoSpell

if exists('g:set_writerline')
  finish
else
  set statusline+=\ %{wordcount().words}\ words
  let g:set_writerline = 1
endif

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd FileType text,markdown,gitcommit set nocindent

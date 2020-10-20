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

autocmd vimrc BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
autocmd vimrc FileType markdown setlocal spell! spelllang=en_us tw=77 fo+=t


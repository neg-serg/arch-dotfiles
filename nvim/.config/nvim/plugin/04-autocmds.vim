augroup fix_stdin
    autocmd StdinReadPost * set buftype=nofile
augroup end

augroup continue_buf
    " Return to last edit position (You want this!) *N*
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup end

augroup modechange_settings
    autocmd!
    " Clear search context when entering insert mode, which implicitly stops the
    " highlighting of whatever was searched for with hlsearch on. It should also
    " not be persisted between sessions.
    autocmd InsertEnter * let @/ = ''
    autocmd BufReadPre,FileReadPre * let @/ = ''
    autocmd InsertLeave * setlocal nopaste
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout=60, higroup="Search"})
augroup END

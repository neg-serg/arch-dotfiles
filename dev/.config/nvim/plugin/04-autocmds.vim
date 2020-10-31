augroup fix_stdin
    autocmd StdinReadPost * set buftype=nofile
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

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter,BufEnter * setlocal cursorline
    au BufLeave,WinLeave * setlocal nocursorline
augroup END

function! RestoreCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 1 && line("'\"") <= line("$") |
            execute 'normal! g`"zvzz' |
        endif
    end
endfunction
autocmd BufReadPost * call RestoreCursorPosition()

au FocusGained,BufEnter,FileChangedShell,WinEnter * checktime

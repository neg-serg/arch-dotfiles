augroup ModeChangeSettings
    autocmd!
    " Clear search context when entering insert mode, which implicitly stops the
    " highlighting of whatever was searched for with hlsearch on. It should also
    " not be persisted between sessions.
    autocmd InsertEnter * let @/ = ''
    autocmd BufReadPre,FileReadPre * let @/ = ''
    autocmd InsertLeave * setlocal nopaste
augroup END

augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout=60, higroup="Search"})
augroup END

augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,BufEnter * setlocal cursorline
    autocmd BufLeave,WinLeave * setlocal nocursorline
augroup END

function! RestoreCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 1 && line("'\"") <= line("$") |
            execute 'normal! g`"zvzz' |
        endif
    end
endfunction
autocmd BufReadPost * call RestoreCursorPosition()

autocmd FocusGained,BufEnter,FileChangedShell,WinEnter * checktime

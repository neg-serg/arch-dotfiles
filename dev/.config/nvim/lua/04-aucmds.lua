vim.api.nvim_exec([[
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
augroup cocgroup
    autocmd!
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
function! RestoreCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 1 && line("'\"") <= line("$") |
            execute 'normal! g`"zvzz' |
        endif
    end
endfunction
autocmd BufReadPost * call RestoreCursorPosition()
autocmd FocusGained,BufEnter,FileChangedShell,WinEnter * checktime

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable Goyo by default for mutt writting
" Goyo's width will be the line limit in mutt.
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

]], true)
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

nvim_create_augroups({
    core = {
        {'BufReadPost', '*', [[
        if line("'\"") > 1 && line("'\"") <= line("$") |
            exe "normal! g'\"" |
        endif ]], },
        {'FocusGained,BufEnter,FileChangedShell,WinEnter', '*', 'checktime'},
        -- Disables automatic commenting on newline:
        {'FileType', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        -- Update binds when sxhkdrc is updated.
        {'BufWritePost', '*sxhkdrc', '!pkill -USR1 sxhkd'},
        {'BufWritePost', '01-plugins.lua', 'PackerCompile'},
        {'BufEnter', '*', 'set noreadonly'},
        {'TermOpen', 'term://*', 'startinsert | setl nonumber'},
        {'TermClose', '*', 'call feedkeys("i")'},
        {'BufLeave', 'term://*', 'stopinsert'},
        -- This is equivalent to :set autochdir but lets buffer-local
        -- autocommands change the dir. Autochdir doesn't.
        {'BufEnter', '*', [[
        if exists('b:shelley') && exists('b:shelley["path"]')
            | execute('lcd ' . b:shelley['path'])
        | endif]]}
    },
    custom_updates = {
        {'BufWritePost', '~/.config/xorg/Xdefaults', '!xrdb -merge ~/.config/xorg/Xdefaults'},
        {'BufWritePost', 'fonts.conf', '!fc-cache'},
    },
    ModeChangeSettings = {
        -- Clear search context when entering insert mode, which implicitly stops the
        -- highlighting of whatever was searched for with hlsearch on. It should also
        -- not be persisted between sessions.
        {'InsertEnter', '*', [[let @/ = '']]},
        {'BufReadPre,FileReadPre', '*', [[let @/ = '']]},
        {'InsertLeave', '*', 'setlocal nopaste'},
    },
    HighlightYank = {
        {'TextYankPost', '*', [[silent! lua require'vim.highlight'.on_yank({timeout=60, higroup="Search"})]]}
    },
    CursorLine = {
        {'VimEnter,WinEnter,BufWinEnter,BufEnter', '*', 'setlocal cursorline'},
        {'BufLeave,WinLeave',  '*', 'setlocal nocursorline'}
    },
})

api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.NegStatusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.NegStatusline('inactive')
  augroup END
]], false)

local au = vim.api.nvim_create_autocmd
local gr = vim.api.nvim_create_augroup

local main = gr("main", {clear=true})
local mode_change = gr("mode_change", {clear=true})
local custom_updates = gr("custom_updates", {clear=true})
local hi_yank = gr("hi_yank", {clear=true})
local cursor_line = gr("cursor_line", {clear=true})
local statusline = gr("statusline", {clear=true})

au({'Filetype'}, {command='setlocal formatoptions-=c formatoptions-=r formatoptions-=o', group=main})
au({'FocusGained','BufEnter','FileChangedShell','WinEnter'}, {command='checktime', group=main})
-- Disables automatic commenting on newline:
au({'Filetype'}, {
    pattern={'help', 'startuptime', 'qf', 'lspinfo'},
    command='nnoremap <buffer><silent> q :close<CR>',
    group=main
})
-- Update binds when sxhkdrc is updated.
au({'BufWritePost'}, {pattern={'*sxhkdrc'}, command='!pkill -USR1 sxhkd', group=main})
au({'BufWritePost'}, {pattern={'01-plugins.lua'}, command='PackerCompile', group=main})
au({'BufEnter'}, {command='set noreadonly', group=main})
au({'TermOpen'}, {pattern={'term://*'}, command='startinsert | setl nonumber', group=main})
au({'TermClose'}, {command='call feedkeys("i")', group=main})
au({'BufLeave'}, {pattern={'term://*'}, command='stopinsert', group=main})
au({'BufReadPost'}, {command=[[
    if line("'\"") > 1 && line("'\"") <= line("$") |
        exe "normal! g'\"" |
    endif ]],
    group=main
})

-- Clear search context when entering insert mode, which implicitly stops the
-- highlighting of whatever was searched for with hlsearch on. It should also
-- not be persisted between sessions.
au({'BufReadPre','FileReadPre'}, {command=[[let @/ = '']], group=mode_change})
au({'InsertLeave'}, {command='setlocal nopaste', group=mode_change})

au({'BufWritePost'}, {
    pattern='~/.config/xorg/Xdefaults',
    command='!xrdb -merge ~/.config/xorg/Xdefaults',
    group=custom_updates
})
au({'BufWritePost'}, {pattern='fonts.conf', command='!fc-cache', group=custom_updates})

au({'TextYankPost'}, {
    callback=function() require'vim.highlight'.on_yank({timeout=60, higroup="Search"}) end,
    group=hi_yank
})

au({'VimEnter','WinEnter','BufWinEnter','BufEnter'}, {command='setlocal cursorline', group=cursor_line})
au({'BufLeave','WinLeave'}, {command='setlocal nocursorline', group=cursor_line})

au({'WinEnter','BufEnter','BufWinEnter'}, {callback=function() vim.wo.statusline=NegStatusline('active') end, group=statusline})
au({'WinLeave','BufLeave','BufWinLeave'}, {callback=function() vim.wo.statusline=NegStatusline('inactive') end, group=statusline})

-- Fix alacritty resize: github.com/neovim/neovim/issues/11330
au({"VimEnter"}, {
  callback = function()
    local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
    vim.defer_fn(function() vim.loop.kill(pid, WINCH) end, 20)
  end
})

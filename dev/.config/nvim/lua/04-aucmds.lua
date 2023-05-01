local au = vim.api.nvim_create_autocmd
local gr = vim.api.nvim_create_augroup

local main = gr("main", {clear=true})
local mode_change = gr("mode_change", {clear=true})
local custom_updates = gr("custom_updates", {clear=true})
local hi_yank = gr("hi_yank", {clear=true})

local function restore_cursor()
    au({"FileType"}, { buffer=0, once=true,
        callback = function()
            local types = {"nofile", "fugitive", "gitcommit", "gitrebase", "commit", "rebase", }
            if vim.fn.expand("%") == "" or types[vim.bo.filetype] ~= nil then
                return
            end
            local line = vim.fn.line
            if line([['"]]) > 0 and line([['"]]) <= line("$") then
                vim.api.nvim_command("normal! " .. [[g`"zv']])
            end
        end,
    })
end

au({'Filetype'}, {command='setlocal formatoptions-=c formatoptions-=r formatoptions-=o', group=main})
au({'FocusGained','BufEnter','FileChangedShell','WinEnter'}, {command='checktime', group=main})
-- Disables automatic commenting on newline:
au({'Filetype'}, {
    pattern={'help', 'startuptime', 'qf', 'lspinfo'},
    command='nnoremap <buffer><silent> q :close<CR>',
    group=main})
au({"BufNewFile","BufRead"}, {
    group=main,
    pattern="**/systemd/**/*.service",
    callback=function() vim.bo.filetype="systemd" end})
-- Update binds when sxhkdrc is updated.
au({'BufWritePost'}, {pattern={'*sxhkdrc'}, command='!pkill -USR1 sxhkd', group=main})
au({'BufWritePost'}, {pattern={'01-plugins.lua'}, command='source <afile> | PackerCompile', group=main})
au({'BufEnter'}, {command='set noreadonly', group=main})
au({'TermOpen'}, {pattern={'term://*'}, command='startinsert | setl nonumber | let &l:stl=" terminal %="', group=main})
au({'BufLeave'}, {pattern={'term://*'}, command='stopinsert', group=main})
au({"BufReadPost"}, {callback=restore_cursor, group=main, desc="auto line return"})
-- Clear search context when entering insert mode, which implicitly stops the
-- highlighting of whatever was searched for with hlsearch on. It should also
-- not be persisted between sessions.
au({'BufReadPre','FileReadPre'}, {command=[[let @/ = '']], group=mode_change})
au({'BufWritePost'}, {
    pattern='~/.config/xorg/Xdefaults',
    command='!xrdb -merge ~/.config/X11/xresources',
    group=custom_updates})
au({'BufWritePost'}, {pattern='fonts.conf', command='!fc-cache', group=custom_updates})
au({'TextYankPost'}, {
    callback=function() require'vim.highlight'.on_yank({timeout=60, higroup="Search"}) end,
    group=hi_yank})
au({'DirChanged'}, {pattern={'window','tab','tabpage','global'}, callback=function()
    vim.cmd("silent !zoxide add " .. vim.fn.getcwd())
end,group=main})

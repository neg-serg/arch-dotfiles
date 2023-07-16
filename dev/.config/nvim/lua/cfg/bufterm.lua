local status, bufterm=pcall(require, 'bufterm')
if (not status) then return end
local term=require('bufterm.terminal')
local ui=require('bufterm.ui')
bufterm.setup({
    save_native_terms=true, -- integrate native terminals from `:terminal` command
    start_in_insert=true, -- start terminal in insert mode
    remember_mode=true, -- remember vi_mode of terminal buffer
    enable_ctrl_w=true, -- use <C-w> for window navigating in terminal mode (like vim8)
    terminal={              -- default terminal settings
        buflisted=false, -- whether to set 'buflisted' option
        termlisted=true,  -- list terminal in termlist (similar to buflisted)
        fallback_on_exit=true,  -- prevent auto-closing window on terminal exit
        auto_close=true,  -- auto close buffer on terminal job ends
    }
})
-- this will add Terminal to the list (not starting job yet)
local zsh=term.Terminal:new({
    cmd='zsh',
    buflisted=true,
    termlisted=true, -- set this option to false if you treat this terminal as single independent terminal
})
-- vim.keymap.set('n', '<leader>l', function()
--     zsh:spawn() -- spawn terminal (terminal won't be spawned if self.jobid is valid)
--     ui.Window:new(zsh.bufnr) -- open floating window
-- end, {desc='Open zsh in floating window',})


local runner = term.Terminal:new({
    cmd = function()
        local runner = {
            python = 'python3 %',
            go     = 'go run %',
            sh     = 'sh %',
            bash   = 'bash %',
            fish   = 'fish %',
        }
        local cmd = runner[vim.bo.filetype]
        if not cmd then
            -- fallback to default shell if can't run current filetype
            return vim.o.shell
        end
        cmd = cmd:gsub('%%', vim.fn.expand('%'))
        return cmd
    end,
    termlisted = true,
    fallback_on_exit = false,
    auto_close = false,
})
local runner_win = ui.Window:new()
vim.keymap.set('n', '<leader>l', function()
    -- re-run process if buffer is visible
    if runner.bufnr and vim.fn.bufwinid(runner.bufnr) > 0 then
        runner:run()
        return
    end
    -- open new window (or get existing window-id)
    local winid = runner_win:open(runner.bufnr)
    -- enter job
    runner:enter(winid)
end, {
desc = 'Run current file in bottom-end window'
})

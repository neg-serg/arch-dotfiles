-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ folke/persistence.nvim                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {
    'folke/persistence.nvim',
    config=function()
        require'persistence'.setup{
            dir=vim.fn.expand(vim.fn.stdpath('config') .. '/sessions/'), -- directory where session files are saved
            options={'buffers','curdir','tabpages','winsize'}, -- sessionoptions used for saving
        }
        -- restore the session for the current directory
        Map('n', '<leader>qs', function() persistence.load() end, {})
        -- restore the last session
        Map('n', '<leader>ql', function() persistence.load({last=true}) end, {})
        -- stop Persistence => session won't be saved on exit
        Map('n', '<leader>qd', function() persistence.stop() end, {})
    end,
} -- this will only start session saving when an actual file was opened

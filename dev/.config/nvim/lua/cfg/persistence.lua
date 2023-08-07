-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ folke/persistence.nvim                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, persistence = pcall(require, 'persistence')
if (not status) then return end

persistence.setup {
    dir=vim.fn.expand(vim.fn.stdpath('config') .. '/sessions/'), -- directory where session files are saved
    options={'buffers','curdir','tabpages','winsize'}, -- sessionoptions used for saving
}
-- restore the session for the current directory
map('n', '<leader>qs', [[<cmd>lua require('persistence').load()<cr>]], {})
-- restore the last session
map('n', '<leader>ql', [[<cmd>lua require('persistence').load({ last = true })<cr>]], {})
-- stop Persistence => session won't be saved on exit
map('n', '<leader>qd', [[<cmd>lua require('persistence').stop()<cr>]], {})

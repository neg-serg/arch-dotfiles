-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ stevearc/conform.nvim                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, conform=pcall(require, 'conform')
if (not status) then return end
conform.setup({
    formatters_by_ft={
        lua={'stylua'},
        python={'isort', 'black'}, -- Conform will run multiple formatters sequentially
        javascript={{'prettierd', 'prettier'}}, -- Use a sub-list to run only the first available formatter
   },
})

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Wansmer/treesj                                                               │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'Wansmer/treesj', -- vim arg wrapper
    config=function()
        map('n', '<leader>a', '<Cmd>TSJToggle<CR>')
    end}

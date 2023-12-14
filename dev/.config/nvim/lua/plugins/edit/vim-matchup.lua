-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ andymass/vim-matchup                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'andymass/vim-matchup', -- generic matcher
    config=function()
        vim.g.matchup_matchparen_enabled=0
        vim.g.matchup_motion_enabled=0
        vim.g.matchup_text_obj_enabled=1
    end,
    event={'BufRead','BufNewFile'}}

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ andymass/vim-matchup                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-matchup"] then
    vim.g.matchup_matchparen_enabled = 0
    vim.g.matchup_motion_enabled = 0
    vim.g.matchup_text_obj_enabled = 1
end

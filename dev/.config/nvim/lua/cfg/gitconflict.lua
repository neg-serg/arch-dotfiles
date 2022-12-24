-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ akinsho/git-conflict.nvim                                                    │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, git_conflict = pcall(require, 'git-conflict')
if (not status) then return end
git_conflict.setup()

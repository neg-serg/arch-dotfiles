-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ airblade/vim-rooter                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.g.rooter_targets = '/,*' -- directories and all files (default)
vim.g.rooter_cd_cmd = 'lcd' -- change directory for the current window only
vim.g.rooter_manual_only = 0 -- change dir manually
vim.g.rooter_resolve_links = 1 -- resolve symlinks
-- change dir to current if there is no project
vim.g.rooter_change_directory_for_non_project_files = 'current'
vim.g.rooter_silent_chdir = 1 -- silent chdir

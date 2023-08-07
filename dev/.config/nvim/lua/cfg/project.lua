-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ahmedkhalf/project.nvim                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, project_nvim = pcall(require, 'project_nvim')
if (not status) then return end

project_nvim.setup {
    manual_mode=true,
    detection_methods={'pattern','lsp'},
    show_hidden=true,
    silent_chdir=true,
}

map('n', '[Qleader]r', '<Cmd>ProjectRoot<CR>', {silent=true})

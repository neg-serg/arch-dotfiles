local status, project_nvim = pcall(require, 'project_nvim')
if (not status) then return end

project_nvim.setup {
    detection_methods={'pattern','lsp'},
    show_hidden=true,
    silent_chdir=true,
}

require('project_nvim').setup {
    update_cwd = true,
    respect_buf_cwd = true,
    detection_methods = {'pattern'},
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
}

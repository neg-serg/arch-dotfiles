-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ahmedkhalf/project.nvim                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {
    'ahmedkhalf/project.nvim', 
    config=function()
        require'project_nvim'.setup{
            manual_mode=true,
            detection_methods={'pattern','lsp'},
            show_hidden=true,
            silent_chdir=false,
        }
        map('n', '[Qleader]r', '<Cmd>ProjectRoot<CR>', {silent=true})
    end
}

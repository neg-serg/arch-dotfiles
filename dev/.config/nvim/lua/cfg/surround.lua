require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
    keymaps={
        normal='cs',
        normal_line='cS',
        normal_cur_line='cSS',
        visual='S',
        visual_line='gS',
        delete='ds',
        change='ys',
    },
    move_cursor=false,
    remap=true
})
map('n', 'csw', 'csiw')
map('n', 'csW', 'csiW')
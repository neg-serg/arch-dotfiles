require'modes'.setup{
    colors={
        copy="#f5c359",
        delete="#c75c6a",
        insert="#00954a",
        visual="#9745be",
    },
    line_opacity=0.15, -- Set opacity for cursorline and number background
    set_cursor=true, -- Enable cursor highlights
    set_cursorline=false, -- Enable cursorline initially, and disable cursorline for inactive windows or ignored filetypes
    set_number=false, -- Enable line number highlights to match cursorline
    ignore_filetypes={'NvimTree', 'TelescopePrompt'}
}

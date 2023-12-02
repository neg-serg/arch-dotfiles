local status, nvim_file_location = pcall(require, "nvim-file-location")
if not status then
    return
end
nvim_file_location.setup({
    keymap="<leader>c",
    mode="workdir", -- options: workdir | absolute
    add_line=true,
    add_column=false,
    default_register="*",
})

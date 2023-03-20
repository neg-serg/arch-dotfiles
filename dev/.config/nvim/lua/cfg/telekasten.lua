local home=vim.fn.expand("~/1st_level/")
local status, telekasten = pcall(require, 'telekasten')
if (not status) then return end

telekasten.setup({
    home=home,
    take_over_my_home=true, -- if true, telekasten will be enabled when opening a note within the configured home
    auto_set_filetype=true,
    -- dir names for special notes (absolute path or subdir name)
    dailies=home .. '/' .. 'daily',
    weeklies=home .. '/' .. 'weekly',
    templates=home .. '/' .. 'templates',
    image_subdir="img",
    extension   =".md",
    new_note_filename="title",
    uuid_type="%Y%m%d%H%M",
    uuid_sep="-",
    follow_creates_nonexisting=true,
    dailies_create_nonexisting=true,
    weeklies_create_nonexisting=true,
    journal_auto_open=false,
    template_new_note=home .. '/' .. 'templates/new_note.md',
    template_new_daily=home .. '/' .. 'templates/daily.md',
    template_new_weekly= home .. '/' .. 'templates/weekly.md',
    image_link_style="markdown",
    sort="filename",
    close_after_yanking=false,
    insert_after_inserting=true,
    tag_notation="#tag",
    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme="ivy",
    show_tags_theme="ivy",
    subdirs_in_links=true, -- when linking to a note in subdir/, create a [[subdir/title]] link instead of a [[title only]] link
    template_handling="smart",
    new_note_location="smart",
    rename_update_links=true,
    media_previewer="telescope-media-files",
})

local opts={silent=true, noremap=true, buffer=true}
vim.api.nvim_create_autocmd({"BufNewFile","BufRead"}, {
	pattern="*.md",
	group=vim.api.nvim_create_augroup('telekasten_only_keymap', {clear=true}),
	callback=function()
	    vim.keymap.set('n', '<leader>g', '<Cmd>lua require"telekasten".search_notes()<CR>', opts)
        vim.keymap.set('n', '<leader>T', '<Cmd>lua require"telekasten".goto_today()<CR>', opts)
        vim.keymap.set('n', '<leader>n', '<Cmd>lua require"telekasten".new_note()<CR>', opts)
        vim.keymap.set('n', '<leader>N', '<Cmd>lua require"telekasten".new_templated_note()<CR>', opts)
        vim.keymap.set('n', '<leader>y', '<Cmd>lua require"telekasten".yank_notelink()<CR>', opts)
        vim.keymap.set('n', '<leader>i', '<Cmd>lua require"telekasten".paste_img_and_link()<CR>', opts)
        vim.keymap.set('n', '<leader>t', '<Cmd>lua require"telekasten".toggle_todo()<CR>', opts)
        vim.keymap.set('n', '<leader>b', '<Cmd>lua require"telekasten".show_backlinks()<CR>', opts)
        vim.keymap.set('n', '<leader>F', '<Cmd>lua require"telekasten".find_friends()<CR>', opts)
        vim.keymap.set('n', '<leader>I', '<Cmd>lua require"telekasten".insert_img_link({ i=true })<CR>', opts)
        vim.keymap.set('n', '<leader>p', '<Cmd>lua require"telekasten".preview_img()<CR>', opts)
        vim.keymap.set('n', '<leader>m', '<Cmd>lua require"telekasten".browse_media()<CR>', opts)
        vim.keymap.set('n', '<leader>a', '<Cmd>lua require"telekasten".show_tags()<CR>', opts)
        vim.keymap.set('n', '<leader>#',  '<Cmd>lua require"telekasten".show_tags()<CR>', opts)
        vim.keymap.set('n', '<leader>r', '<Cmd>lua require"telekasten".rename_note()<CR>', opts)
        vim.keymap.set('i', '<leader>[',  '<Cmd>lua require"telekasten".insert_link({i=true})<CR>', opts)
        vim.keymap.set('i', '<leader>t', '<Cmd>lua require"telekasten".toggle_todo({i=true})<CR>', opts)
        vim.keymap.set('i', '<leader>#',  '<Cmd>lua require"telekasten".show_tags({i=true})<CR>', opts)
	end,
})

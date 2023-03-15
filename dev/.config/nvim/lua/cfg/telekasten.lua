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
    plug_into_calendar=true,
    calendar_opts={
        weeknm=4,
        calendar_monday=1,
        calendar_mark='left-fit',
    },
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

local opts={silent=true, noremap=true}
map('n', '<leader>zf', '<Cmd>lua require("telekasten").find_notes()<CR>', opts)
map('n', '<leader>zd', '<Cmd>lua require("telekasten").find_daily_notes()<CR>', opts)
map('n', '<leader>zg', '<Cmd>lua require("telekasten").search_notes()<CR>', opts)
map('n', '<leader>zz', '<Cmd>lua require("telekasten").follow_link()<CR>', opts)
map('n', '<leader>zT', '<Cmd>lua require("telekasten").goto_today()<CR>', opts)
map('n', '<leader>zW', '<Cmd>lua require("telekasten").goto_thisweek()<CR>', opts)
map('n', '<leader>zw', '<Cmd>lua require("telekasten").find_weekly_notes()<CR>', opts)
map('n', '<leader>zn', '<Cmd>lua require("telekasten").new_note()<CR>', opts)
map('n', '<leader>zN', '<Cmd>lua require("telekasten").new_templated_note()<CR>', opts)
map('n', '<leader>zy', '<Cmd>lua require("telekasten").yank_notelink()<CR>', opts)
map('n', '<leader>zc', '<Cmd>lua require("telekasten").show_calendar()<CR>', opts)
map('n', '<leader>zi', '<Cmd>lua require("telekasten").paste_img_and_link()<CR>', opts)
map('n', '<leader>zt', '<Cmd>lua require("telekasten").toggle_todo()<CR>', opts)
map('n', '<leader>zb', '<Cmd>lua require("telekasten").show_backlinks()<CR>', opts)
map('n', '<leader>zF', '<Cmd>lua require("telekasten").find_friends()<CR>', opts)
map('n', '<leader>zI', '<Cmd>lua require("telekasten").insert_img_link({ i=true })<CR>', opts)
map('n', '<leader>zp', '<Cmd>lua require("telekasten").preview_img()<CR>', opts)
map('n', '<leader>zm', '<Cmd>lua require("telekasten").browse_media()<CR>', opts)
map('n', '<leader>za', '<Cmd>lua require("telekasten").show_tags()<CR>', opts)
map('n', '<leader>#',  '<Cmd>lua require("telekasten").show_tags()<CR>', opts)
map('n', '<leader>zr', '<Cmd>lua require("telekasten").rename_note()<CR>', opts)
-- on hesitation, bring up the panel
map('n', '<leader>z', '<Cmd>lua require("telekasten").panel()<CR>', opts)
-- we could define [[ in **insert mode** to call insert link
-- inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
-- alternatively: leader [
map('i', '<leader>[',  '<Cmd>lua require("telekasten").insert_link({i=true})<CR>', opts)
map('i', '<leader>zt', '<Cmd>lua require("telekasten").toggle_todo({i=true})<CR>', opts)
map('i', '<leader>#',  '<Cmd>lua require("telekasten").show_tags({i=true})<CR>', opts)

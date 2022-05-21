require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.keybinds"] = { -- Configure core.keybinds
            config = { default_keybinds = true, neorg_leader = "<Space>" }},
        ["core.norg.concealer"] = {
            config = {
                markup_preset = "dimmed",
                icon_preset = "diamond",
                icons = {
                    marker = { icon = " ", },
                    todo = { enable = true, },
                },
            },
        }, -- Allows for use of icons
        ["core.gtd.base"] = { config = { workspace = "my_workspace" } },
        ["core.norg.qol.toc"] = {
            config = {
                close_split_on_jump = false,
                toc_split_placement = "left",
            },
        },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            ["core.norg.completion"] = {config = {engine = "nvim-cmp"}},
            config = {workspaces = {my_workspace = "~/1st_level/"}}
        }
    },
}

require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.keybinds"] = { -- Configure core.keybinds
            config = {
                default_keybinds = true, -- Generate the default keybinds
                neorg_leader = "<Leader>o" -- This is the default if unspecified
            }},
        ["core.norg.concealer"] = {
            config = {
                markup_preset = "dimmed",
                icon_preset = "diamond",
                icons = {
                    marker = {
                        icon = " ",
                    },
                    todo = {
                        enable = true,
                        pending = { icon = "", },
                        uncertain = { icon = "?", },
                        urgent = { icon = "", },
                        on_hold = { icon = "", },
                        cancelled = { icon = "", },
                    },
                },
            },
        }, -- Allows for use of icons
        ["core.norg.qol.toc"] = {
            config = {
                close_split_on_jump = false,
                toc_split_placement = "left",
            },
        },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            ["core.norg.completion"] = {config = {engine = "nvim-cmp"}},
            config = {workspaces = {my_workspace = "~/1st_level"}}
        }
    },
}

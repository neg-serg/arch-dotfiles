-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ altermo/ultimate-autopair.nvim                                               │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'altermo/ultimate-autopair.nvim', -- better autopair
        config={cmap=false}, -- remove cmdline autoclose
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6', --recomended as each new version will have breaking changes
        opts={}}

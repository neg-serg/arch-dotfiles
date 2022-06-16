-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ luukvbaal/nnn.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nnn.nvim"] and _G.packer_plugins["nnn.nvim"].loaded then
    require("nnn").setup({
        picker = {
            style = {
                width = 1.0,      -- percentage relative to terminal size when < 1, absolute otherwise
                height = 1.0,     -- ^
                xoffset = 0.0,    -- ^
                yoffset = 0.0,    -- ^
                border = "none"   -- border decoration for example "rounded"(:h nvim_open_win)
            },
            session = "shared",      -- or "global" / "local" / "shared"
        },
        auto_open = {
            setup = nil,
            tabpage = nil,
            empty = false,
            ft_ignore = { "gitcommit" }
        },
        replace_netrw = "picker",
        auto_close = false,  -- close tabpage/nvim when nnn is last window
        buflisted = false,   -- wether or not nnn buffers show up in the bufferlist
        window_nav = "<C-l>"
    })
end

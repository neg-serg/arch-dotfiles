-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nathom/filetype.nvim                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["filetype.nvim"] and _G.packer_plugins["filetype.nvim"].loaded then
    require("filetype").setup({
        overrides = {
            shebang = {
                dash = "sh",
            },
        },
    })
end

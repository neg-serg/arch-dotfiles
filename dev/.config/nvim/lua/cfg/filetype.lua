-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nathom/filetype.nvim                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, filetype = pcall(require, 'filetype')
if (not status) then return end
filetype.setup({
    overrides={
        shebang={dash="sh",},
    },
})

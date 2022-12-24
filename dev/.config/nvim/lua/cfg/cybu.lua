-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ghillb/cybu.nvim                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local ok, cybu=pcall(require, 'cybu')
if not ok then return end
cybu.setup({style={
    highlights={                          -- see highlights via :highlight
        current_buffer='CursorLineNr',    -- for current / selected buffer
        adjacent_buffers='CybuAdjacent',  -- for buffers not in focus
        background='CybuBackground',      -- for the window background
    }
}})
vim.keymap.set('n', '<Tab>', '<Plug>(CybuPrev)')
vim.keymap.set('n', '<S-Tab>', '<Plug>(CybuNext)')

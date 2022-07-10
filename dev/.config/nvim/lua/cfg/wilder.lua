-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ gelguy/wilder.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local wilder = require('wilder')
wilder.setup({
    modes = {':'},
    next_key = '<C-e>',
    previous_key = '<S-Tab>',
    accept_key = '<Tab>'
})
wilder.set_option('use_python_remote_plugin', 0)
wilder.set_option('noselect', 0)
wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({ fuzzy = 2, }),
        wilder.vim_search_pipeline()
    )
})

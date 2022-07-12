-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ gelguy/wilder.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local wilder = require('wilder')
wilder.enable_cmdline_enter()

local function init_wilder()
    wilder.setup({
        modes = {':'},
        next_key = '<C-e>',
        previous_key = '<S-Tab>',
        accept_key = '<Tab>'
    })
    wilder.set_option('use_python_remote_plugin', 0)
    wilder.set_option('noselect', 0)
    wilder.set_option('pipeline', {
        wilder.debounce(10),
        wilder.branch(
            wilder.cmdline_pipeline({ fuzzy = 2, }),
            wilder.python_search_pipeline({ pattern = "fuzzy", }),
            wilder.vim_search_pipeline()
        )
    })
end

-- Lazy loading the setup.
local wilder_group = vim.api.nvim_create_augroup("WILDER", { clear = true })
vim.api.nvim_create_autocmd("CmdlineEnter", {group = wilder_group, pattern = "*", once = true, callback = init_wilder})

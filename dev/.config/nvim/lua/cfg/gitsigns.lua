-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ lewis6991/gitsigns.nvim                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require('gitsigns').setup {
    signs={
        add={hl='GitSignsAdd', text='▎', show_count=false, numhl='GitSignsAddNr', linehl='GitSignsAddLn'},
        change={hl='GitSignsChange', text='▎', show_count=false, numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete={hl='GitSignsDelete', text='_', show_count=false, numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete={hl='GitSignsDelete', text='‾', show_count=false, numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete={hl='GitSignsChange', text='~', show_count=false, numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    count_chars={
        [1]   = "",   [2] = "₂",  [3] = "₃",
        [4]   = "₄",  [5] = "₅",  [6] = "₆",
        [7]   = "₇",  [8] = "₈",  [9] = "₉",
        ["+"] = "₊",
    },
    numhl=false,
    linehl=false,
    keymaps={
        noremap=true,
        buffer=true,
        ['n ]c']={ expr=true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [c']={ expr=true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
    },
    watch_gitdir={interval=500, follow_files=true},
    sign_priority=6,
    update_debounce=100,
    status_formatter=nil,
    diff_opts={ algorithm="patience", internal=true, indent_heuristic=true,},
}

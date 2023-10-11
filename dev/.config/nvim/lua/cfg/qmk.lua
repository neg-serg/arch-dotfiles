-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ codethread/qmk.nvim                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, qmk=pcall(require, 'qmk')
if (not status) then return end
local qmk=require 'qmk'
qmk.setup {
    name='LAYOUT_preonic_grid', -- identify your layout name
    comment_preview={
        keymap_overrides={
            HERE_BE_A_LONG_KEY='Magic', -- replace any long key codes
        },
    },
    layout={ -- create a visual representation of your final layout
        'x ^xx', -- including keys that span multple rows (with alignment left, center or right)
        '_ x x', -- pad empty cells
        '_ x x',
    },
}

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ray-x/navigator.lua                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require'navigator'.setup({
    debug=false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
    width=0.75, -- max width ratio (number of cols for the floating window) / (window width)
    height=0.3, -- max list window height, 0.3 by default
    preview_height=0.35, -- max height of preview windows
    border={"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, -- border style, can be one of 'none', 'single', 'double', 'shadow', or a list of chars which defines the border
    ts_fold=false,  -- modified version of treesitter folding
    default_mapping=true,  -- set to false if you will remap every key or if you using old version of nvim-
    keymaps={{key="gK", func=vim.lsp.declaration, desc='declaration'}}, -- a list of key maps please check mapping.lua for all keymaps
    treesitter_analysis=true, -- treesitter variable context
    treesitter_navigation=true, -- bool|table false: use lsp to navigate between symbol ']r/[r', table: a list of
    treesitter_analysis_max_num=100, -- how many items to run treesitter analysis
    treesitter_analysis_condense=true, -- condense form for treesitter analysis
    -- this value prevent slow in large projects, e.g. found 100000 reference in a project
    transparency=50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
    lsp_signature_help=true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
    -- setup here. if it is nil, navigator will not init signature help
    signature_help_cfg=nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
    icons={ -- refer to lua/navigator.lua for more icons config
        icons=true, -- requires nerd fonts or nvim-web-devicons
        code_action_icon="🏏", -- note: need terminal support, for those not support unicode, might crash
        diagnostic_head='🐛',
        diagnostic_head_severity_1="🈲",
    },
    -- mason=true, -- set to true if you would like use the lsp installed by williamboman/mason
    lsp={
        enable=true,
        diagnostic_virtual_text=true,  -- show virtual for diagnostic message
        diagnostic_update_in_insert=false, -- update diagnostic message in insert mode
        display_diagnostic_qf=true, -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it
        diagnostic_scrollbar_sign={'╍', 'ﮆ'}, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
        code_action={enable=true, sign=true, sign_priority=40, virtual_text=true},
        code_lens_action={enable=true, sign=true, sign_priority=40, virtual_text=true},
        document_highlight=true, -- LSP reference highlight, it might already supported by you setup, e.g. LunarVim
        format_on_save=false,
        diagnostic={
            underline=true,
            virtual_text=true, -- show virtual for diagnostic message
            update_in_insert=false, -- update diagnostic message in insert mode
            float={                 -- setup for floating windows style
                focusable=false,
                sytle='minimal',
                border='rounded',
                source='always',
                header='',
                prefix='',
            },
        },
    },
    ctags ={
        cmd='ctags',
        tagfile='tags',
        options='-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number',
    },
    -- hover={
    --     enable=true,
    --     keymap={
    --         ['<C-k>']={
    --             go=function()
    --                 local w=vim.fn.expand('<cWORD>')
    --                 vim.cmd('GoDoc ' .. w)
    --             end,
    --             default=function()
    --                 local w=vim.fn.expand('<cWORD>')
    --                 vim.lsp.buf.workspace_symbol(w)
    --             end,
    --         },
    --     },
    -- },
})

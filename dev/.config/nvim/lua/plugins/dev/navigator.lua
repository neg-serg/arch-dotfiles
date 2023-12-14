-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ ray-x/navigator.lua                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'ray-x/navigator.lua', -- great source code ui
    config=function()
        require'navigator'.setup({
            debug=false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
            width=0.85, -- max width ratio (number of cols for the floating window) / (window width)
            height=0.4, -- max list window height, 0.3 by default
            preview_height=0.3, -- max height of preview windows
            border={"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, -- border style, can be one of 'none', 'single', 'double', 'shadow', or a list of chars which defines the border
            default_mapping=false,  -- set to false if you will remap every key or if you using old version of nvim-
            treesitter_analysis=true, -- treesitter variable context
            treesitter_navigation=true, -- bool|table false: use lsp to navigate between symbol ']r/[r', table: a list of
            treesitter_analysis_max_num=100, -- how many items to run treesitter analysis
            treesitter_analysis_condense=true, -- condense form for treesitter analysis this value prevent slow in large projects, e.g. found 100000 reference in a project
            transparency=50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
            lsp_signature_help=false, -- ray-x/lsp_signature plugin in navigator setup here. if it is nil, navigator will not init signature help
            icons={ -- refer to lua/navigator.lua for more icons config
            icons=true, -- requires nerd fonts or nvim-web-devicons
            code_action_icon='🏏', -- note: need terminal support, for those not support unicode, might crash
            diagnostic_head='🐛',
            diagnostic_head_severity_1='🈲',
        },
        mason=true, -- set to true if you would like use the lsp installed by williamboman/mason
        lsp={
            enable=true,
            diagnostic_virtual_text=true,  -- show virtual for diagnostic message
            diagnostic_update_in_insert=false, -- update diagnostic message in insert mode
            display_diagnostic_qf=true, -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it
            diagnostic_scrollbar_sign={'╍', '▃'}, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
            code_action={enable=true, sign=true, sign_priority=40, virtual_text=false},
            code_lens_action={enable=true, sign=true, sign_priority=40, virtual_text=true},
            document_highlight=false, -- LSP reference highlight, it might already supported by you setup, e.g. LunarVim
            format_on_save=false,
            hover={enable=true},
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
        ctags={
            cmd='ctags',
            tagfile='tags',
            options='-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number',
        },
    })

    vim.keymap.set('i', '<M-k>', vim.lsp.buf.signature_help) -- desc='signature_help'
    vim.keymap.set('n', '<C-LeftMouse>', vim.lsp.buf.definition) -- desc='definition'
    vim.keymap.set('n', '<C-]', require'navigator.definition'.definition) -- desc='definition'
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help) -- desc='signature_help'
    vim.keymap.set('n', '<Leader>ct', require'navigator.ctags'.ctags) -- desc='ctags'
    vim.keymap.set('n', '<Leader>dt', require'navigator.diagnostics'.toggle_diagnostics) -- desc='toggle_diagnostics'
    vim.keymap.set('n', '<Leader>gT', require'navigator.treesitter'.bufs_ts) -- desc='bufs_ts'
    vim.keymap.set('n', '<Leader>gi', require'navigator.cclshierarchy'.incoming_calls) -- desc='incoming_calls'
    vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.incoming_calls) -- desc='incoming_calls'
    vim.keymap.set('n', '<Leader>go', require'navigator.cclshierarchy'.outgoing_calls) -- desc='outgoing_calls'
    vim.keymap.set('n', '<Leader>go', vim.lsp.buf.outgoing_calls) -- desc='outgoing_calls'
    vim.keymap.set('n', '<Leader>gr', require'navigator.reference'.reference) -- reference deprecated -- desc='reference'
    vim.keymap.set('n', '<Leader>gt', require'navigator.treesitter'.buf_ts) -- desc='buf_ts'
    vim.keymap.set('n', '<Leader>k', require'navigator.dochighlight'.hi_symbol) -- desc='hi_symbol'
    vim.keymap.set('n', '<Space>D', vim.lsp.buf.type_definition) -- desc='type_definition'
    vim.keymap.set('n', '<Space>ca', require'navigator.codeAction'.code_action) -- desc='code_action'
    vim.keymap.set('n', '<Space>gm', require'navigator.formatting'.range_format) -- desc='range format operator e.g gmip'
    vim.keymap.set('n', '<Space>la', require'navigator.codelens'.run_action) -- desc='run code lens action'
    vim.keymap.set('n', '<Space>rn', require'navigator.rename'.rename) -- desc='rename'
    vim.keymap.set('n', '<Space>wa', require'navigator.workspace'.add_workspace_folder) -- desc='add_workspace_folder'
    vim.keymap.set('n', '<Space>wl', require'navigator.workspace'.list_workspace_folders) -- desc='list_workspace_folders'
    vim.keymap.set('n', '<Space>wr', require'navigator.workspace'.remove_workspace_folder) -- desc='remove_workspace_folder'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover) -- desc='hover'
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev) -- desc='prev diagnostics'
    vim.keymap.set('n', '[r', require'navigator.treesitter'.goto_previous_usage) -- desc='goto_previous_usage'
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next) -- desc='next diagnostics'
    vim.keymap.set('n', ']r', require'navigator.treesitter'.goto_next_usage) -- desc='goto_next_usage'
    vim.keymap.set('n', 'g0', require('navigator.symbols').document_symbols) -- desc='document_symbols'
    vim.keymap.set('n', 'g<LeftMouse>', vim.lsp.buf.implementation) -- desc='implementation'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration) -- desc='declaration'
    vim.keymap.set('n', 'gG', require'navigator.diagnostics'.show_buf_diagnostics) -- desc='show_buf_diagnostics'
    vim.keymap.set('n', 'gL', require'navigator.diagnostics'.show_diagnostics) -- desc='show_diagnostics'
    vim.keymap.set('n', 'gW', require'navigator.workspace'.workspace_symbol_live) -- desc='workspace_symbol_live'
    vim.keymap.set('n', 'gd', require'navigator.definition'.definition) -- desc='definition'
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation) -- desc='implementation'
    vim.keymap.set('n', 'gr', require'navigator.reference'.async_ref) -- desc='async_ref'
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition) -- desc='type_definition'
    vim.keymap.set('v', '<Space>ca', require'navigator.codeAction'.range_code_action) -- desc='range_code_action'
    -- This broke <C-v>
    -- vim.keymap.set('n', 'gp', require'navigator.definition'.definition_preview) -- desc='definition_preview'
    -- vim.keymap.set('n', 'gP', require'navigator.definition'.type_definition_preview) -- desc='type_definition_preview'
end,
dependencies={
    {'ray-x/guihua.lua', build='cd lua/fzy && make'},
    {'neovim/nvim-lspconfig'}}}

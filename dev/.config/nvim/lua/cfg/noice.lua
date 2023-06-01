local status, noice = pcall(require, 'noice')
if (not status) then return end

noice.setup({
    cmdline={view='cmdline'},
    presets={
        bottom_search=true, -- use a classic bottom cmdline for search
        command_palette=nil, -- position the cmdline and popupmenu together
        long_message_to_split=true, -- long messages will be sent to a split
        lsp_doc_border=false, -- add a border to hover docs and signature help
        inc_rename=true, -- enables an input dialog for inc-rename.nvim
    },
    smart_move = {
        -- noice tries to move out of the way of existing floating windows.
        enabled = false, -- you can disable this behaviour here
        -- add any filetypes here, that shouldn't trigger smart move.
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    },
    routes={
        {filter={event='cmdline', find='^%s*[/?]',}, view='cmdline',},
        {filter={event='msg_show', kind='search_count',}, opts={skip=true},},
        {filter={event='msg_show', find='E486',},opts={skip=true},},
        {filter={event='msg_show', find='^/.*$',},opts={skip=true},},
        {filter={event='msg_show', kind='', find='line less',},opts={skip=true},},
        {filter={event='msg_show', kind='', find='written',}, opts={skip=true},},
        {filter={event='msg_show', kind='', find='1 time',}, opts={skip=true},},
        {filter={event='msg_show', kind='', find='Nothing to repeat',}, opts={skip=true},},
        {filter={event='msg_show', kind='', find='more line',}, opts={skip=true},},
        {filter={event='msg_show', kind='', find='line yanked',}, opts={skip=true},},
    },
    lsp={
        progress={
            enabled=true,
            format='lsp_progress',
            format_done='lsp_progress_done',
            throttle=1000 / 30, -- frequency to update lsp progress message
            view='mini',
        },
        override={
            ['vim.lsp.util.convert_input_to_markdown_lines']=true,
            ['vim.lsp.util.stylize_markdown']=true,
            ["cmp.entry.get_documentation"]=true,
        },
        hover={
            enabled=true,
            view=nil, -- when nil, use defaults from documentation
            opts={}, -- merged with defaults from documentation
        },
        signature={
            enabled=true,
            auto_open={
                enabled=true,
                trigger=true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip=true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle=50, -- Debounce lsp signature help request by 50ms
            },
            view=nil, -- when nil, use defaults from documentation
            opts={}, -- merged with defaults from documentation
        },
        message={
            -- Messages shown by lsp servers
            enabled=true,
            view="notify",
            opts={},
        },
        popupmenu={
            enabled=false, -- enables the Noice popupmenu UI
            backend='cmp', -- backend to use to show regular cmdline completions
            kind_icons={}, -- set to `false` to disable icons
        },
        -- defaults for hover and signature help
        documentation={
            view='hover',
            opts={
                lang='markdown',
                replace=true,
                render='plain',
                format={'{message}'},
                win_options={concealcursor='n', conceallevel=3},
            },
        },
    },
})

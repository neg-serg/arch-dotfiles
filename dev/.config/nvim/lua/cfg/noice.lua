require("noice").setup({
    cmdline={
        view="cmdline",
    },
    routes={
        {filter={event="cmdline",  find="^%s*[/?]",}, view="cmdline",},
        {filter={event="msg_show", kind="", find="line less",},opts={skip=true},},
        {filter={event="msg_show", kind="", find="written",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="1 time",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="Nothing to repeat",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="more line",}, opts={skip=true},},
        {filter={event="msg_show", kind="", find="line yanked",}, opts={skip=true},},
    },
    lsp={
        progress={
            enabled=true,
            format="lsp_progress",
            format_done="lsp_progress_done",
            throttle=1000 / 30, -- frequency to update lsp progress message
            view="mini",
        },
        override={
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"]=true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"]=true,
            -- override cmp documentation with Noice (needs the other options to work)
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
            enabled=true, -- enables the Noice popupmenu UI
            backend="nui", -- backend to use to show regular cmdline completions
            kind_icons={}, -- set to `false` to disable icons
        },
        -- defaults for hover and signature help
        documentation={
            view="hover",
            opts={
                lang="markdown",
                replace=true,
                render="plain",
                format={ "{message}" },
                win_options={concealcursor="n", conceallevel=3},
            },
        },
    },
})

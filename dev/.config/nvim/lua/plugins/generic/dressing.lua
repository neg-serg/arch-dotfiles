-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ stevearc/dressing.nvim                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'stevearc/dressing.nvim', -- better select ui
        config=function()
            require'dressing'.setup({
                input={
                    enabled=true, -- Set to false to disable the vim.ui.input implementation
                    default_prompt='Input:', -- Default prompt string
                    prompt_align='center', -- Can be 'left', 'right', or 'center'
                    insert_only=true, -- When true, <Esc> will close the modal
                    relative='cursor', -- 'editor' and 'win' will default to being centered
                    prefer_width=40, -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    width=nil,
                    -- min_width and max_width can be a list of mixed types.
                    -- min_width={20, 0.2} means 'the greater of 20 columns or 20% of total'
                    max_width={ 140, 0.9 },
                    min_width={ 20, 0.2 },
                    override=function(conf)
                        -- This is the config that will be passed to nvim_open_win.
                        -- Change values here to customize the layout
                        return conf
                    end,
                    -- see :help dressing_get_config
                    get_config=nil,
                    win_options={
                        winblend=0, -- Window transparency (0-100)
                        winhighlight='', -- Change default highlight groups (see :help winhl)
                    },
                },
                select={
                    enabled=false, -- Set to false to disable the vim.ui.select implementation
                    backend={ 'telescope', 'builtin' }, -- Priority list of preferred vim.select implementations
                    trim_prompt=true, -- Trim trailing `:` from prompt
                    -- Options for telescope selector
                    -- These are passed into the telescope picker directly. Can be used like:
                    -- telescope=require('telescope.themes').get_ivy({...})
                    telescope=nil,
                    builtin={
                        relative='editor', -- 'editor' and 'win' will default to being centered
                        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                        -- the min_ and max_ options can be a list of mixed types.
                        -- max_width={140, 0.8} means 'the lesser of 140 columns or 80% of total'
                        width=nil,
                        max_width={ 140, 0.8 },
                        min_width={ 40, 0.2 },
                        height=nil,
                        max_height=0.9,
                        min_height={ 10, 0.2 },
                        win_options={
                            winblend=10, -- Window transparency (0-100)
                            winhighlight='', -- Change default highlight groups (see :help winhl)
                        },
                        override=function(conf)
                            -- This is the config that will be passed to nvim_open_win.
                            -- Change values here to customize the layout
                            return conf
                        end,
                    },
                    format_item_override={}, -- Used to override format_item. See :help dressing-format
                    get_config=nil, -- see :help dressing_get_config
                },
            })
        end}

return {'nvim-orgmode/orgmode', config=function()
        require'orgmode'.setup_ts_grammar() -- Load treesitter grammar for org
        require'nvim-treesitter.configs'.setup({ -- Setup treesitter
            highlight={
                enable=true,
                additional_vim_regex_highlighting={'org'},
            },
            ensure_installed={'org'},
        })
        -- Setup orgmode
        require'orgmode'.setup({
            org_agenda_files='~/orgfiles/**/*',
            org_default_notes_file='~/orgfiles/refile.org',
        })
        end,
        event={'VeryLazy'}, dependencies={'nvim-treesitter/nvim-treesitter',lazy=true}}

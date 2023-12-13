return {'diegoulloao/nvim-file-location', -- copy current location
        config=function() 
            require'nvim-file-location'.setup({
                keymap="<leader>c",
                mode="workdir", -- options: workdir | absolute
                add_line=true,
                add_column=false,
                default_register="*",
            })
        end}

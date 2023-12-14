-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ cappyzawa/trim.nvim                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'cappyzawa/trim.nvim', -- trim trailing whitespace etc
    config=function()
        require'trim'.setup{
            ft_blocklist={'markdown'},
            trim_on_write=false,
            trim_last_line=false,
            trim_first_line=false,
        }
    end}

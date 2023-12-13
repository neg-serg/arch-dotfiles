-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ stevearc/conform.nvim                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {
    'stevearc/conform.nvim', -- neovim modern formatter
    config=function()
        require'conform'.setup({
            formatters_by_ft={
                lua={'stylua'},
                python={'isort', 'black'}, -- Conform will run multiple formatters sequentially
                javascript={{'prettierd', 'prettier'}}, -- Use a sub-list to run only the first available formatter
            },
        })
    end
}

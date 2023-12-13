-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ hiphish/rainbow-delimiters.nvim                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {
    'hiphish/rainbow-delimiters.nvim', -- rainbow parenthesis
    config=function()
        local rainbow_delimiters=require'rainbow-delimiters'
        vim.g.rainbow_delimiters={
            strategy={
                ['']=rainbow_delimiters.strategy['global'],
                vim=rainbow_delimiters.strategy['local'],
            },
            query={
                ['']='rainbow-delimiters',
                lua='rainbow-blocks',
            },
            highlight={
                'TSRainbowRed',
                'TSRainbowYellow',
                'TSRainbowBlue',
                'TSRainbowOrange',
                'TSRainbowGreen',
                'TSRainbowViolet',
                'TSRainbowCyan',
            },
        }
    end
}

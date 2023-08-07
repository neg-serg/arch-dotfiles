-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ lukas-reineke/headlines.nvim                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require("headlines").setup({
    markdown={
        source_pattern_start="^```",
        source_pattern_end="^```$",
        dash_pattern="-",
        dash_highlight="Dash",
        dash_string="", -- alts:  靖並   ﮆ 
        headline_pattern="^#+",
        headline_highlights={"Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6"},
        codeblock_highlight="CodeBlock",
    }, yaml={dash_pattern="^---+$", dash_highlight="Dash",},
})

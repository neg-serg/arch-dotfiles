require("headlines").setup {
    markdown = {
        source_pattern_start = "^```",
        source_pattern_end = "^```$",
        dash_pattern = "^---+$",
        headline_pattern = "^#+",
        headline_highlights = { "Headline1", "Headline2" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        fat_headlines = true,
    },
    rmd = {
        source_pattern_start = "^```",
        source_pattern_end = "^```$",
        dash_pattern = "^---+$",
        headline_pattern = "^#+",
        headline_highlights = { "Headline1", "Headline2" },
        codeblock_sign = "CodeBlock",
        dash_highlight = "Dash",
        fat_headlines = true,
    },
    vimwiki = {
        source_pattern_start = "^{{{%a+",
        source_pattern_end = "^}}}$",
        dash_pattern = "^---+$",
        headline_pattern = "^=+",
        headline_highlights = { "Headline1", "Headline2" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        fat_headlines = true,
    },
    org = {
        source_pattern_start = "#%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
        source_pattern_end = "#%+[eE][nN][dD]_[sS][rR][cC]",
        dash_pattern = "^-----+$",
        headline_pattern = "^%*+",
        headline_highlights = { "Headline1", "Headline2" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        fat_headlines = true,
    },
}

vim.cmd [[highlight Headline1 guibg=#10233a]]
vim.cmd [[highlight Headline2 guibg=#040f1c]]
vim.cmd [[highlight CodeBlock guibg=#1c334e]]
vim.cmd [[highlight Dash guibg=#0c1c30 gui=bold]]

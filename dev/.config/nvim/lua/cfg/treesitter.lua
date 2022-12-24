-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-treesitter/nvim-treesitter                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, tsconf = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end
tsconf.setup {
    ensure_installed="all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install=false,
    context_commentstring={enable=true},
    ignore_install={'phpdoc', 'swift'},
    highlight={
        enable=true, -- false will disable the whole extension
        disable={},  -- list of language that will be disabled
        additional_vim_regex_highlighting=false,
        use_languagetree=true,
    },
    endwise={enable=true,},
    matchup={
        enable=true, -- mandatory, false will disable the whole extension
        disable={},  -- optional, list of language that will be disabled
    },
    rainbow={
        enable=true,
        extended_mode=false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines=4000, -- Do not enable for files with more than 4000 lines, int
        colors={'#4064be', '#4361b0', '#455fa3', '#465e9c', '#475c94', '#485a8c', '#485885'},
    },
    indent={enable=false},
    autotag={enable=false},
    textobjects={
        select={
            enable=true,
            keymaps={
                ["af"]="@function.outer",
                ["if"]="@function.inner",
                ["am"]="@call.outer",
                ["im"]="@call.inner",
                ["ab"]="@block.outer",
                ["ib"]="@block.inner",
                ["aa"]="@parameter.outer",
                ["ia"]="@parameter.inner",
                ["as"]="@statement.outer",
            },
        },
    },
}

local ft_to_lang=require('nvim-treesitter.parsers').ft_to_lang
require('nvim-treesitter.parsers').ft_to_lang=function(ft)
    if ft == 'zsh' then
        return 'bash'
    end
    return ft_to_lang(ft)
end

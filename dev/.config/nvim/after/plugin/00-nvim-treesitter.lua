-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-treesitter/nvim-treesitter                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-treesitter"] and _G.packer_plugins["nvim-treesitter"].loaded then
    local tsconf = require'nvim-treesitter.configs'
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = {"src/parser.c", "src/scanner.cc"},
            branch = "main",
        },
    }

    parser_configs.norg_table = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
            files = { "src/parser.c" },
            branch = "main",
        },
    }

    parser_configs.norg_meta = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
            branch = "main",
            files = {"src/parser.c"},
        },
    }

    tsconf.setup {
      -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      context_commentstring = {enable = true},
      ignore_install = {'phpdoc', 'swift'},
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
        use_languagetree = true,
      },
      endwise = {enable = true,},
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable = {},  -- optional, list of language that will be disabled
      },
      rainbow = {
        enable = true,
        extended_mode = false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 4000, -- Do not enable for files with more than 1000 lines, int
        colors = {'#4064be', '#4361b0', '#455fa3', '#465e9c', '#475c94', '#485a8c', '#485885'},
      },
      indent = {enable = true},
      autotag = {enable = false},
    }

    local ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
    require('nvim-treesitter.parsers').ft_to_lang = function(ft)
        if ft == 'zsh' then
            return 'bash'
        end
        return ft_to_lang(ft)
    end
end

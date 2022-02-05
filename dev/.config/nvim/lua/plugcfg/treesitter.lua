local tsconf = require'nvim-treesitter.configs'
if not tsconf then
   vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   return
end

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

tsconf.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  context_commentstring = {enable = true},
  ignore_install = {"phpdoc"},
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
    use_languagetree = true,
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {},  -- optional, list of language that will be disabled
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 4000, -- Do not enable for files with more than 1000 lines, int
    colors = {'#365e96', '#315587', '#2e5080', '#294873', '#26436b', '#21395c', '#1d3352'},
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

local tsconf = require'nvim-treesitter.configs'
if not tsconf then
   vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   return
end

tsconf.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 4000, -- Do not enable for files with more than 1000 lines, int
    colors = {'#365e96', '#315587', '#2e5080', '#294873', '#26436b', '#21395c', '#1d3352'},
  },
  indent = {enable = {"javascriptreact"}},
  autotag = {enable = true},
}

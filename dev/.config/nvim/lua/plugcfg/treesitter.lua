require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  rainbow = { enable = true },
  indent = { enable = true }
}
vim.cmd('hi rainbowcol1 guifg=#365e96')
vim.cmd('hi rainbowcol2 guifg=#315587')
vim.cmd('hi rainbowcol3 guifg=#2e5080')
vim.cmd('hi rainbowcol4 guifg=#294873')
vim.cmd('hi rainbowcol5 guifg=#26436b')
vim.cmd('hi rainbowcol6 guifg=#21395c')
vim.cmd('hi rainbowcol7 guifg=#1d3352')

vim.cmd "cabbrev W w"
vim.cmd "cnoreabbrev gd Gvdiff"
vim.cmd "cnoreabbrev gp Gpush"
vim.cmd "cnoreabbrev gc Gcommit -v -m"
vim.cmd "cnoreabbrev gca Gcommit --amend -v"
vim.cmd "cnoreabbrev gcheckout Gcheckout"
vim.cmd "cnoreabbrev grm Gremove"
vim.cmd "cnoreabbrev gmv Gmove"
vim.cmd "cnoreabbrev L CocList"
vim.cmd "cnoreabbrev U UltiSnipsEdit"
vim.cmd "colorscheme neg"
vim.api.nvim_exec([[
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '^\k\+$'
        return "\<C-]>\<CR>"
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()
]], true)

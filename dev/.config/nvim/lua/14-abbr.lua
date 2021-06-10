vim.cmd "cabbrev W w"
vim.cmd "cabbrev W! w!"
vim.cmd "cnoreabbrev bd Bd"
vim.cmd "cnoreabbrev cp Cp"
vim.cmd "cnoreabbrev e E"
vim.cmd "cnoreabbrev gca Gcommit --amend -v"
vim.cmd "cnoreabbrev gc Gcommit -v -m"
vim.cmd "cnoreabbrev gcheckout Gcheckout"
vim.cmd "cnoreabbrev gd Gvdiff"
vim.cmd "cnoreabbrev gmv Gmove"
vim.cmd "cnoreabbrev gp Gpush"
vim.cmd "cnoreabbrev grm Gremove"
vim.cmd "cnoreabbrev L CocList"
vim.cmd "cnoreabbrev mkdir Mkdir"
vim.cmd "cnoreabbrev mv Mv"
vim.cmd "cnoreabbrev QA qa"
vim.cmd "cnoreabbrev QA! qa!"
vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Q! q!"
vim.cmd "cnoreabbrev rm Rm"
vim.cmd "cnoreabbrev sp Sp"
vim.cmd "cnoreabbrev tabe TabE"
vim.cmd "cnoreabbrev U UltiSnipsEdit"
vim.cmd "cnoreabbrev vs VS"
vim.cmd "cnoreabbrev wQ wq"
vim.cmd "cnoreabbrev Wq wq"
vim.cmd "cnoreabbrev WQ wq"
vim.cmd "cnoreabbrev W w"

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

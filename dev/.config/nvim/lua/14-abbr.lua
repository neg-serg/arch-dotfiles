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

-- cnoreabbrev W! w!
-- cnoreabbrev Q! q!
-- cnoreabbrev QA! qa!
-- cnoreabbrev QA qa
-- cnoreabbrev Wq wq
-- cnoreabbrev wQ wq
-- cnoreabbrev WQ wq
-- cnoreabbrev W w
-- cnoreabbrev Q q
-- cnoreabbrev e E
-- cnoreabbrev sp Sp
-- cnoreabbrev vs VS
-- cnoreabbrev tabe TabE
-- cnoreabbrev bd Bd
-- cnoreabbrev rm Rm
-- cnoreabbrev mkdir Mkdir
-- cnoreabbrev cp Cp
-- cnoreabbrev mv Mv

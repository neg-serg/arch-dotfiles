vim.cmd "cabbrev W w"
vim.cmd "cabbrev W! w!"
vim.cmd "cnoreabbrev Bd bd"
vim.cmd "cnoreabbrev Cp cp"
vim.cmd "cnoreabbrev E e"
vim.cmd "cnoreabbrev gb Telescope git_branches"
vim.cmd "cnoreabbrev gca Git commit --amend -v"
vim.cmd "cnoreabbrev gcc Git checkout"
vim.cmd "cnoreabbrev gc Git commit -v -m"
vim.cmd "cnoreabbrev gd Gvdiff"
vim.cmd "cnoreabbrev gl Telescope git_commits"
vim.cmd "cnoreabbrev gmv Gmove"
vim.cmd "cnoreabbrev gp Gpush"
vim.cmd "cnoreabbrev grm Gremove"
vim.cmd "cnoreabbrev gs Telescope git_status"
vim.cmd "cnoreabbrev mkdir Mkdir"
vim.cmd "cnoreabbrev mv Mv"
vim.cmd "cnoreabbrev QA qa"
vim.cmd "cnoreabbrev QA! qa!"
vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Q! q!"
vim.cmd "cnoreabbrev Sp sp"
vim.cmd "cnoreabbrev T Telescope"
vim.cmd "cnoreabbrev VS vs"
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
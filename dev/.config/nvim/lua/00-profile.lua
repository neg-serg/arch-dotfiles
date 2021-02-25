vim.api.nvim_exec([[
let g:startuptime = reltime()
augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | echomsg 'startuptime: ' . reltimestr(g:startuptime)
augroup END
]], true)

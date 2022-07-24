vim.api.nvim_exec([[
" usage: <key>ip <key>G
function! Sort(type, ...)
    '[,']sort
endfunction
nmap <silent> <leader>s :set opfunc=Sort<CR>g@
]], true)

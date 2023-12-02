vim.api.nvim_cmd({cmd='cabbrev', args={'W', 'w'}}, {})
vim.api.nvim_cmd({cmd='cabbrev', args={'W!', 'w!'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Bd', 'bd'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Cp', 'cp'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'E', 'e'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gb', 'Telescope git_branches'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gca', 'Git commit --amend -v'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gcc', 'Git checkout'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gc', 'Git commit -v -m'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gd', 'Gvdiff'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gl', 'Telescope git_commits'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gmv', 'Gmove'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gp', 'Gpush'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'grm', 'Gremove'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'gs', 'Telescope git_status'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'mkdir', 'Mkdir'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'QA', 'qa'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'QA!', 'qa!'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Q', 'q'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Q!', 'q!'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Sp', 'sp'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'T', 'Telescope'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'VS', 'vs'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'wQ', 'wq'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'Wq', 'wq'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'WQ', 'wq'}}, {})
vim.api.nvim_cmd({cmd='cnoreabbrev', args={'W', 'w'}}, {})

vim.api.nvim_exec2([[
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '^\k\+$'
        return "\<C-]>\<CR>"
    else
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> CCR()
]],{})

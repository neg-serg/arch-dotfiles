-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ junegunn/fzf.vim                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.api.nvim_exec([[
let g:fzf_action = {'ctrl-x': 'split', 'ctrl-v': 'vsplit'}
augroup fzf
    autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> setlocal laststatus=2 showmode
    " Advanced customization using autoload functions
    autocmd VimEnter * command! Colors call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})
augroup end
" Insert mode completion
imap <C-x><C-f> <Plug>(fzf-complete-path)
]], true)

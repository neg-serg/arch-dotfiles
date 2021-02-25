-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ junegunn/fzf.vim                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘complete_info()["selected"] != "-1" ? "" : "
-- if executable('rg')
--     let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
--     let s:rg_cmd = 'rg --hidden --follow'
--     let &grepprg=s:rg_cmd . ' --vimgrep'
--     let s:rg_ignore = split(&wildignore, ',') + [ 'node_modules', 'target', 'build', 'dist', '.stack-work' ]
--     let s:rg_cmd .= " --glob '!{'" . shellescape(join(s:rg_ignore, ',')) . "'}'"
-- endif
-- This is the default extra key bindings
vim.api.nvim_exec([[
nnoremap <silent> [Qleader]E :Files %:p:h<CR>
nnoremap <silent> [Qleader]e :Files<CR>
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
augroup fzf
    autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> setlocal laststatus=2 showmode
    " Advanced customization using autoload functions
    autocmd VimEnter * command! Colors call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})
augroup end
" Insert mode completion
imap <C-x><C-f> <Plug>(fzf-complete-path)
imap <C-x><C-l> <Plug>(fzf-complete-line)
]], true)

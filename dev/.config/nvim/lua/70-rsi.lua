api.nvim_command('cnoremap <C-a> <home>')
api.nvim_command('cnoremap <C-b> <left>')
api.nvim_command('cnoremap <C-e> <end>')
api.nvim_command('cnoremap <C-n> <down>')
api.nvim_command('cnoremap <C-p> <up>')
api.nvim_command('cnoremap <C-y> <M-r><C-o>"')
api.nvim_command('cnoremap <M-d> <S-Right><M-w>')
api.nvim_command('cnoremap <M-f> <S-Right>')
api.nvim_command('inoremap <C-b> <left>')
api.nvim_command('inoremap <C-f> <right>')
api.nvim_command('inoremap <C-x>b <C-o>:Buffers<CR>')
api.nvim_command('inoremap <M-b> <S-Left>')
api.nvim_command('inoremap <M-d> <C-o>dw')
api.nvim_command('inoremap <M-f> <C-o>e<Right>')
api.nvim_command('inoremap <silent> <c-a> <esc>I')
api.nvim_command('nnoremap <C-x>b <C-o>:Buffers<CR>')
api.nvim_command('omap <M-b> <Left>')
api.nvim_command('omap <M-e> <End>')
api.nvim_command('onoremap <M-f> <C-o>e<Right>')
api.nvim_command('inoremap <C-a> <C-o>^')
api.nvim_command('inoremap <C-e> <C-o>$')

-- -- Move in command line mode using hjkl
-- for b in [["<C-h>", "<left>"],
-- 	\ ["<C-j>", "<down>"],
-- 	\ ["<C-k>", "<up>"],
-- 	\ ["<C-l>", "<right>"],
-- 	\ ["<C-a>", "<Home>"],
-- 	\ ["<C-e>", "<End>"]]
--     execute('lnoremap ' . b[0] . ' ' . b[1])
--     execute('cnoremap ' . b[0] . ' ' . b[1])
--     " Warning: Unexpected behavior might ensue when it comes to closing
--     " completion menu because of <C-e>
--     execute('inoremap <expr> ' . b[0] . ' (pumvisible() ? "\<C-e>" : "") . "\' . b[1] . '"')
-- endfor

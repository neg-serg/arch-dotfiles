-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ tpope/vim-dispatch.git                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'tpope/vim-dispatch', -- provide async build
        config=function()
            map('n', 'MK', ':Make -j9')
            map('n', 'MC', ':Make clean<cr>')
            map('n', '[QLeader]cc', ':Make -j10<cr>')
            map('n', '[QLeader]mc', ':Make distclean<cr>')
        end,
        keys={'MK','MC','[QLeader]cc','[QLeader]mc'},
        cmd={'Dispatch','Make','Focus','Start'}}

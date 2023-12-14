-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ junegunn/vim-easy-align                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'junegunn/vim-easy-align', -- use easy-align, instead of tabular
    config=function() 
        map('n', 'ga', '<Plug>(EasyAlign)')
        map('x', 'ga', '<Plug>(EasyAlign)')
    end, keys={'ga'}}

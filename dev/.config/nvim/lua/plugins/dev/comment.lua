-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ numToStr/Comment.nvim                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'numToStr/Comment.nvim', -- modern commenter
    config=function()
        local ok, comment = pcall(require, 'Comment')
        if not ok then return end
        comment.setup()
    end, 
    lazy=true,
    keys={
        {'gbc',mode='n', desc='Comment toggle current block'},
        {'gb',mode={'n','o'}, desc='Comment toggle blockwise'},
        {'gb',mode='x', desc='Comment toggle blockwise (visual)'},
        {'gcc',mode='n', desc='Comment toggle current line'},
        {'gc',mode={'n','o'}, desc='Comment toggle linewise'},
        {'gc',mode='x', desc='Comment toggle linewise (visual)'},
}}

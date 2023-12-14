-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ L3MON4D3/LuaSnip                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'L3MON4D3/LuaSnip', -- snippets engine
    tag="v2.1.1",
    config=function()
        local status, vscode_snips = pcall(require, 'luasnip.loaders.from_vscode')
        if (not status) then return end
        vscode_snips.lazy_load()    
    end,
    dependencies={
        'rafamadriz/friendly-snippets', -- additional snippets'
        'hrsh7th/nvim-cmp'}, -- autocompletion engine
    event={'BufRead','BufNewFile','InsertEnter'}}

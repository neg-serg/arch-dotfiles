-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ hrsh7th/nvim-cmp                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local cmp = require('cmp')
local luasnip = require("luasnip")

vim.cmd([[
    hi CmpItemKindDefault guifg=#0C2430'
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
]])

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i','c'}),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i','c'}),
        ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
        -- disabled for autopairs mapping
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback()
            end
        end, { 'i', 's', }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback()
            end
        end, {'i','s',}),
    },
    view = {entries = 'native'},
    window = {
        completion = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, scrollbar = "║"},
        documentation = {
            winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
            scrollbar = "║"
        }},
    experimental = { ghost_text = true, },
    snippet = {expand = function(args) require'luasnip'.lsp_expand(args.body) end},
    cmp.setup.filetype('org', {
        sources = cmp.config.sources({
            {name = 'luasnip'},
            {name = 'orgmode'},
            {name = 'buffer'},
            {name = 'path'},
        })
    }),
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            {name = 'cmp_git'},  -- You can specify the `cmp_git` source if you were installed it.
            {name = 'buffer'},
        }
        )
    }),
    sources = cmp.config.sources({
        {name = 'luasnip'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'path'},
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require 'cmp-under-comparator'.under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {},
})

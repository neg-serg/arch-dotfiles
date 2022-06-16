-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ hrsh7th/nvim-cmp                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-cmp"] and _G.packer_plugins["nvim-cmp"].loaded then
    local cmp = require('cmp')

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
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i','c'}),
            ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
            -- disabled for autopairs mapping
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item()
                elseif has_words_before() then cmp.complete()
                else fallback()
                end
            end, { 'i', 's', }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {'i','s',}),
        },
        view = { entries = 'native' },
        window = {
            completion = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, scrollbar = "║"},
            documentation = {
                winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
                border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
                scrollbar = "║"
            }},
        experimental = {
            native_menu = false,
            ghost_text = true,
        },
        sources = cmp.config.sources({
            {name = 'nvim_lsp'},
            {name = 'nvim_lua'},
            {name = 'buffer'},
            {name = 'path'},
            {name = 'neorg'},
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
        formatting = {
            format = require('lspkind').cmp_format({
                mode = 'symbol',
                symbol_map = {
                    Text = "",
                    Method = "",
                    Function = "",
                    Constructor = "",
                    Field = "",
                    Variable = "[]",
                    Class = "",
                    Interface = "",
                    Module = "",
                    Property = "",
                    Unit = "",
                    Value = "",
                    Enum = "練",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "",
                    Event = "",
                    Operator = "",
                    TypeParameter = "<>"
                },
                menu = {
                    buffer = '[buf]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[VimApi]',
                    path = '',
                    luasnip = '[snip]',
                },
            }),
        },
    })
    cmp.setup.cmdline('/', {
        sources = { {name = 'buffer'}, },
    })
end

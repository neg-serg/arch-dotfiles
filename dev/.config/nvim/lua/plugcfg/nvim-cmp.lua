local M = {}

M.init = function()
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
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- disabled for autopairs mapping
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {'i','s',}),
    },
    documentation = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
    },
    experimental = {
      ghost_text = true,
    },
    sources = cmp.config.sources({
      {name = 'nvim_lsp'},
      {name = 'nvim_lua'},
      {name = 'buffer'},
      {name = 'path'},
      {name = 'neorg'},
    }),
    formatting = {
      format = require('lspkind').cmp_format({
        symbol_map = {
          Text = "",
          Method = "ﬦ",
          Function = "ﬦ",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "渚",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "פּ",
          Event = "",
          Operator = "",
          TypeParameter = ""
        },
        with_text = true,
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
    sources = {
      {name = 'buffer'},
    },
  })
end

return M

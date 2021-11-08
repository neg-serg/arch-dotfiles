local M = {}

M.init = function()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  vim.cmd([[
  hi CmpItemKindDefault guifg=#0C2430'
  autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
  ]])

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
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
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
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
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
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
      {name = 'luasnip'},
      {name = 'path'},
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

M.autopairs = function()
  require('nvim-autopairs').setup({
    disable_filetype = {'TelescopePrompt', 'vim'},
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

return M

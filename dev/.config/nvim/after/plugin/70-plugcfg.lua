-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ notjedi/nvim-rooter.lua                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-rooter.lua"] and _G.packer_plugins["nvim-rooter.lua"].loaded then
    require('nvim-rooter').setup {
        rooter_patterns = {'.git', '.hg', '.svn'},
        trigger_patterns = {'*'},
        manual = false,
    }
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ luukvbaal/nnn.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nnn.nvim"] and _G.packer_plugins["nnn.nvim"].loaded then
    require("nnn").setup({
        picker = {
            style = {
                width = 1.0,      -- percentage relative to terminal size when < 1, absolute otherwise
                height = 1.0,     -- ^
                xoffset = 0.0,    -- ^
                yoffset = 0.0,    -- ^
                border = "none"   -- border decoration for example "rounded"(:h nvim_open_win)
            },
            session = "shared",      -- or "global" / "local" / "shared"
        },
        auto_open = {
            setup = nil,
            tabpage = nil,
            empty = false,
            ft_ignore = { "gitcommit" }
        },
        replace_netrw = "picker",
        auto_close = false,  -- close tabpage/nvim when nnn is last window
        buflisted = false,   -- wether or not nnn buffers show up in the bufferlist
        window_nav = "<C-l>"
    })
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ haya14busa/vim-asterisk                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-asterisk"] and _G.packer_plugins["vim-asterisk"].loaded then
    map('n', '*',   '<Plug>(asterisk-#)')
    map('n', '#',   '<Plug>(asterisk-*)')
    map('n', 'g*',  '<Plug>(asterisk-g#)')
    map('n', 'g#',  '<Plug>(asterisk-g*)')
    map('n', 'z*',  '<Plug>(asterisk-z#)')
    map('n', 'gz*', '<Plug>(asterisk-gz#)')
    map('n', 'z#',  '<Plug>(asterisk-z*)')
    map('n', 'gz#', '<Plug>(asterisk-gz*)')
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ gelguy/wilder.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["wilder.nvim"] and _G.packer_plugins["wilder.nvim"].loaded then
    local wilder = require('wilder')
    wilder.setup({
      modes = {':'},
      next_key = '<C-e>',
      previous_key = '<S-Tab>',
      accept_key = '<Tab>'
    })
    wilder.set_option('use_python_remote_plugin', 0)
    wilder.set_option('noselect', 0)
    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 2,
        }),
        wilder.python_file_finder_pipeline({
            file_command = {'fd', '-tf'},
            dir_command = {'fd', '-td'},
            filters = {'fuzzy_filter', 'difflib_sorter'},
        }),
        wilder.vim_search_pipeline()
      )
    })
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ folke/trouble.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["trouble.nvim"] and _G.packer_plugins["trouble.nvim"].loaded then
    map('n', ',xx', '<cmd>TroubleToggle<cr>')

    require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list
        icons = true, -- use dev-icons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            close = "q", -- close the list
            refresh = "R", -- manually refresh
            jump = "<cr>", -- jump to the diagnostic or open / close folds
            toggle_mode = "m", -- toggle between "workspace" and "document" mode
            toggle_preview = "P", -- toggle auto_preview
            preview = "p", -- preview the diagnostic location
            close_folds = "zM", -- close all folds
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            open_folds = "zR", -- open all folds
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = ""
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neovim/nvim-lspconfig                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-lspconfig"] and _G.packer_plugins["nvim-lspconfig"].loaded then
    local nvim_lsp = require('lspconfig')
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- Mappings.
        local opts = { noremap=true, silent=true }
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', '<C-K>', '<cmd>lua require("lsp_signature").signature()<cr>', opts)
        buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", })<cr>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
        buf_set_keymap('n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>', opts)
        buf_set_keymap('n', '<leader>ge', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>', opts)
        buf_set_keymap('n', '<leader>gf', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
        buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('v', '<leader>ga', '<cmd>lua require("telescope.builtin").lsp_range_code_actions()<cr>', opts)
    end

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
    })

    require('lspconfig').pyright.setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local lsp_installer = require("nvim-lsp-installer")
    -- Register a handler that will be called for all installed servers.
    -- Alternatively, you may also register handlers on specific server instances instead (see example below).
    lsp_installer.on_server_ready(function(server)
        local opts = {}
        server:setup(opts)
    end)
end
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
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ windwp/nvim-autopairs                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-autopairs"] and _G.packer_plugins["nvim-autopairs"].loaded then
    require('nvim-autopairs').setup({
        disable_filetype = {"TelescopePrompt"},
        disable_in_macro = false,  -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
        enable_moveright = true,
        enable_afterquote = true,  -- add bracket pairs after quote
        enable_check_bracket_line = true,  -- check bracket in same line
        check_ts = true,
        map_cr = true,
        map_bs = true,  -- map the <BS> key
        map_c_w = true, -- map <C-w> to delete an pair if possible
    })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char={ tex=''}}))
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ lewis6991/gitsigns.nvim                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["gitsigns.nvim"] then
    require('gitsigns').setup {
      signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      numhl = false,
      linehl = false,
      keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
      },
      watch_gitdir = {interval = 500, follow_files = true},
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      diff_opts = { algorithm = "histogram", internal = true, indent_heuristic = true, },
    }
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ tpope/vim-dispatch.git                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-dispatch.git"] and _G.packer_plugins["vim-dispatch.git"].loaded then
    map('n', 'MK', ':Make -j9')
    map('n', 'MC', ':Make clean<cr>')
    map('n', '[QLeader]cc', ':Make -j10<cr>')
    map('n', '[QLeader]mc', ':Make distclean<cr>')
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ mfussenegger/nvim-dap                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-dap"] and _G.packer_plugins["nvim-dap"].loaded then
    local M = {}
    local vim_fn = vim.fn
    local api = vim.api
    local dap  = require('dap')
    dap.adapters.python = {
          type = 'executable';
          command = 'python';
          args = { '-m', 'debugpy.adapter' };
    }
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
      },
    }
    dap.adapters.cpp = {
        type = 'executable',
        name = "cppdbg",
        command = "lldb-vscode",
        args = {},
        attach = {
            pidProperty = "processId",
            pidSelect = "ask"
        }
    }

    local function build_cpp()
        local file_name = vim_fn.expand('%:p')
        local file_name_no_extension = vim_fn.expand('%:p:r')
        vim_fn.system('g++ '..file_name..' -g -std=c++11 -D LOCAL_SYS -o '..file_name_no_extension)
    end

    dap.configurations.cpp  = {
        {
            type = "cpp",
            name = "run_file",
            request = "launch",
            program = function ()
                build_cpp()
                return vim_fn.expand('%:p:r')
            end,
            args = {},
            cwd = vim_fn.getcwd(),
            externalConsole = false,
            MIMode ="gdb",
            MIDebuggerPath = "gdb"
        }
    }

    local dap_keymap = {
        n = {
            ["dc"] = 'continue()',
            ["db"] = 'toggle_breakpoint()',
            ["dB"] = "toggle_breakpoint(vim.fn.input('Breakpoint condition: '))",
            ["dr"] = "repl.open()",
            ["dR"] = "restart()",
            ["dl"] = "repl.run_last()",
            ["di"] = "step_into()",
            ["do"] = "step_over()",
            ["dO"] = "step_out()",
        }
    }

    local function set_keymap()
        for mode,map in pairs(dap_keymap) do
            for k,v in pairs(map) do
                api.nvim_buf_set_keymap(0, mode , "<leader>"..k, '<cmd>lua require"dap".'..v..'<CR>', {
                        nowait = true, noremap = true, silent = true
                    })
            end
        end
    end

    function M.on_attach()
        set_keymap()
    end

    M.init()
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ andymass/vim-matchup                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-matchup"] then
    vim.g.matchup_matchparen_enabled = 0
    vim.g.matchup_motion_enabled = 0
    vim.g.matchup_text_obj_enabled = 1
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ FooSoft/vim-argwrap                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-argwrap"] then
    api.nvim_command('nnoremap <silent> <leader>a :ArgWrap<CR>')
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ junegunn/vim-easy-align                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["vim-easy-align"] and _G.packer_plugins["vim-easy-align"].loaded then
    map('n', 'ga', '<Plug>(EasyAlign)')
    map('x', 'ga', '<Plug>(EasyAlign)')
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-treesitter/nvim-treesitter                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-treesitter"] and _G.packer_plugins["nvim-treesitter"].loaded then
    local tsconf = require'nvim-treesitter.configs'
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = {"src/parser.c", "src/scanner.cc"},
            branch = "main",
        },
    }

    parser_configs.norg_table = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
            files = { "src/parser.c" },
            branch = "main",
        },
    }

    parser_configs.norg_meta = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
            branch = "main",
            files = {"src/parser.c"},
        },
    }

    tsconf.setup {
      ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      context_commentstring = {enable = true},
      ignore_install = {'phpdoc', 'swift'},
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
        use_languagetree = true,
      },
      endwise = {enable = true,},
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable = {},  -- optional, list of language that will be disabled
      },
      rainbow = {
        enable = true,
        extended_mode = false, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 4000, -- Do not enable for files with more than 1000 lines, int
        colors = {'#4064be', '#4361b0', '#455fa3', '#465e9c', '#475c94', '#485a8c', '#485885'},
      },
      indent = {enable = true},
      autotag = {enable = false},
    }

    local ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
    require('nvim-treesitter.parsers').ft_to_lang = function(ft)
        if ft == 'zsh' then
            return 'bash'
        end
        return ft_to_lang(ft)
    end
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ kyazdani42/nvim-web-devicons                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["nvim-web-devicons"] and _G.packer_plugins["nvim-web-devicons"].loaded then
    vim.g.DevIconsEnableFoldersOpenClose = 1
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["html"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["js"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["json"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["jsx"] = "ﰆ"
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["md"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["vim"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["yaml"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols["yml"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols[".*vimrc.*"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols[".gitignore"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["package.json"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["package.lock.json"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["node_modules"] = ""
    vim.g.WebDevIconsUnicodeDecorateFileNodesPatternSymbols["webpack."] = "ﰩ"
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nathom/filetype.nvim                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["filetype.nvim"] and _G.packer_plugins["filetype.nvim"].loaded then
    require("filetype").setup({
        overrides = {
            shebang = {
                dash = "sh",
            },
        },
    })
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-neorg/neorg                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["neorg"] and _G.packer_plugins["neorg"].loaded then
    require('neorg').setup {
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.keybinds"] = { -- Configure core.keybinds
                config = { default_keybinds = true, neorg_leader = "<Space>" }},
            ["core.norg.concealer"] = {
                config = {
                    markup_preset = "dimmed",
                    icon_preset = "diamond",
                    icons = {
                        marker = { icon = " ", },
                        todo = { enable = true, },
                    },
                },
            }, -- Allows for use of icons
            ["core.gtd.base"] = { config = { workspace = "my_workspace" } },
            ["core.norg.qol.toc"] = {
                config = {
                    close_split_on_jump = false,
                    toc_split_placement = "left",
                },
            },
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                ["core.norg.completion"] = {config = {engine = "nvim-cmp"}},
                config = {workspaces = {my_workspace = "~/1st_level/"}}
            }
        },
    }
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ akinsho/git-conflict.nvim                                                    │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["git-conflict.nvim"] and _G.packer_plugins["git-conflict.nvim"].loaded then
    require('git-conflict').setup()
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ neg-serg/neg                                                                 │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["neg"] and _G.packer_plugins["neg"].loaded then
    require'neg' -- my pure-dark neovim colorscheme
end
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ antoinemadec/FixCursorHold.nvim                                              │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["FixCursorHold.nvim"] and _G.packer_plugins["FixCursorHold.nvim"].loaded then
    vim.g.cursorhold_updatetime = 100
end

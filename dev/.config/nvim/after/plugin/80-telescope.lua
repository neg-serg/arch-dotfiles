-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-telescope/telescope.nvim                                                │
-- └───────────────────────────────────────────────────────────────────────────────────┘
if _G.packer_plugins["telescope.nvim"] and _G.packer_plugins["telescope.nvim"].loaded then
    require('telescope').setup{
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never', '--no-heading', '--with-filename',
                '--line-number', '--column', '--smart-case'
            },
            dynamic_preview_title = true,
            prompt_prefix = "❯> ",
            selection_caret = "• ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "vertical",
            layout_config = {
                prompt_position = "bottom",
                horizontal = {mirror = false},
                vertical = {mirror = false},
            },
            file_sorter = require("telescope.sorters").get_fzy_sorter,
            file_ignore_patterns = { "node_modules", ".git" },
            generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
            path_display = { shorten = 5 },
            winblend = 8,
            border = {},
            borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
            color_devicons = true,
            use_less = false,
            set_env = {['COLORTERM'] = 'truecolor'},
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
        },
        extensions = {
            frecency = {
                show_unindexed = true,
                db_safe_mode = false,
                auto_validate = true,
            },
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown{}
            },
        },
        pickers = {
            find_files = {
                theme = "ivy",
                border = false,
                previewer = false,
                sorting_strategy = "descending",
                prompt_title = false,
                find_command={'rg','--files','--hidden','-g','!.git'},
                layout_config = {
                    height = 12
                },
            },
            oldfiles = {
                theme = "ivy",
                border = false,
                previewer = false,
                sorting_strategy = "descending",
                prompt_title = false,
            },
        },
    }

    require('telescope').load_extension('fzy_native')
    require("telescope").load_extension("ui-select")
    require('telescope').load_extension('cder')

    map('n', '<M-b>', '<Cmd>Telescope buffers<CR>')
    map('n', '<M-f>', '<Cmd>Telescope live_grep<CR>')
    map('n', '<M-C-o>', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
    map('n', '<M-o>', '<Cmd>Telescope lsp_document_symbols<CR>')
    map('n', '<M-d>', '<Cmd>Telescope lsp_document_diagnostics<CR>')
    map('n', "<leader>.", "<Cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy({layout_config = {height = 8}, border=false}))<CR>", {noremap=true, silent=true})
    map('n', '[Qleader]e', "<Cmd>lua require('telescope.builtin').find_files{}<CR>", {silent=true, noremap=true})
    map('n', '[Qleader]f', "<Cmd>lua require('telescope.builtin').live_grep{}<CR>", {silent=true, noremap=true})
    map('n', '[Qleader]c', "<Cmd>lua require('telescope.builtin').git_commits{}<CR>", {silent=true, noremap=true})
end

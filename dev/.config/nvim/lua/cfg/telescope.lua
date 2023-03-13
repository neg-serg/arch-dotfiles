-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-telescope/telescope.nvim                                                │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, telescope = pcall(require, 'telescope')
if (not status) then return end
telescope.setup{
    defaults={
        vimgrep_arguments={
            'rg',
            '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        dynamic_preview_title=true,
        prompt_prefix="❯> ",
        selection_caret="• ",
        entry_prefix="  ",
        initial_mode="insert",
        selection_strategy="reset",
        sorting_strategy="descending",
        layout_strategy="vertical",
        layout_config={
            prompt_position="bottom",
            horizontal={mirror=false},
            vertical={mirror=false},
        },
        file_sorter=require'telescope.sorters'.get_zf_sorter,
        file_ignore_patterns={
            "__pycache__/", "__pycache__/*",

			"build/",       "gradle/",  "node_modules/", "node_modules/*",
			"smalljre_*/*", "target/",  "vendor/*",

			".dart_tool/",  ".git/",   ".github/", ".gradle/",      ".idea/",        ".vscode/",

			"%.sqlite3",    "%.ipynb", "%.lock",   "%.pdb",
			"%.dll",        "%.class", "%.exe",    "%.cache", "%.pdf",  "%.dylib",
			"%.jar",        "%.docx",  "%.met",    "%.burp",  "%.mp4",  "%.mkv", "%.rar",
			"%.zip",        "%.7z",    "%.tar",    "%.bz2",   "%.epub", "%.flac","%.tar.gz",
        },
        media_files={
			-- filetypes whitelist
			filetypes={"png", "jpg", "mp4", "webm", "pdf"},
			find_cmd="fd" -- find command (defaults to `fd`)
		},
        generic_sorter= require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display={ shorten=8 },
        winblend=8,
        border={},
        borderchars={'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons=true,
        use_less=false,
        set_env={['COLORTERM']='truecolor'},
        file_previewer=require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer=require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer=require'telescope.previewers'.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker=require'telescope.previewers'.buffer_previewer_maker
    },
    extensions={
        fzy_native={
            override_generic_sorter=true,
            override_file_sorter=true,
        },
        undo = {
            use_delta = true,
            use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side = false,
            diff_context_lines = vim.o.scrolloff,
            entry_format = "state #$ID, $STAT, $TIME",
            mappings = {
                i = {
                    -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                    -- you want to replicate these defaults and use the following actions. This means
                    -- installing as a dependency of telescope in it's `requirements` and loading this
                    -- extension from there instead of having the separate plugin definition as outlined
                    -- above.
                    ["<cr>"] = require("telescope-undo.actions").yank_additions,
                    ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                    ["<C-cr>"] = require("telescope-undo.actions").restore,
                },
            },
        },
        frecency={
            show_scores=false,
            show_unindexed=true,
            ignore_patterns={ "*.git/*" },
            workspaces={}
        },
        ['zf-native']={
            file={
                enable = true, -- override default telescope file sorter
                highlight_results = true, -- highlight matching text in results
                match_filename = true, -- enable zf filename match priority
            },
            generic={
                enable = true, -- override default telescope generic item sorter
                highlight_results = true, -- highlight matching text in results
                match_filename = false, -- disable zf filename match priority
            },
        },
    },
    pickers={
        find_files={
            theme="ivy",
            border=false,
            previewer=false,
            sorting_strategy="descending",
            prompt_title=false,
            find_command={'rg','--files','--hidden','-g','!.git'},
            layout_config={
                height=12
            },
        },
        oldfiles={
            theme="ivy",
            border=false,
            previewer=false,
            sorting_strategy="descending",
            prompt_title=false,
        },
    },
}

-- require'telescope'.load_extension'fzy_native'
require'telescope'.load_extension'zf-native'
require'telescope'.load_extension'media_files'
require'telescope'.load_extension'heading'
require'telescope'.load_extension'undo'

local opts={silent=true, noremap=true}
map('n', '<S-b>', '<Cmd>lua require"telescope.builtin".buffers()<CR>', opts)
map('n', '<C-f>', "<Cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_ivy({layout_config={height=14},border=false}))<CR>", opts)
map('n', '<M-C-o>', '<Cmd>lua require"telescope.builtin".lsp_dynamic_workspace_symbols()<CR>', opts)
map('n', '<M-o>', '<Cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>', opts)
map('n', "<leader>.", "<Cmd>lua require'telescope'.load_extension'frecency'; require'telescope.builtin'.oldfiles(require('telescope.themes').get_ivy({layout_config={height=8},border=false}))<CR>", opts)
map('n', '[Qleader]e', "<Cmd>lua require'telescope.builtin'.find_files{}<CR>", opts)
map('n', '[Qleader]c', "<Cmd>lua require'telescope.builtin'.git_commits{}<CR>", opts)
map('n', '[Qleader]p', "<Cmd>lua require'telescope'.load_extension'projects'<CR><Cmd>Telescope projects<CR>", opts)

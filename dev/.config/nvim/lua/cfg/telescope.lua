-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-telescope/telescope.nvim                                                │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, telescope=pcall(require, 'telescope')
if (not status) then return end
local manix=telescope.load_extension'manix'
local pathogen=telescope.load_extension'pathogen'
local zoxide=telescope.load_extension'zoxide'
local sorters=require'telescope.sorters'
local previewers=require'telescope.previewers'
local builtin=require'telescope.builtin'
local actions=require'telescope.actions'
local long_find={'rg','--files','--hidden','-g','!.git'}
local short_find={'fd','-H','--ignore-vcs','-d','3'}
local ignore_patterns={
    "__pycache__/", "__pycache__/*",
    "build/",       "gradle/",  "node_modules/", "node_modules/*",
    "smalljre_*/*", "target/",  "vendor/*",
    ".dart_tool/",  ".git/",   ".github/", ".gradle/",      ".idea/",        ".vscode/",
    "%.sqlite3",    "%.ipynb", "%.lock",   "%.pdb",
    "%.dll",        "%.class", "%.exe",    "%.cache", "%.pdf",  "%.dylib",
    "%.jar",        "%.docx",  "%.met",    "%.burp",  "%.mp4",  "%.mkv", "%.rar",
    "%.zip",        "%.7z",    "%.tar",    "%.bz2",   "%.epub", "%.flac","%.tar.gz",
}

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
        file_ignore_patterns=ignore_patterns,
        path_display={shorten=8},
        winblend=8,
        border={},
        borderchars={'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons=true,
        use_less=false,
        file_previewer=previewers.vim_buffer_cat.new,
        grep_previewer=previewers.vim_buffer_vimgrep.new,
        qflist_previewer=previewers.vim_buffer_qflist.new,
        buffer_previewer_maker=previewers.buffer_previewer_maker
    },
    extensions={
        pathogen={use_last_search_for_live_grep=false},
        frecency={
            show_scores=false,
            show_unindexed=true,
            ignore_patterns=ignore_patterns,
            disable_devicons=false,
            use_sqlite=false,
            previewer=false,
            path_display={"relative"}
        },
        ["zf-native"]={
            file={ -- options for sorting file-like items
                enable=true, -- override default telescope file sorter
                highlight_results=true, -- highlight matching text in results
                match_filename=true, -- enable zf filename match priority
            },
            generic={ -- options for sorting all other items
                enable=true, -- override default telescope generic item sorter
                highlight_results=true, -- highlight matching text in results
                match_filename=false, -- disable zf filename match priority
            },
        },
        undo={
            use_delta=true,
            side_by_side=true,
            previewer=true,
            layout_strategy="flex",
            layout_config={
                horizontal={
                    prompt_position="bottom",
                    preview_width=0.70,
                },
                vertical={mirror=false},
                width=0.87,
                height=0.80,
                preview_cutoff=120,
            },
            mappings={
                i={
                    ['<CR>']=require'telescope-undo.actions'.yank_additions,
                    ['<S-CR>']=require'telescope-undo.actions'.yank_deletions,
                    ['<C-CR>']=require'telescope-undo.actions'.restore,
                },
            },
        },
        zoxide={
            mappings={
                ["<Enter>"]={action=function(selection) pathogen.find_files{cwd=selection.path} end},
                ["<Tab>"]={action=function(selection) pathogen.find_files{cwd=selection.path} end},
                ["<C-j>"]=actions.cycle_history_next,
				["<C-k>"]=actions.cycle_history_prev,
				["<Esc>"]=actions.close,
                ["<C-Enter>"]={action=function(_) end},
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
            find_command=short_find,
            layout_config={height=12},
        }
    },
}
local frecency=telescope.load_extension'frecency'
local zf_native=telescope.load_extension'zf-native'
local undo=telescope.load_extension'undo'

local opts={silent=true, noremap=true}
Map('n', 'E', function() vim.cmd'ProjectRoot'; pathogen.find_files{} end, opts)
Map('n', 'cd', function()
    telescope.load_extension'zoxide'.list(
        require'telescope.themes'.get_ivy(
            {layout_config={height=8}, border=false}
)) end, opts)
Map('n', "<leader>.", function()
    vim.cmd'Telescope frecency theme=ivy layout_config={height=12} sorting_strategy=descending' 
end, opts)
Map('n', '<C-f>', function()
    builtin.live_grep(
        require'telescope.themes'.get_ivy({
            layout_config={height=12},
            border=true
})) end, opts)
Map('n', '<M-C-o>', function()
    builtin.lsp_dynamic_workspace_symbols() 
end, opts)
Map('n', '<M-o>', function() 
    builtin.lsp_document_symbols() 
end, opts)
Map('n', '<leader>l', function()
    vim.cmd'chdir %:p:h'; pathogen.find_files{}
end, opts)
Map('n', '[Qleader]e', function()
    pathogen.find_files{} 
end, opts)

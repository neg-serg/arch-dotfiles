-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ nvim-telescope/telescope.nvim                                                │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, telescope=pcall(require, 'telescope')
if (not status) then return end
local sorters=require'telescope.sorters'
local previewers=require'telescope.previewers'
local builtin=require'telescope.builtin'
local actions=require'telescope.actions'
local pathogen=telescope.load_extension'pathogen'
local undo=telescope.load_extension'undo'
local zoxide=telescope.load_extension'zoxide'
local long_find = {'rg','--files','--hidden','-g','!.git'}
local short_find = {'fd','-H','--ignore-vcs','-d','3'}

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
        file_sorter=sorters.get_zf_sorter,
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
        generic_sorter=sorters.get_generic_fuzzy_sorter,
        path_display={ shorten=8 },
        winblend=8,
        border={},
        borderchars={'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons=true,
        use_less=false,
        set_env={['COLORTERM']='truecolor'},
        file_previewer=previewers.vim_buffer_cat.new,
        grep_previewer=previewers.vim_buffer_vimgrep.new,
        qflist_previewer=previewers.vim_buffer_qflist.new,
        buffer_previewer_maker=previewers.buffer_previewer_maker
    },
    extensions={
        pathogen={use_last_search_for_live_grep=false},
        undo={
            use_delta=true,
            use_custom_command=nil, -- setting this implies `use_delta=false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side=false,
            diff_context_lines=vim.o.scrolloff,
            entry_format="state #$ID, $STAT, $TIME",
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

local opts={silent=true, noremap=true}
Map('n', 'E', function() vim.cmd'ProjectRoot'; pathogen.find_files{} end, opts)
Map('n', 'cd', function()
    telescope.load_extension'zoxide'.list(
        require'telescope.themes'.get_ivy(
            {layout_config={height=8}, border=false}
)) end, opts)
Map('n', "<leader>.", function()
    builtin.oldfiles(
        require'telescope.themes'.get_ivy({
            layout_config={height=8},
            border=false
})) end, opts)
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

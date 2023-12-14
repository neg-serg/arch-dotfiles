-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ sindrets/diffview.nvim                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'sindrets/diffview.nvim', -- diff view for multiple files
    config=function()
        local status, diffview = pcall(require, 'diffview')
        if (not status) then return end
        local cb = require 'diffview.config'.diffview_callback
        local actions = require("diffview.actions")

        diffview.setup {
            diff_binaries=false, -- Show diffs for binaries
            enhanced_diff_hl=true, -- See ':h diffview-config-enhanced_diff_hl'
            use_icons=true, -- Requires nvim-web-devicons
            icons={folder_closed="", folder_open=""},
            signs={fold_closed="", fold_open=""},
            file_panel={
                listing_style="tree",               -- One of 'list' or 'tree'
                tree_options={                      -- Only applies when listing_style is 'tree'
                flatten_dirs=true,              -- Flatten dirs that only contain one single dir
                folder_statuses="only_folded",  -- One of 'never', 'only_folded' or 'always'.
            },
            win_config={position="left", width=35},
        },
        file_history_panel={win_config={position="bottom", height=16}},
        default_args={
            DiffviewOpen={},
            DiffviewFileHistory={},
        },
        hooks={}, -- See ':h diffview-config-hooks'
        view={
            default={layout="diff2_horizontal"},
            merge_tool={
                layout="diff3_horizontal",
                disable_diagnostics=true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
            },
            file_history={layout="diff2_horizontal"},
        },
        keymaps={
            view={
                ["g<C-x>"]=actions.cycle_layout,          -- Cycle through available layouts.
                ["[x"]=actions.prev_conflict,             -- In the merge_tool: jump to the previous conflict
                ["]x"]=actions.next_conflict,             -- In the merge_tool: jump to the next conflict
                ["<leader>co"]=actions.conflict_choose("ours"),   -- Choose the OURS version of a conflict
                ["<leader>ct"]=actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
                ["<leader>cb"]=actions.conflict_choose("base"),   -- Choose the BASE version of a conflict
                ["<leader>ca"]=actions.conflict_choose("all"),    -- Choose all the versions of a conflict
                ["dx"]=actions.conflict_choose("none"),   -- Delete the conflict region
            },
            diff1={ --[[ Mappings in single window diff layouts ]] },
            diff2={ --[[ Mappings in 2-way diff layouts ]] },
            diff3={
                -- Mappings in 3-way diff layouts
                {{"n","x"},"2do",actions.diffget("ours")},  -- Obtain the diff hunk from the OURS version of the file
                {{"n","x"},"3do",actions.diffget("theirs")},-- Obtain the diff hunk from the THEIRS version of the file
            },
            diff4={
                -- Mappings in 4-way diff layouts
                {{"n","x"},"1do",actions.diffget("base")},  -- Obtain the diff hunk from the BASE version of the file
                {{"n","x"},"2do",actions.diffget("ours")},  -- Obtain the diff hunk from the OURS version of the file
                {{"n","x"},"3do",actions.diffget("theirs")},-- Obtain the diff hunk from the THEIRS version of the file
            },
            file_panel={
                ["g<C-x>"]=actions.cycle_layout,
                ["[x"]=actions.prev_conflict,
                ["]x"]=actions.next_conflict,
            },
            file_history_panel={
                ["g<C-x>"]=actions.cycle_layout,
            },
        },
        key_bindings={
            disable_defaults=false, -- Disable the default key bindings
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            view={
                ["<tab>"]=cb("select_next_entry"), -- Open the diff for the next file
                ["<s-tab>"]=cb("select_prev_entry"), -- Open the diff for the previous file
                ["gf"]=cb("goto_file"), -- Open the file in a new split in previous tabpage
                ["<C-w><C-f>"]=cb("goto_file_split"), -- Open the file in a new split
                ["<C-w>gf"]=cb("goto_file_tab"), -- Open the file in a new tabpage
                ["<leader>e"]=cb("focus_files"), -- Bring focus to the files panel
                ["<leader>b"]=cb("toggle_files"), -- Toggle the files panel.
            },
            file_panel={
                ["j"]=cb("next_entry"), -- Bring the cursor to the next file entry
                ["<down>"]=cb("next_entry"),
                ["k"]=cb("prev_entry"), -- Bring the cursor to the previous file entry.
                ["<up>"]=cb("prev_entry"),
                ["<cr>"]=cb("select_entry"), -- Open the diff for the selected entry.
                ["o"]=cb("select_entry"),
                ["<2-LeftMouse>"]=cb("select_entry"),
                ["-"]=cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                ["S"]=cb("stage_all"), -- Stage all entries.
                ["U"]=cb("unstage_all"), -- Unstage all entries.
                ["X"]=cb("restore_entry"), -- Restore entry to the state on the left side.
                ["R"]=cb("refresh_files"), -- Update stats and entries in the file list.
                ["<tab>"]=cb("select_next_entry"),
                ["<s-tab>"]=cb("select_prev_entry"),
                ["gf"]=cb("goto_file"),
                ["<C-w><C-f>"]=cb("goto_file_split"),
                ["<C-w>gf"]=cb("goto_file_tab"),
                ["i"]=cb("listing_style"), -- Toggle between 'list' and 'tree' views
                ["f"]=cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
                ["<leader>e"]=cb("focus_files"),
                ["<leader>b"]=cb("toggle_files"),
            },
            file_history_panel={
                ["g!"]=cb("options"), -- Open the option panel
                ["<C-A-d>"]=cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
                ["y"]=cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
                ["zR"]=cb("open_all_folds"),
                ["zM"]=cb("close_all_folds"),
                ["j"]=cb("next_entry"),
                ["<down>"]=cb("next_entry"),
                ["k"]=cb("prev_entry"),
                ["<up>"]=cb("prev_entry"),
                ["<cr>"]=cb("select_entry"),
                ["o"]=cb("select_entry"),
                ["<2-LeftMouse>"]=cb("select_entry"),
                ["<tab>"]=cb("select_next_entry"),
                ["<s-tab>"]=cb("select_prev_entry"),
                ["gf"]=cb("goto_file"),
                ["<C-w><C-f>"]=cb("goto_file_split"),
                ["<C-w>gf"]=cb("goto_file_tab"),
                ["<leader>e"]=cb("focus_files"),
                ["<leader>b"]=cb("toggle_files"),
            },
            option_panel={
                ["<tab>"]=cb("select"),
                ["q"]=cb("close"),
            },
        },
    }

    map('n', '<C-S-g>', '<Cmd>DiffviewFileHistory<CR>')
    map('n', '\\a', '<Cmd>DiffviewOpen<CR>')
    map('n', '\\c', '<Cmd>DiffviewClose<CR>')
    map('n', '\\r', '<Cmd>DiffviewRefresh<CR>')
    map('n', '\\f', '<Cmd>DiffviewToggleFiles<CR>')
    map('n', '\\0', '<Cmd>DiffviewOpen HEAD<CR>')
    map('n', '\\1', '<Cmd>DiffviewOpen HEAD^<CR>')
    map('n', '\\2', '<Cmd>DiffviewOpen HEAD^^<CR>')
    map('n', '\\3', '<Cmd>DiffviewOpen HEAD^^^<CR>')
    map('n', '\\4', '<Cmd>DiffviewOpen HEAD^^^^<CR>')
    end,
    cmd={'DiffviewOpen','DiffviewFileHistory'},
    dependencies={'nvim-tree/nvim-web-devicons','nvim-lua/plenary.nvim'},
    keys={'<C-S-G>','\\a','\\c','\\r','\\f','\\0','\\1','\\2','\\3','\\4'}, lazy=true}

-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ folke/trouble.nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'folke/trouble.nvim', -- pretty list for diagnostics
    dependencies={'nvim-tree/nvim-web-devicons'},
    cmd={'Trouble','TroubleClose','TroubleToggle','TroubleRefresh'},
    config=function() 
        local status, trouble=pcall(require, 'trouble')
        if (not status) then return end
        map('n', '<leader>x', '<cmd>TroubleToggle<cr>')
        trouble.setup {
            position='bottom', -- position of the list can be: bottom, top, left, right
            height=10, -- height of the trouble list
            icons=true, -- use dev-icons for filenames
            mode='workspace_diagnostics', -- 'workspace_diagnostics', 'document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
            fold_open='', -- icon used for open folds
            fold_closed='', -- icon used for closed folds
            group=true, -- group results by file
            padding=true, -- add an extra new line on top of the list
            action_keys={ -- key mappings for actions in the trouble list
            cancel='<esc>', -- cancel the preview and get back to your last window / buffer / cursor
            close_folds='zM', -- close all folds
            close='q', -- close the list
            jump={'<cr>', '<tab>'}, -- jump to the diagnostic or open / close folds
            open_folds='zR', -- open all folds
            open_split={'<c-x>','i'}, -- open buffer in new split
            open_vsplit={'<c-v>','s'}, -- open buffer in new vsplit
            preview='p', -- preview the diagnostic location
            refresh='R', -- manually refresh
            toggle_mode='m', -- toggle between 'workspace' and 'document' mode
            toggle_preview='P', -- toggle auto_preview
            previous='k', -- preview item
            next='j' -- next item
        },
        indent_lines=true, -- add an indent guide below the fold icons
        auto_open=false, -- automatically open the list when you have diagnostics
        auto_close=false, -- automatically close the list when you have no diagnostics
        auto_preview=false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
        use_diagnostic_signs=true,
        signs={
            error="",
            warning="",
            hint="",
            information=""
        },
        use_lsp_diagnostic_signs=false -- enabling this will use the signs defined in your lsp client
    }
    end,
    keys={'<leader>x'}, lazy=true}

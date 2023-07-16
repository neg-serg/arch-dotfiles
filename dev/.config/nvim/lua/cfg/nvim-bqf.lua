-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ kevinhwang91/nvim-bqf                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
local status, bqf=pcall(require, 'bqf')

bqf.setup({
    auto_enable=true,
    auto_resize_height=true, -- highly recommended enable
    preview={
        win_height=12,
        win_vheight=12,
        delay_syntax=80,
        border={'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
        show_title=false,
        should_preview_cb=function(bufnr, qwinid)
            local ret=true
            local bufname=vim.api.nvim_buf_get_name(bufnr)
            local fsize=vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
                ret=false -- skip file size greater than 100k
            elseif bufname:match('^fugitive://') then
                ret=false -- skip fugitive buffer
            end
            return ret
        end
    },
    -- make `drop` and `tab drop` to become preferred
    func_map={
        drop='o',
        openc='O',
        split='<C-s>',
        tabdrop='<C-t>',
        -- set to empty string to disable
        tabc='',
        ptogglemode='z,',
    },
    filter={
        fzf={
            action_for={['ctrl-s']='split', ['ctrl-t']='tab drop'},
            extra_opts={'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
})

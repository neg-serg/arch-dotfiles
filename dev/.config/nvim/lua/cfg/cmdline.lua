local fineline = require'fine-cmdline'
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
vim.opt.cmdheight=0
fineline.setup({
    cmdline = {
        enable_keymaps=true,
        smart_history=true,
        prompt=':'
    },
    popup = {
        position={ row='100%', col='0%'},
        size={ width='100%'},
        border={ style='none', },
        win_options={ winhighlight='Normal:Normal,FloatBorder:FloatBorder', },
    },
    hooks = {
        set_keymaps = function(imap, _)
            imap('<Esc>', fineline.fn.close)
            imap('<C-c>', fineline.fn.close)
            imap('<Up>', fineline.fn.up_search_history)
            imap('<Down>', fineline.fn.down_search_history)
        end
    }
})

require('toggleterm').setup({
    size=10,
    open_mapping='<F4>',
    hide_numbers=true,
    shade_filetypes={},
    shade_terminals=true,
    start_in_insert=true,
    persist_size=true,
    direction='horizontal',
    close_on_exit=true,
    float_opts={
        border='curved',
        width=70,
        height=20,
        winblend=0,
        highlights={border='Special', background='Normal'},
    },
})

local Terminal=require('toggleterm.terminal').Terminal
navigator=Terminal:new({
    cmd='zsh',
    env={NEOVIM_TERMINAL=1}
})
map('n', '<leader>l', '<Cmd>lua navigator:toggle()<CR>', {noremap=true, silent=true})

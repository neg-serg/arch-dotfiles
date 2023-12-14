-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ mikesmithgh/kitty-scrollback.nvim                                            │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'mikesmithgh/kitty-scrollback.nvim', -- kitty modern neovim scrollback support
    enabled=true, lazy=true,
    cmd={'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth'},
    event={'User KittyScrollbackLaunch'},
    opts={kitty_get_text={extent='all', ansi=false}},
    version='*', -- latest stable version, may have breaking changes if major version changed
    config=function() require'kitty-scrollback'.setup() end}

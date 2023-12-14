-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ goolord/alpha-nvim                                                           │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'goolord/alpha-nvim',
    config=function()
        local dashboard=require'alpha.themes.dashboard'
        dashboard.section.header.val={
            ' ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓',
            ' ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒',
            '▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░',
            '▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ',
            '▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒',
            '░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░',
            '░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░',
            '   ░   ░ ░     ░░   ▒ ░░      ░   ',
            '         ░      ░   ░         ░   ',
            '               ░                  ',
        }
        dashboard.section.header.opts={position='center', hl='Comment'}
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
        dashboard.section.buttons.val={}
    end,
    event='VimEnter', dependencies={'nvim-tree/nvim-web-devicons'}}

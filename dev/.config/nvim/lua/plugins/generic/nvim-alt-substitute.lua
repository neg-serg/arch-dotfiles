-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ chrisgrieser/nvim-alt-substitute                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'chrisgrieser/nvim-alt-substitute', -- alternative substitute
    config=function() require'alt-substitute'.setup() end,
    event={'CmdlineEnter'}}  -- lazy-loading with `cmd =` does not work well with incremental preview

require('leap').setup {
    max_aot_targets = nil,
    highlight_unlabeled = false,
    case_sensitive = false,
    character_classes = {},
    special_keys = {
        repeat_search = '<enter>',
        next_match    = '<enter>',
        prev_match    = '<tab>',
        next_group    = '<space>',
        prev_group    = '<tab>',
        eol           = '<space>',
    },
}

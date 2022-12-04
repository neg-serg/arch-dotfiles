-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ windwp/nvim-autopairs                                                        │
-- └───────────────────────────────────────────────────────────────────────────────────┘
require('nvim-autopairs').setup({
    disable_filetype={"TelescopePrompt"},
    disable_in_macro=false,  -- disable when recording or executing a macro
    disable_in_visualblock=false, -- disable when insert after visual block mode
    ignored_next_char=string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
    enable_moveright=true,
    enable_afterquote=true,  -- add bracket pairs after quote
    enable_check_bracket_line=true,  -- check bracket in same line
    check_ts=true,
    map_cr=true,
    map_bs=true,  -- map the <BS> key
    map_c_w=true, -- map <C-w> to delete an pair if possible
})
local cmp_autopairs=require('nvim-autopairs.completion.cmp')
local cmp=require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char={ tex=''}}))

local Rule=require('nvim-autopairs.rule')
local npairs=require('nvim-autopairs')
npairs.add_rules {
    -- before   insert  after
    --  (|)     ( |)	( | )
    Rule(' ', ' ')
        :with_pair(function (opts)
            local pair=opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
    Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
        :use_regex(true)
        :set_end_pair_length(2),
}

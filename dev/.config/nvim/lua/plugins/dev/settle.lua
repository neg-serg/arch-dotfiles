-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ zegervdv/settle.nvim                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
return {'zegervdv/settle.nvim',
  opt=true, cmd={'SettleInit'},
  config=function()
    require'settle'.setup {
      wrap=true, symbol='!',
      keymaps={
        next_conflict='-n',
        prev_conflict='-N',
        use_ours='-u1',
        use_theirs='-u2',
        close='-q',
      },
    }
  end}

-- [merge]
--   tool = settle
-- [mergetool "settle"]
--   cmd = "nvim -f $BASE $LOCAL $REMOTE $MERGED -c 'SettleInit'"
--   trustExitCode = true

-- [merge-tools]
-- settle.executable = nvim
-- settle.args = -f $base $local $other $output -c 'SettleInit'
-- settle.premerge = keep
-- settle.priority = 1

require('auto-session').setup({
  log_level = 'error',
  pre_save_cmds = {},
  auto_session_enable_last_session = true,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
})

map('n', '<leader>sl', ':silent RestoreSession<cr>')
map('n', '<leader>ss', ':SaveSession<cr>')

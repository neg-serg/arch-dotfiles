require('auto-session').setup({
  log_level = 'error',
  pre_save_cmds = { 'NvimTreeClose', 'cclose', 'lua vim.notify.dismiss()' },
  auto_session_enable_last_session = true,
  auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = nil
})

--[[ -- session
map('n', '<leader>sl', ':silent RestoreSession<cr>')
map('n', '<leader>ss', ':SaveSession<cr>') ]]

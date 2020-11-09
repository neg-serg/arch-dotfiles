local a = vim.api

local M = {}

function M.mapper(mode, key, result, where)
  if where == 'everywhere' then
    a.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
  else
    a.nvim_buf_set_keymap(0, mode, key, result, { noremap = true, silent = true })
  end
end

function M.warn(msg)
  vim.cmd("echohl WarningMsg | echo '"..msg.."' | echohl Normal")
end

return M

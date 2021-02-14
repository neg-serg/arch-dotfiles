-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ pearofducks/ansible-vim                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
vim.api.nvim_exec([[
augroup ansible_vim_fthosts
  autocmd!
  autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
  autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
augroup END
]], true)

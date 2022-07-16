local filetype_ok, _ = pcall(require, "filetype")
if not filetype_ok then
	return
end
-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
-- vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 1 -- do not run filetype detect

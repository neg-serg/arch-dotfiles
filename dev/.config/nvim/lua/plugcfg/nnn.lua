require("nnn").setup({
	picker = {
		cmd = "nnn",       -- command override (-p flag is implied)
		style = {
			width = 1.0,      -- percentage relative to terminal size when < 1, absolute otherwise
			height = 1.0,     -- ^
			xoffset = 0.0,    -- ^
			yoffset = 0.0,    -- ^
			border = "single" -- border decoration for example "rounded"(:h nvim_open_win)
		},
		session = "",      -- or "global" / "local" / "shared"
	},
	replace_netrw = "picker",
	auto_close = false,  -- close tabpage/nvim when nnn is last window
	window_nav = "<C-l>"
})

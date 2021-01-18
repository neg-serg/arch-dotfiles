function vimMotions()
	-- make `_` move to the first non-whitespace character
	vis:command('map! normal _ ^')

end

function vimCommands()
	-- support :cq
	vis:command_register("cq", function(argv, force, win, selection, range)
		vis:command("qall")
		os.exit(-1)
	end)
end

function vimCompatibilityInit()
	vimMotions()
	vimCommands()
end

vimCompatibilityInit()

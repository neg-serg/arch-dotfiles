vim.api.nvim_exec([[
function! CreateFoldersAndWrite(bang)
    let l:one = expand('%:p')
    let l:two = substitute(l:one, '^[A-Za-z]*', '', '')
    if l:one != l:two
        echo 'Sorry but buffer is not a real file'
        return
    endif
    silent execute('!mkdir -p %:h')
    try
        if (a:bang)
            execute(':w!')
        else
            execute(':w')
        endif
    catch "E166: Can't open linked file for writing"
        redraw!
        SudoWrite
    endtry
endfunction
]], true)

vim.api.nvim_exec([[
function! Redir(cmd, rng, start, end)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
		if a:rng == 0
			let output = systemlist(cmd)
		else
			let joined_lines = join(getline(a:start, a:end), '\n')
			let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
			let output = systemlist(cmd . " <<< $" . cleaned_lines)
		endif
	else
		redir => output
		execute a:cmd
		redir END
		let output = split(output, "\n")
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, output)
endfunction
]], true)

vim.cmd("command! -bang -nargs=* -complete=file E e<bang> <args>")
vim.cmd("command! -bang W :call CreateFoldersAndWrite(<bang>0)")
vim.cmd("command! -bang -nargs=* -complete=file Wq wq<bang> <args>")
vim.cmd("command! -bang -nargs=* -complete=file WQ wq<bang> <args>")
vim.cmd("command! -bang Q q<bang>")
vim.cmd("command! -bang QA qa<bang>")
vim.cmd("command! -bang Qa qa<bang>")
vim.cmd("command! -bar SudoWrite exe \'w !sudo tee >/dev/null %:p:S\' | setl nomod")
vim.cmd("command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)")
vim.cmd("command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d ' ' | xclip -i -selection clipboard")
vim.cmd("command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d ' ' | xclip -i -selection clipboard")
vim.cmd("command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d ' ' | xclip -i -selection clipboard")
vim.cmd("command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d ' ' | xclip -i -selection clipboard")
vim.cmd("command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d ' ' | xclip -i -selection clipboard")
vim.cmd("command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d ' ' | xclip -i -selection clipboard")

if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

command! PackInstall update <BAR> runtime plugins.vim <BAR> call packager#install({ 'on_finish': 'silent !neovim-packtags' })
command! -bang PackUpdate update <BAR> runtime plugins.vim <BAR> call packager#update({ 'force_hooks': '<bang>', 'on_finish': 'silent !neovim-packtags' })
command! PackClean update <BAR> runtime plugins.vim <BAR> call packager#clean()
command! PackStatus update <BAR> runtime plugins.vim <BAR> call packager#status()

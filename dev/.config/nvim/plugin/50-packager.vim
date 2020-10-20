if exists('g:loaded_packager')
	finish
endif
let g:loaded_packager = 1

function! PackInit() abort
    packadd vim-packager
    call packager#init({'jobs': 0})
    source $XDG_CONFIG_HOME/nvim/pack-cfg/51-pack-main.vim
    source $XDG_CONFIG_HOME/nvim/pack-cfg/52-pack-appearance.vim
    source $XDG_CONFIG_HOME/nvim/pack-cfg/53-pack-dev.vim
    source $XDG_CONFIG_HOME/nvim/pack-cfg/54-pack-misc.vim
    source $XDG_CONFIG_HOME/nvim/pack-cfg/55-pack-jupiter.vim
endfunction

command! PackInstall call PackInit() | call packager#install()
command! -bang PackUpdate call PackInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackClean call PackInit() | call packager#clean()
command! PackStatus call PackInit() | call packager#status()

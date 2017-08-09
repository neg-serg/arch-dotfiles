if has('nvim')
    call dein#begin('~/.vim/bundle', [expand('<sfile>')])
    if len(s:local_plugs)
        call dein#local('~/devel', {'frozen': 1}, s:local_plugs)
    endif
    unlet s:local_plugs
    delfunction s:plug

    call dein#end()
    if dein#check_install()
        call dein#install()
    endif

    call s:plug('Shougo/deoplete.nvim')
    call s:plug('Shougo/neco-vim')
    call s:plug('Shougo/neco-syntax')
    call s:plug('Shougo/neoinclude.vim')
    call s:plug('zchee/deoplete-jedi')
    call s:plug('zchee/deoplete-clang')
    call s:plug('zchee/deoplete-zsh')
    call s:plug('carlitux/deoplete-ternjs')
    call dein#end()
    if dein#check_install()
        call dein#install()
    endif
endif

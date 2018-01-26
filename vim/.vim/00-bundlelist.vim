set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/
if dein#load_state(expand('~/.vim/repos'))
    call dein#begin(expand('~/.vim'))
    call dein#load_toml('~/.vim/dein.toml', {'lazy' : 0})
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif

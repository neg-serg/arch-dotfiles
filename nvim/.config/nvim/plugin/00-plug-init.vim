let g:loaded_getscriptPlugin = 1 " I don't use it
let g:loaded_2html_plugin = 1 " 2html is too ugly for me
let g:loaded_vimballPlugin = 1 " Don't use legacy vimball
let g:loaded_matchparen = 1 " Don't show matching brackets/parenthesis
let loaded_netrwPlugin = 1 " Disable netrw plugin, use vim-ranger
let g:loaded_netrw = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_vimball = 1
let g:loaded_matchit = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1

let &runtimepath = expand('$XDG_CONFIG_HOME/nvim/') . ','
    \ . expand('$XDG_CONFIG_HOME/nvim/after/') . ',' . &runtimepath

" thx to github.com/ceuk/dotfiles
let vimplug_exists=expand("$XDG_CONFIG_HOME/nvim/autoload/plug.vim")
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"
    autocmd VimEnter * PlugInstall
endif

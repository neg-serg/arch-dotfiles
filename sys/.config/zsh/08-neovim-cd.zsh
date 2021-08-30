if [[ $NEOVIM_TERMINAL ]]; then
    neovim_autocd() { ~/bin/neovim-autocd.py & }
    chpwd_functions+=( neovim_autocd )
fi

if [[ ! -x "/usr/sbin/nvim" ]]; then
    source 89-vim-interation.plugin.zsh
else
    alias v="${BIN_HOME}/nwim"
    function wnvim(){
        st nvim &
    }
fi


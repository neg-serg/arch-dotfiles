SHELL=$(which zsh)

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

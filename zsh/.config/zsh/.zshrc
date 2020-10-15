export P9K_SSH=0
### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice depth=1
zinit atload"!source ${ZDOTDIR}/.p10k.zsh" lucid nocd for \
    romkatv/powerlevel10k
zinit light romkatv/zsh-defer
zinit wait silent light-mode for zsh-users/zsh-completions
zinit wait silent light-mode for neg-serg/fast-syntax-highlighting
zinit ice as"command" from"gh-r" mv"tldr-linux-x86\_64-musl -> tldr" pick"tldr"
zinit light dbrgn/tealdeer

source "${ZDOTDIR}/01-init.zsh"
source "${ZDOTDIR}/02-cmds.zsh"
source "${ZDOTDIR}/02-zle-cmds.zsh"
source "${ZDOTDIR}/03-completion.zsh"
source "${ZDOTDIR}/04-bindings.zsh"
source "${ZDOTDIR}/05-fzf.zsh"
source "${ZDOTDIR}/06-neg-dirs.zsh"

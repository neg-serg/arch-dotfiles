### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${ZDOTDIR}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

typeset -gx P9K_SSH=0
fpath=(
    ${HOME}/.zinit/completions
    ${ZDOTDIR}/lazyfuncs
    /usr/share/zsh/site-functions
    /usr/share/zsh/functions/{Misc,Zle,Completion}
    /usr/share/zsh/functions/Completion/*
)
zinit light Aloxaf/fzf-tab
zinit atload"!source ${ZDOTDIR}/.p10k.zsh" lucid nocd for romkatv/powerlevel10k
zinit load romkatv/zsh-defer
zinit wait lucid light-mode for neg-serg/fast-syntax-highlighting
zinit light peterhurford/git-it-on.zsh
zinit wait lucid atload"zicompinit; zicdreplay" blockf \
    for zsh-users/zsh-completions
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

source "${ZDOTDIR}/01-init.zsh"
zsh-defer source "${ZDOTDIR}/02-cmds.zsh"
zsh-defer source "${ZDOTDIR}/03-completion.zsh"
source "${ZDOTDIR}/04-bindings.zsh"
eval "$(zoxide init zsh)"

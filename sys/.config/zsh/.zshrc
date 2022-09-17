### Added by Zinit's installer
if [[ ! -f ${ZDOTDIR}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "${ZDOTDIR}/.zinit" && command chmod g-rwX "${ZDOTDIR}/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "${ZDOTDIR}/.zinit/bin" && \
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

zinit atload"!source ${ZDOTDIR}/.p10k.zsh" lucid nocd for romkatv/powerlevel10k # best prompt
zinit load romkatv/zsh-defer
zinit ice wait'!0'
zinit wait lucid for silent atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" neg-serg/fast-syntax-highlighting \
     blockf zsh-users/zsh-completions

source "${ZDOTDIR}/01-init.zsh"
zsh-defer source "${ZDOTDIR}/02-cmds.zsh"
zsh-defer source "${ZDOTDIR}/03-completion.zsh"
source "${ZDOTDIR}/04-bindings.zsh"
[[ $NEOVIM_TERMINAL ]] && source "${ZDOTDIR}/08-neovim-cd.zsh"

# vim: ft=zsh:nowrap

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

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light romkatv/zsh-defer
zinit wait silent light-mode for zinit-zsh/z-a-bin-gem-node
zinit ice wait lucid blockf atpull:'zinit creinstall -q .'
zinit wait silent light-mode for zsh-users/zsh-completions
zinit ice silent wait!1 atload:"zinit[COMPINIT_OPTS]=-C; zpcompinit"
zinit wait silent light-mode for neg-serg/fast-syntax-highlighting

source "${ZDOTDIR}/01-init.zsh"
zsh-defer source "${ZDOTDIR}/02-cmds.zsh"
zsh-defer source "${ZDOTDIR}/03-completion.zsh"
zsh-defer source "${XDG_CONFIG_HOME}/fzf/shell/completion.zsh"
zsh-defer source "${XDG_CONFIG_HOME}/fzf/shell/key-bindings.zsh"
zsh-defer source "${ZDOTDIR}/04-bindings.zsh"
source "${ZDOTDIR}/.p10k.zsh"

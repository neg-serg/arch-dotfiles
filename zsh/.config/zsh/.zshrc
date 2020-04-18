source "${ZDOTDIR}/01-init.zsh"
source "${ZDOTDIR}/zsh-defer/zsh-defer.plugin.zsh"
source "${ZDOTDIR}/03-exports.zsh"
source "${ZDOTDIR}/05-cmds.zsh"
zsh-defer source "${ZDOTDIR}/12-completion.zsh"
zsh-defer source /usr/share/fzf/completion.zsh
zsh-defer source /usr/share/fzf/key-bindings.zsh
zsh-defer source "${ZDOTDIR}/13-bindkeys.zsh"
zsh-defer source "${ZDOTDIR}/98-syntax.zsh"

source ${ZDOTDIR}/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

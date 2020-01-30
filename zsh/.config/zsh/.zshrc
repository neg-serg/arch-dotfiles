source "${ZDOTDIR}/00-prepare.zsh"
source "${ZDOTDIR}/01-init.zsh"
source "${ZDOTDIR}/zsh-defer/zsh-defer.plugin.zsh"
source "${ZDOTDIR}/03-exports.zsh"
source "${ZDOTDIR}/05-cmds.zsh"

zsh-defer source "${ZDOTDIR}/12-completion.zsh"
zsh-defer source "${ZDOTDIR}/13-bindkeys.zsh"
zsh-defer source "${ZDOTDIR}/81-completion_gen.zsh"
zsh-defer source "${ZDOTDIR}/96-fzf.zsh"
zsh-defer source "${ZDOTDIR}/98-syntax.zsh"

source "${ZDOTDIR}/99-final.zsh"

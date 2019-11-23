PROFILE_CONFIG=false
[[ $PROFILE_CONFIG == true ]] && zmodload zsh/zprof
export ZDOTDIR="${HOME}/.zsh"

source "${ZDOTDIR}/zsh-defer/zsh-defer.plugin.zsh"

source "${ZDOTDIR}/01-init.zsh"
source "${ZDOTDIR}/03-exports.zsh"
source "${ZDOTDIR}/04-prompt.zsh"
zsh-defer source "${ZDOTDIR}/05-cmds.zsh"
zsh-defer source "${ZDOTDIR}/12-completion.zsh"
zsh-defer source "${ZDOTDIR}/13-bindkeys.zsh"
zsh-defer source "${ZDOTDIR}/70-forgit.zsh"
zsh-defer source "${ZDOTDIR}/81-completion_gen.zsh"
zsh-defer source "${ZDOTDIR}/96-fzf.zsh"
zsh-defer source "${ZDOTDIR}/98-syntax.zsh"

[[ ${PROFILE_CONFIG} == true ]] && zprof

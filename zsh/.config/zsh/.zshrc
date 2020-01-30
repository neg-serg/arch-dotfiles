# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PROFILE_CONFIG=false
[[ $PROFILE_CONFIG == true ]] && zmodload zsh/zprof

source "${ZDOTDIR}/01-init.zsh"
source "${ZDOTDIR}/zsh-defer/zsh-defer.plugin.zsh"
source "${ZDOTDIR}/03-exports.zsh"
source "${ZDOTDIR}/05-cmds.zsh"

zsh-defer source "${ZDOTDIR}/12-completion.zsh"
zsh-defer source "${ZDOTDIR}/13-bindkeys.zsh"
zsh-defer source "${ZDOTDIR}/81-completion_gen.zsh"
zsh-defer source "${ZDOTDIR}/96-fzf.zsh"
zsh-defer source "${ZDOTDIR}/98-syntax.zsh"

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ${PROFILE_CONFIG} == true ]] && zprof

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

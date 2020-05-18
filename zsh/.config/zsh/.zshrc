if [[ ! -d ${ZDOTDIR}/.zplugin ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

### Added by zplugin's installer
if [[ ! -f $HOME/.config/zsh/.zplugin/bin/zplugin.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zplugin%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zplugin" && command chmod g-rwX "$HOME/.config/zsh/.zplugin"
    command git clone https://github.com/zdharma/zplugin "$HOME/.config/zsh/.zplugin/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of zplugin's installer chunk

zplugin light-mode for \
    zplugin-zsh/z-a-bin-gem-node

zplugin ice depth=1; zplugin light romkatv/powerlevel10k
zplugin light romkatv/zsh-defer
zplugin ice wait lucid blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions
zplugin light zdharma/zui
zplugin light zdharma/zbrowse
zplugin ice silent wait!1 atload"zplugin[COMPINIT_OPTS]=-C; zpcompinit"
zplugin light neg-serg/fast-syntax-highlighting

zplugin ice as"command" from"github-rel"
zplugin light junegunn/fzf-bin

source "${ZDOTDIR}/01-init.zsh"
zsh-defer source "${ZDOTDIR}/05-cmds.zsh"
zsh-defer source "${ZDOTDIR}/12-completion.zsh"
zsh-defer source "${XDG_CONFIG_HOME}/fzf/shell/completion.zsh"
zsh-defer source "${XDG_CONFIG_HOME}/fzf/shell/key-bindings.zsh"
zsh-defer source "${ZDOTDIR}/13-bindkeys.zsh"
source "${ZDOTDIR}/.p10k.zsh"

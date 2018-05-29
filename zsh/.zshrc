#--------------------------------
#                   ██          -
#                  ░██          -
#    ██████  ██████░██          -
#   ░░░░██  ██░░░░ ░██████      -
#      ██  ░░█████ ░██░░░██     -
#     ██    ░░░░░██░██  ░██     -
#    ██████ ██████ ░██  ░██     -
#   ░░░░░░ ░░░░░░  ░░   ░░      -
#                               -
#--------------------------------

export ZDOTDIR="${HOME}/.zsh"
local _zsh_home="${ZDOTDIR}"

local _zsh_files=(
    00-common.zsh
    01-init.zsh
    03-exports.zsh
    04-git-async-prompt.zsh
    04-oldprompt.zsh
    05-functions.zsh
    06-alias.zsh
    10-zle_functions.zsh
    11-open.zsh
    12-completion.zsh
    13-bindkeys.zsh
    70-games.zsh
    81-completion_gen.zsh
    89-neovim-interaction.zsh
    96-fzf.zsh
    98-syntax.zsh
    99-misc.zsh
)

for i in ${_zsh_files[@]}; do
    [[ -f ${_zsh_home}/${i} ]] && source ${_zsh_home}/${i}
done

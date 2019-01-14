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
[[ $PROFILE_CONFIG == true ]] && zmodload zsh/zprof
export ZDOTDIR="${HOME}/.zsh"

local zsh_files=(
    00-common.zsh
    01-init.zsh
    03-exports.zsh
    04-git-async-prompt.zsh
    04-prompt.zsh
    05-cmds.zsh
    11-open.zsh

    # plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    plugins/zsh-histdb/sqlite-history.zsh
    plugins/zsh-histdb/histdb-interactive.zsh

    12-completion.zsh
    13-bindkeys.zsh
    70-games.zsh
    81-completion_gen.zsh
    89-neovim-interaction.zsh
    96-fzf.zsh
    98-syntax.zsh
    99-misc.zsh
)

for i in "${zsh_files[@]}"; do
    [[ -f "${ZDOTDIR}/${i}" ]] && source "${ZDOTDIR}/${i}"
done

[[ $PROFILE_CONFIG == true ]] && zprof

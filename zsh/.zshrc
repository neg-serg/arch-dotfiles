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

PROFILE_CONFIG=false
[[ $PROFILE_CONFIG == true ]] && zmodload zsh/zprof
export ZDOTDIR="${HOME}/.zsh"

local zsh_files=(
    01-init.zsh
    03-exports.zsh
    04-prompt.zsh
    05-cmds.zsh
    11-open.zsh
    12-completion.zsh
    13-bindkeys.zsh
    70-games.zsh
    81-completion_gen.zsh
    96-fzf.zsh
    98-syntax.zsh
    99-misc.zsh
)

for i in "${zsh_files[@]}"; do
    [[ -f "${ZDOTDIR}/${i}" ]] && source "${ZDOTDIR}/${i}"
done

[[ ${PROFILE_CONFIG} == true ]] && zprof

export BW_SESSION="Q5rUQXOWIZ0vYmxgFhSQ4ltI0QW/Dd5uv5z081swdE+RMa8aHJ9ut1Bvl9p7V69LOaXwmEJSJWuH3j+DD4ca2g=="

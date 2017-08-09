function neg_powerline_init(){
    powerline-daemon -q
    python_version=$(python --version|grep -wo '[0-9]\.[0-9]')
    local powerline_path_="/usr/lib/python${python_version}/site-packages/powerline"
    source "${powerline_path_}/bindings/zsh/powerline.zsh"
}

DARK_BLUE="%{"$'\033[00;38;5;4m'"%}"
_neg_user_pretok="${DARK_BLUE}[${NOCOLOR}"
function precmd(){ 
    export PS1="${_neg_user_pretok}%40<..<$(${ZSH}/neg-prompt)"
}
PS2="%{$fg[magenta]%}» %{$reset_color%}"
PS3='?# ' # selection prompt used within a select loop.
PS4='+%N:%i:%_> ' # the execution trace prompt (setopt xtrace). default: '+%N:%i
SPROMPT="%{${fg[white]}%}Correct: %{${fg[blue]}%}%R%{${reset_color}%} %{${fg[white]}%}-> %{${fg[cyan]}%}%r%{${fg[white]}%} [nyae]? %{${reset_color}%}"

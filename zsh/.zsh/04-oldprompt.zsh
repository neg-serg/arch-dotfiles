PS2="%F{5}❭ %f"
PS3='?# '
PS4='+%N:%i:%_> '

function setup_prompt(){ 
    # lhs="%F{25}⟬%F{4}<" rhs="⧔" # lhs="❬" rhs="❭" # lhs="❲" rhs="❳" 「｢ ⦔
    # lhs="❬" rhs="❭" # lhs="❲" rhs="❳"
    # lhs="%F{25}⟬%F{4}<" rhs=""
    lhs="%F{4}⟬" rhs=""
    SPROMPT="%F{7}Correct: %F{4}%R%f %F{7}-> %F{2}%r%F{7} [nyae]? %f"
    DARK_BLUE="%F{4}"
    DARK_BLUE_BOLD="%B%F{4}"
    prompt_end="∣%F{25}>%B%F{26}>%B%f "
    _neg_user_pretok="${DARK_BLUE}${lhs}%f"
    export PS1="${_neg_user_pretok}%40<..<$(lhs="${lhs}" rhs="${rhs}" prompt_end="${prompt_end}" ${ZSH}/neg-prompt)" 
}
function precmd(){ setup_prompt }

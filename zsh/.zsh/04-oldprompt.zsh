PS2="%F{5}❭ %f"
PS3='?# '
PS4='+%N:%i:%_> '

local fst="❯"
local snd=">"

local brackets_cfg=5
case brackets_cfg in
    1) lhs="%F{25}⟬%F{4}<" rhs="⧔" ;;
    2) lhs="❬" rhs="❭" ;;
    3) lhs="❲" rhs="❳" ;;
    4) lhs="%F{25}⟬%F{4}<" rhs="" ;;
    5) lhs="%F{4}⟬" rhs="" ;;
    6) lhs="❬" rhs="❭"  ;;
    7) lhs="❲" rhs="❳" ;;
esac

SPROMPT="%F{7}Correct: %F{4}%R%f %F{7}-> %F{2}%r%F{7} [nyae]? %f"
DARK_BLUE="%F{4}"
DARK_BLUE_BOLD="%B%F{4}"
prompt_end="∣%F{25}${fst}%B%F{26}${snd}%B%f "
_neg_user_pretok="${DARK_BLUE}${lhs}%f"

function setup_prompt { 
    export PS1="${_neg_user_pretok}%40<..<$(lhs="${lhs}" rhs="${rhs}" prompt_end="${prompt_end}" ${ZSH}/neg-prompt)" 
}

function precmd {
    setup_prompt 
}

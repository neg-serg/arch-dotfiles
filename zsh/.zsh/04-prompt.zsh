PS2="%F{5}❭ %f"
PS3='?# '
PS4='+%N:%i:%_> '

local fst="❯"
local snd=">"

local brackets_cfg=5
case brackets_cfg in
    1) lhs_="%F{25}⟬%F{4}<" rhs_="⧔" ;;
    2) lhs_="❬" rhs_="❭" ;;
    3) lhs_="❲" rhs_="❳" ;;
    4) lhs_="%F{25}⟬%F{4}<" rhs_="" ;;
    5) lhs_="%F{4}⟬" rhs_="" ;;
    6) lhs_="❬" rhs_="❭"  ;;
    7) lhs_="❲" rhs_="❳" ;;
esac

SPROMPT="%F{7}Correct: %F{4}%R%f %F{7}-> %F{2}%r%F{7} [nyae]? %f"
DARK_BLUE="%F{4}"
DARK_BLUE_BOLD="%B%F{4}"
prompt_end="∣%F{25}${fst}%B%F{26}${snd}%B%f "
_neg_user_pretok="${DARK_BLUE}${lhs}%f"

function setup_prompt { 
    export PS1="${_neg_user_pretok}%40<..<$(lhs="${lhs_}" rhs="${rhs_}" prompt_end="${prompt_end}" ${ZSH}/neg-prompt)" 
}

function precmd {
    setup_prompt 
}

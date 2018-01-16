export PROMPT_EOL_MARK='' # Do not show percentage
export _zsh_oldprompt_is_sourced="true"

local _lambda_ok="" # "%{$fg_bold[green]%}=λ\\"
local _lambda_err="%{$fg_bold[red]%}=λ\\"
local _lambda="%(?,${_lambda_ok},${_lambda_err})%{${reset_color}%}"

function nice_exit_code() {
    local exit_status="${1:-$(print -P %?)}";
    # nothing to do here
    [[ -z $exit_status || $exit_status == 0 ]] && return;

    local sig_name;
    
    # is this a signal name (error code = signal + 128) ?
    case $exit_status in
        129)  sig_name=HUP ;;
        130)  sig_name=INT ;;
        131)  sig_name=QUIT ;;
        132)  sig_name=ILL ;;
        134)  sig_name=ABRT ;;
        136)  sig_name=FPE ;;
        137)  sig_name=KILL ;;
        139)  sig_name=SEGV ;;
        141)  sig_name=PIPE ;;
        143)  sig_name=TERM ;;
    esac

    # usual exit codes
    case $exit_status in
        -1)   sig_name=FATAL ;;
        1)    sig_name=WARN ;; # Miscellaneous errors, such as "divide by zero"
        2)    sig_name=BUILTINMISUSE ;; # misuse of shell builtins (pretty rare)
        126)  sig_name=CCANNOTINVOKE ;; # cannot invoke requested command (ex : source script_with_syntax_error)
        127)  sig_name=CNOTFOUND ;; # command not found (ex : source script_not_existing)
    esac

    # assuming we are on an x86 system here
    # this MIGHT get annoying since those are in a range of exit codes
    # programs sometimes use.... we'll see.
    case $exit_status in
        19)  sig_name=STOP ;;
        20)  sig_name=TSTP ;;
        21)  sig_name=TTIN ;;
        22)  sig_name=TTOU ;;
    esac

    echo "%{$fg[blue]%}[%{$fg[white]%}$ZSH_PROMPT_EXIT_SIGNAL_PREFIX${exit_status}:${sig_name:-$exit_status}%{$fg[blue]%}]%{$reset_color%}"
}

case ${UID} in
0)
    PROMPT="%{$fg[red]%}<%T>%{$fg[red]%}[root@%m] %(!.#.$) %{${reset_color}%}%{${fg[red]}%}[%~]%{${reset_color}%} "
    PS1="${PROMPT}"
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    PS2="${PROMPT2}"
    SPROMPT="%{${fg[white]}%}Correct: %{${fg[blue]}%}%R%{${reset_color}%} %{${fg[white]}%}-> %{${fg[cyan]}%}%r%{${fg[white]}%} [nyae]? %{${reset_color}%}"
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    ;;
*)
    SPROMPT="%{${fg[white]}%}Correct: %{${fg[blue]}%}%R%{${reset_color}%} %{${fg[white]}%}-> %{${fg[cyan]}%}%r%{${fg[white]}%} [nyae]? %{${reset_color}%}"
    DARK_BLUE="%{$fg[blue]%}"
    DARK_BLUE_BOLD="%{$fg_bold[blue]%}"
    # lhs="%F{25}⟬%F{4}<" rhs="⧔" # lhs="❬" rhs="❭" # lhs="❲" rhs="❳" 「｢ ⦔
    lhs="%F{25}⟬%F{4}<" rhs="" # lhs="❬" rhs="❭" # lhs="❲" rhs="❳"
    prompt_end="∣%F{25}>%B%F{26}>%B%{$reset_color%} "
    _neg_user_pretok="${DARK_BLUE}${lhs}%{$reset_color%}"
    function precmd(){ 
        export PS1="${_neg_user_pretok}%40<..<$(lhs="${lhs}" rhs="${rhs}" prompt_end="${prompt_end}" ${ZSH}/neg-prompt)" 
    }
    PS2="%{$fg[magenta]%}» %{$reset_color%}"
    # selection prompt used within a select loop.
    PS3='?# '
    # the execution trace prompt (setopt xtrace). default: '+%N:%i
    PS4='+%N:%i:%_> '
    ;;
esac

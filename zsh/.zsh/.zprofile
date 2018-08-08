inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

setterm -bfreq 0 # disable annoying pc speaker
if [[ "${TERM}" = "linux" ]]; then
    local run_yaft=1
    if hash yaft 2> /dev/null; then
        if [[ ${run_yaft} == 1 ]]; then
            yaft
        fi
    fi

    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
fi

if [[ -o LOGIN  ]]; then
    (( $#commands[tmux]  )) && tmux list-sessions 2>/dev/null

    uptimestart=$(uptime | colrm 1 13 | colrm 6)
    print "$fg[blue]Host: $fg[green]${HOST}$fg[blue], Zeit: $fg[green]$(date +%d.%m.%Y' '%H:%M:%S)$fg[blue], Up: $fg[green]$uptimestart"
    print "$fg[blue]Term: $fg[green]${TTY} $fg[blue], $fg[blue]Shell: $fg[green]Zsh ${ZSH_VERSION} $fg[blue] (PID=$$)"
    print "$fg[blue]Login: $fg[green]${LOGNAME} $fg[blue] (UID=${EUID}), cars: $fg[green]${COLUMNS} x ${LINES}"
fi

if [[ -z "${DISPLAY}"  ]] && \
   [[ $(tty) = /dev/tty1  ]] && \
   [[ -z ${DISPLAY} && ${XDG_VTNR} -eq 1  ]] && \
   [[ -z $(pgrep xinit)  ]]; then
   exec startx -- -keeptty -nolisten tcp > /tmp/xorg.log 2>&1
fi

# Let's set up some colors. By default, we won't use any color.
EYES="" TRUNK="" LEAVES="" CLEAR=""

# If we're in a terminal, we can play with some color.
if [[ -t 1 ]]; then
    # We'll choose our palette based on the number of available colors.
    case $(tput colors) in
        256)
            EYES="$(tput setaf 240)" # A nice gray
            SPOTS="$(tput setaf 15)" # Bright white
            TRUNK="$(tput setaf 18)" 
            LEAVES="$(tput setaf 22)" # Dark green
            CLEAR="$(tput sgr0)"
            ;;
        16)
            EYES="$(tput setaf 8)" # Gray
            SPOTS="$(tput setaf 15)" # Bright white
            TRUNK="$(tput setaf 3)" # Dark yellow
            LEAVES="$(tput setaf 10)" # Bright green
            CLEAR="$(tput sgr0)"
            ;;
        8)
            EYES="$(tput setaf 7)" # White
            SPOTS="$(tput setaf 7)" # White
            TRUNK="$(tput setaf 3)" # Yellow
            LEAVES="$(tput setaf 2)" # Green
            CLEAR="$(tput sgr0)"
            ;;
    esac
fi

if [[ "${EUID}" != 0 ]]; then
    true
else
    cat <<-EOF
	${LEAVES}    _              ${TRUNK}__
	${LEAVES}   / \`\\  ${TRUNK}(~._    ./  )
	${LEAVES}   \__/ __${TRUNK}\`-_\\__/ ./
	${LEAVES}  _ ${TRUNK}\\ \\${LEAVES}/  \\   ${TRUNK}\\ |_   ${LEAVES}__
	${LEAVES}(   )  \\__/ ${TRUNK}-^    \\ ${LEAVES}/  \\
	${LEAVES} \\_/ ${TRUNK}"  \\  | ${EYES}o  o  ${TRUNK}|${LEAVES}.. /  __
	${TRUNK}      \\. --' ${SPOTS}====  ${TRUNK}/  || ${LEAVES}/  \\
	${TRUNK}        \\   ${SPOTS}.  .  ${TRUNK}|---${LEAVES}__${TRUNK}.${LEAVES}\\__/
	${TRUNK}        /  ${SPOTS}:     ${TRUNK}/   ${LEAVES}|   |
	${TRUNK}        /   ${SPOTS}:   ${TRUNK}/     ${LEAVES}\\_/
	${TRUNK}     --/ ${SPOTS}::    ${TRUNK}(
	${TRUNK}    (  |     (  (____
	${TRUNK}  .--  .. ----**.____)
	${TRUNK}  \\___/$CLEAR
	EOF
fi

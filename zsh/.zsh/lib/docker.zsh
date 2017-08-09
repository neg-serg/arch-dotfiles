function is_dock_project() {
    if [[ -e docker-compose.yml ]]; then
        echo 1
    fi
}

function dock_status() {
    if [ $(is_dock_project) ]; then
        if [[ $DOCKER_MACHINE_NAME != "" && $DOCKER_MACHINE_NAME != "default" ]]; then
          DOCKER_MACHINE_NAME_LOCAL="%{$fg_bold[red]%}"$DOCKER_MACHINE_NAME"%{$fg_bold[blue]%}:"
        fi
        echo -n " dock:("$DOCKER_MACHINE_NAME_LOCAL
        docker-compose ps 2>/dev/null | tail -n+3 | while read line
        do
            CONTAINER_LETTER_POSITION=$(echo $line | awk 'match($0,"_"){print RSTART}')
            CONTAINER_LETTER=$(echo ${line:$CONTAINER_LETTER_POSITION:1} | tr '[:lower:]' '[:upper:]')
            if [[ $line == *"Up"* ]]; then
                echo -n "%{$fg_bold[green]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
            else
                echo -n "%{$fg_bold[red]%}"$CONTAINER_LETTER"%{$fg_bold[blue]%}"
            fi
        done
        echo -n ")"
    fi
}


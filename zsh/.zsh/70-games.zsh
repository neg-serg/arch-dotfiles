local games_dir_="$(readlink -f ${HOME}/games)"
local wine_pref_="${HOME}/.wine"
IFS= local wine_progs_="$(echo ${wine_pref_}'/drive_c/Program Files (x86)')"

alias wine="WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
alias crossover="LANG=ru_RU.utf8 setarch i386 -3 /zero/crossover/bin/crossover"

function steam_wine(){
    cd "${wine_progs_}/Steam"
    WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine Steam.exe
}

function bnet(){
    local prefix_=""
    if [[ $1 =~ ".*32" ]]; then
        prefix_="setarch i386 -3 "
        _zwrap "set to 32 bit"
    fi
    cd "${wine_progs_}/Battle.net"
    eval WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C \
    ${prefix_} wine ./Battle.net.exe &
}

function doom(){
    cd "${wine_progs_}/Steam/steamapps/common/DOOM/"
    local doom_path="DOOMx64vk.exe"
    SDL_AUDIODRIVER="alsa" wine "${doom_path}"
}

function q3(){
    [[ -o noshwordsplit ]] && setopt shwordsplit
    noglob "${games_dir_}/q3/ioquake3" \
        +set r_fullscreen 1 \
        +set r_customheight "1200" \
        +setr_customwidth "1920" \
        +set r_mode "-1" \
        +set cg_fov "100"
    unsetopt shwordsplit
}

function steam(){
    SDL_AUDIODRIVER="alsa" \
    LD_PRELOAD='/usr/lib/libSDL2-2.0.so.0.4.0 /usr/lib/libSDL_sound-1.0.so.1.0.2' \
    steam-native
}

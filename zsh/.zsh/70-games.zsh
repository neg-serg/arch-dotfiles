local games_dir_="$(readlink -f ${HOME}/games)"
local wine_pref_="${HOME}/.wine"
IFS= local wine_progs_="$(echo ${wine_pref_}'/drive_c/Program Files (x86)')"

alias wine="WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
alias crossover="LANG=ru_RU.utf8 setarch i386 -3 /zero/crossover/bin/crossover"

function steam_wine(){
    cd "${wine_progs_}/Steam"
    WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine Steam.exe
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

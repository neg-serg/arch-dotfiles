local wine_pref_="${HOME}/.wine"
IFS= local wine_progs_="$(echo ${wine_pref_}'/drive_c/Program Files (x86)')"

alias wine="WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
alias crossover="LANG=ru_RU.utf8 setarch i386 -3 /zero/crossover/bin/crossover"

function steam_wine(){
    cd "${wine_progs_}/Steam"
    WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine Steam.exe
}

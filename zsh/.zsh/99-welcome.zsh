# Silly ascii-art welcome message
echo ''
fonts=('Bloody' '3d_diagonal' 'Acrobatic' '3d' 'dietcola' '3D-ASCII' 'fire_font-k'    \
        'NScript' 'OS2' 'Poison' 'Rammstein' 'rebel' 'red_phoenix' 'Roman' 'rowancap' \
        'Rozzo' 'amcrazo2' 'amcrazor' 'amcthin' 'Banner3-D' 'Fraktur' 'Ghoulish'      \
        'Bolger' 'Cards' 'Chiseled' 'Isometric1' 'Keyboard' 'lineblocks' 'Sub-Zero'   \
        'Modular' 'Twisted' 'Univers' 'Whimsy')
figlet -tcf ${fonts[$[$RANDOM % ${#fonts[@]}] + 1]} welcome | lolcat -S 23 -t
echo ''
unset fonts

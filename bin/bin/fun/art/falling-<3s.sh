#!/bin/bash
# Copyright 2011 Yu-Jie Lin
# New BSD License
#
# Falling <3s (Hearts) for terminal
#
# Started at 2011-02-01T17:34:07Z

# Default Settings
##################

# Comment out if your terminal doesn't support 256 colors
COLOR256=1
# "❤" <- This is U+2764, now shown with my font
HEARTS=("♥" "♡" "<3" "Ɛ>" "LOVE" "ǝʌoן")
# Only 31-red 35-magenta look like <3
HEART_COLORS=("\e[31m" "\e[31;1m" "\e[35m" "\e[35;1m")
# More from 256 color mode
if [[ $COLOR256 ]]; then
	for i in {4..5}; do
		for j in {0..5}; do
			HEART_COLORS=("${HEART_COLORS[@]}" "\e[38;5;$((i * 36 + 16 + j))m")
		done
	done
fi

STEP_DURATION=0.1
# In percentage
NEW_HEART_ODD=50
MAX_HEARTS=100
FALLING_ODD=50
NUM_HEART_METADATA=4

# http://www.ascii-fr.com/-Hearts-.html
BIG_HEART_WIDTH=56
BIG_HEART_HEIGHT=19
BIG_HEART="        LoveLoveLov                eLoveLoveLo
     veLoveLoveLoveLove          LoveLoveLoveLoveLo
  veLoveLoveLoveLoveLoveL      oveLoveLoveLoveLoveLove
 LoveLoveLoveLoveLoveLoveL    oveLoveLoveLoveLoveLoveLo
veLoveLoveLoveLoveLoveLoveL  oveLoveLoveLoveLoveLoveLove
LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
 LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
 veLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
   LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
     veLoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLove
       LoveLoveLoveLoveLoveLoveLoveLoveLoveLoveLo
         veLoveLoveLoveLoveLoveLoveLoveLoveLove
           LoveLoveLoveLoveLoveLoveLoveLoveLo
             veLoveLoveLoveLoveLoveLoveLove
               LoveLoveLoveLoveLoveLoveLo
                  veLoveLoveLoveLoveLo
                      veLoveLoveLo
                           ve
"

sigwinch() {
	TERM_WIDTH=$(tput cols)
	TERM_HEIGHT=$(tput lines)
	BIG_HEART_X=$(((TERM_WIDTH-BIG_HEART_WIDTH)/2))
	}

sigint() {
	local x, y
	end_text=" Ɛ> Happy Valentine's Day!!! <3 "
	x=$(((TERM_WIDTH - ${#end_text}) / 2))
	for ((y=1; y<=TERM_HEIGHT/2; y++)); do
		do_render 1

		if [[ $COLOR256 ]]; then
			color="$((6 - 6 * y / (TERM_HEIGHT / 2)))"
			if ((color == 0)); then
				color="\e[31;1m"
			else
				color="\e[38;5;$((5 * 36 + 16 + color - 1))m"
			fi
		else
			color="\e[31;1m"
		fi

		echo -ne "\e[${y};${x}H${color}${end_text}\e[0m"
		sleep 0.025
	done
	do_exit
	}

do_exit() {
	echo -ne "\e[${TERM_HEIGHT};1H\e[0K"
	
	# Show cursor and echo stdin
	echo -ne "\e[?25h"
	stty echo
	exit 0
	}

do_render() {
	local x, y
	# Clean screen first
	echo -ne "\e[2J"

	# The BIG HEART!
	if [[ $big_heart ]]; then
		y=$(((TERM_HEIGHT-BIG_HEART_HEIGHT)/2))
		color="${HEART_COLORS[${#HEART_COLORS[@]} * RANDOM / 32768]}"
		OLDIFS="$IFS"
		IFS=$'\n'
		echo -n "$BIG_HEART" | while read line_heart; do
			echo -ne "\e[${y};${BIG_HEART_X}H${color}${line_heart}"
			((y++))
		done
		IFS="$OLDIFS"
	fi

	idx=1
	while ((idx<=num_hearts)); do
		if [[ -z "$1" ]] && ((100 * RANDOM / 32768 < FALLING_ODD)); then
			# Falling
			if ((++hearts[(idx - 1) * NUM_HEART_METADATA + 1] > TERM_HEIGHT)); then
				# Out of screen, bye sweet <3
				hearts=(
					"${hearts[@]:0:(idx-1)*NUM_HEART_METADATA}"
					"${hearts[@]:idx*NUM_HEART_METADATA:(num_hearts-idx)*NUM_HEART_METADATA}"
					)
				((num_hearts--))
				continue
			fi
		fi
		X=${hearts[(idx - 1) * NUM_HEART_METADATA]}
		Y=${hearts[(idx - 1) * NUM_HEART_METADATA + 1]}
		HEART=${hearts[(idx - 1) * NUM_HEART_METADATA + 2]}
		HEART_COLOR=${hearts[(idx - 1) * NUM_HEART_METADATA + 3]}
		echo -ne "\e[${Y};${X}H${HEART_COLOR}${HEART}"
		((idx++))
	done
	}

trap do_exit TERM
trap sigint INT
trap sigwinch WINCH
# No echo stdin and hide the cursor
stty -echo
echo -ne "\e[?25l"

hearts=()
echo -ne "\e[2J"
sigwinch
while :; do
	read -n 1 -t $STEP_DURATION ch
	case "$ch" in
		q|Q)
			sigint
			;;
		l|L) # Show/hide a big heart!
			if [[ $big_heart ]]; then
				big_heart=
			else
				big_heart=1
			fi
			;;
	esac
	
	num_hearts=$((${#hearts[@]} / NUM_HEART_METADATA))
	if ((num_hearts <= MAX_HEARTS)) && ((100 * RANDOM / 32768 < NEW_HEART_ODD)); then
		# Need new <3
		# 1-based
		HEART="${HEARTS[${#HEARTS[@]} * RANDOM / 32768]}"
		X=$((TERM_WIDTH * RANDOM / 32768 + 1 - ${#HEART}))
		Y=1
		HEART_COLOR="${HEART_COLORS[${#HEART_COLORS[@]} * RANDOM / 32768]}"
		hearts=("${hearts[@]}" "$X" "$Y" "$HEART" "$HEART_COLOR")
		echo -ne "\e[${Y};${X}H${HEART_COLOR}${HEART}"
		((num_hearts++))
	fi

	# Let <3s fall!
	do_render
done

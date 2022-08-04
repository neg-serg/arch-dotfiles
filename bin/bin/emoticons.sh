#!/bin/zsh

selection=$(rofi -i \
    -p "emoticons" \
    CM_HISTLENGTH=20 \
    -no-show-icons \
    -dmenu \
    $@ < $(dirname $0)/emoticons.txt)
emoti=$(echo $selection | sed "s/^[^:]\+: //")
echo -n "$emoti" | xsel -ib

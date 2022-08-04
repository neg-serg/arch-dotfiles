#!/bin/zsh
connection=$(\pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' |xargs basename| cut -f 1 -d '.')
if [ -n "$connection" ]; then
    echo $connection
else
    echo ""
fi

#!/bin/zsh    
~/.config/i3/bin/send circle next nwim
while ! xdotool search --all --classname '^nwim$' 2>&1 > /dev/null; do
    sleep 0.1
done
NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvr "$@"

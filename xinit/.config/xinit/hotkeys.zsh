#!/bin/zsh
SXHKD_FIFO=${2:-/tmp/sxhkd_fifo}

rm -f "${SXHKD_FIFO}"
mkfifo "${SXHKD_FIFO}"
[[ ! $(pidof sxhkd) ]] && sxhkd -s "${SXHKD_FIFO}" 2> /dev/null &

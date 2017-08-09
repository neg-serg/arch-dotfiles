USE_SXHKD=${1:-true}
if [[ $USE_SXHKD ]]; then
    rm -f "${SXHKD_FIFO}" && mkfifo "${SXHKD_FIFO}" && \
        nexec sxhkd && sxhkd -s "${SXHKD_FIFO}" > /dev/null &
else
    xbindkeys -p -n > /tmp/xbindkeys$$.log
fi

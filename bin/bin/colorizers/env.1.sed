#!/usr/bin/env -S sed -E -f
s/^([^=]*)=.(.*)/\x1b[0m\1\x1b[38;5;7m=\x1b[38;5;3m\2/g
s/^[^\x1b].*$/\x1b[38;5;8m&/g

#!/usr/bin/env -S sed -E -f
s/^(devtmpfs|tmpfs|cgroup2?|) on .*/\x1b[38;5;8m&\x[0m/;t
s:^/(.*)/([^/]*) on :\x1b[38;5;6m/\1/\x1b[1m\2\x1b[0m on :;t rest
s/^[^ ]*/\x1b[38;5;2m&\x1b[0m/
:rest
s: on (.*)/([^/]*) type (\w*) \((rw)?(.*)\)$: on \x1b[38;5;4m\1/\x1b[1m\2\x1b[0m type \x1b[38;5;3m\3\x1b[0m (\x1b[38;5;1m\4\x1b[38;5;5m\5\x1b[0m):

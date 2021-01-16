#!/usr/bin/env -S sed -E -f
#s/^(devtmpfs|tmpfs|cgroup2?|) on .*/\x1b[38;5;8m&\x[0m/;t
s:^/(.*)/([^/]*) on :\x1b[38;5;6m/\1/\x1b[1m\2\x1b[0m on :;t rest
s/^[^ ]*/\x1b[38;5;2m&\x1b[0m/
:rest
h
# delete before (options)
s/.*\((.*)/\1/
# color rw red
s/r[wo],/\t\x1b[38;5;1mrw\x1b[0m,/
# color all other options
s/([^,]*)[,\)]/\x1b[38;5;5m\1\x1b[0m\n\t/g
s/=([^\n]*)/\x1b[38;5;7m=\x1b[38;5;5m\x1b[1m\1\x1b[0m/g
x
s: on (.*)/([^/]*) type ([^ ]*) \(.*: on \x1b[38;5;4m\1/\x1b[1m\2\x1b[0m type \x1b[38;5;3m\3\x1b[0m :
G
s/\n\s*$//

#!/usr/bin/env -S sed -E -f
s/\bOK|SUCCESS\b/\x1b[38;5;10m\x1b[1m&\x1b[0m/g
s/\bWARN(ING)?\b/\x1b[38;5;3m\x1b[1m&\x1b[0m/g
s/\bERR(OR)?|FAIL(URE|ED)?\b/\x1b[38;5;1m\x1b[1m&\x1b[0m/g

#!/usr/bin/env -S gawk -v ORS= -f
match($0, /^(..):(..)\.(.) ([^:]*: )?(.*)/, a) {
	# Address
	print "\033[38;5;10m" a[1] "\033[0m:\033[38;5;11m" a[2] "\033[0m.\033[38;5;1m" a[3] "\033[0m " 
	# Type
	switch (a[4]) {
		case /bridge: $/     : print "\033[38;5;6m" a[4]; break
		case /controller: $/ : print "\033[38;5;2m" a[4]; break
		case /device: $/     : print "\033[38;5;4m" a[4]; break
		case /: $/           : print "\033[38;5;3m" a[4]; break
		default              : print a[4]
	}
	print "\033[0m" a[5] "\n"
	next
}
/^/{ print $0 "\n" }

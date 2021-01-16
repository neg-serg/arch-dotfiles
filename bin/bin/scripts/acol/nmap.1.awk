#!/usr/bin/env -S gawk -v ORS= -f

match($0, /^(Nmap scan report for )([^ ]*) \(([^\)]*)\)/, a) {
	print a[1] "\033[38;5;10m" a[2] "\033[0m (\033[38;5;12m" a[3] "\033[0m)\n"
	next
}

match($0, /^(Host is )(up)(.*)/, a) {
	print a[1] "\033[38;5;10m\033[1m" a[2] "\033[0m" a[3] "\n"
	next
}

# Closed|filtered count
match($0, /^(Not shown: )([[:digit:]]* [[:alpha:]]*)(.*)/, a) {
	print a[1] "\033[38;5;1m" a[2] "\033[0m" a[3] "\n"
	next
}

# Title
/^PORT|HOP/ {
	print "\033[1m" $0 "\033[0m\n"
	next
}

match($0, /^([[:digit:]]*)\/([[:alpha:]]* *)([[:alpha:]]*(\|[[:alpha:]]*)? *)(.*)/, a) {
	# Port/Type
	print "\033[38;5;10m\033[1m" a[1] "\033[0m/\033[38;5;14m" a[2]
	# State
	switch (a[3]) {
		case /filtered/    : print "\033[38;5;3m" a[3]; break
		case /^open/       : print "\033[38;5;2m" a[3]; break
		case /^closed/     : print "\033[38;5;1m" a[3]; break
		case /^unfiltered/ : print "\033[38;5;5m" a[3]; break
		default            : print a[3]
	}
	# Service
	print "\033[38;5;11m\033[1m" a[5] "\033[0m\n"
	next
}
# Port details
match($0, /(\|_?)(.*)/, a) {
	print "\033[38;5;10m" a[1] "\033[0m" a[2] "\n"
	next
}

/^/{ print $0 "\n" }

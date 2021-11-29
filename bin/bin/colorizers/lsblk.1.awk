#!/usr/bin/env -S gawk -v ORS= -f

# Heading
NR==1 && /^[A-Z][A-Z][A-Z]/ {
	print "\033[1m\033[4m" $0 "\033[0m\n"
	next
}

1 {
	n=split($0, a, FS, s)
	print s[0]
	for (i=1;i<=n;i++) {
		switch(a[i]) {
			# Type
			case /^disk$/ : print "\033[38;5;6m\033[1m"; break
			case /^part$/ : print "\033[38;5;6m"; break
			case /^loop$/ : print "\033[38;5;1m"; break
			case /^lvm$/ : print "\033[38;5;4m"; break
			case /^crypt$/ : print "\033[38;5;5m"; break
			case /^\[SWAP\]$/ : print "\033[38;5;13m"; break
			# Size
			case /^[0-9].*K$/ : print "\033[38;5;2m"; break
			case /^[0-9].*M$/ : print "\033[38;5;3m"; break
			case /^[0-9].*G$/ : print "\033[38;5;1m"; break
			case /^[0-9].*T$/ : print "\033[38;5;9m"; break
			case /^\// :
				sub(/^.*\//, "\033[38;5;4m&\033[1m", a[i])
				break
			# tree
			case /^[├└─│\|\`\-]/ :
				sub(/[a-z]/, "\033[38;5;10m&", a[i])
				break
			case /^[a-z]/ : print "\033[1m"; break
		}
		print a[i] s[i] "\033[0m"
	}
	print "\n"
}

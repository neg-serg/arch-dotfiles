#!/usr/bin/env -S sed -E -f
s/^0/\x1b[38;5;8m&/
/^[1-9]/{
	s/^[^\t]+[K]/\x1b[38;5;2m&/;t file
	s/^[^\t]+[M]/\x1b[38;5;3m&/;t file
	s/^[^\t]+[G]/\x1b[38;5;1m&/;t file
	s/^[^\t]+[T]/\x1b[38;5;9m&/;t file
	s/^[^\t]+/\x1b[38;5;8m&/;t file
	:file
	s:\t(.*/)?:\x1b[38;5;4m&\x1b[1m:
}
s/$/\x1b[0m/

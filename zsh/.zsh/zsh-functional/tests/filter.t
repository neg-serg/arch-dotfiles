can remove odd numbers

  $ divisible_by_two () { (( $1%2 == 0 )) }
  $ filterf divisible_by_two {0..4}
  0
  2
  4

can grep out words

  $ filter 'echo $1 | grep a --silent' ab bc ac
  ab
  ac

can remove odd numbers

  $ filtera '$1%2 == 0' {0..4}
  0
  2
  4

filter can read from stdin

  $ print "ab\nbc\nac" | filter 'echo $1 | grep a --silent'
  ab
  ac

We should be able to get the first 10 primes. This is an important test that
shows that the lazy aspect of piping works.

  $ generator () { for ((i=2;;i+=1)); echo $i }
  $ sieve () { read first; echo $first; filtera "\$x%$first!=0" | sieve }
  $ generator | sieve | head
  2
  3
  5
  7
  11
  13
  17
  19
  23
  29

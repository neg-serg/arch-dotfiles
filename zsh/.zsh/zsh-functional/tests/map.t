can echo-append

  $ map '$1 day' good bad
  good day
  bad day

does arithmetic

  $ mapa '$1 + 5' {1..3}
  6
  7
  8

map can read from stdin

  $ print "good\nbad\ngood bad" | map '$1 day'
  good day
  bad day
  good bad day

mapa can read from stdin

  $ print "1\n2\n3" | mapa '$1 + 5'
  6
  7
  8

map also works with single argument

  $ map 'hello $1' abc
  hello abc

should never ever have an effect but printing

  $ touch a
  $ cat a
  $ map 'echo "hello world" > $1' a
  echo "hello world" > a
  $ cat a

should never ever have an effect but printing (again)

  $ echo hello > abc.in
  $ echo world > def.in
  $ touch abc.out def.out
  $ cat abc.out def.out
  $ map 'cat < $1 > ${1/in/out}' *.in
  cat < abc.in > abc.out
  cat < def.in > def.out

should never ever have an effect but printing (mapa)

  $ mapa '$1>5' 3 7
  0
  1

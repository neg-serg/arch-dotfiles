can add numbers

  $ plus_one () { echo $(($1+1)) }
  $ eachf plus_one {0..2}
  1
  2
  3

can only append

  $ eachf 'echo young' boy girl
  young boy
  young girl

can prepend

  $ each 'echo $1 day' good bad
  good day
  bad day

can use $x

  $ each 'echo $x day' good bad
  good day
  bad day

each can read from stdin

  $ print "good\nbad\ngood bad" | each 'echo $1 day'
  good day
  bad day
  good bad day

eachf can read from stdin

  $ plus_one () { echo $(($1+1)) }
  $ print "1\n2" | eachf plus_one
  2
  3

each with eval. The purpose of this test is check that it will treat 'echo hi'
as one argument and not as 'echo' 'hi'.

  $ each 'eval $1' 'echo hi' 'echo yo'
  hi
  yo

each with eval using stdin

  $ echo "echo hi\necho yo" | each 'eval $1'
  hi
  yo

each should stop on its first error

  $ each 'eval $1' 'return 0' 'return 4' 'return 5'; echo $?
  4
  $ echo "return 0\nreturn 4\nreturn 5" | each 'eval $1'; echo $?
  4

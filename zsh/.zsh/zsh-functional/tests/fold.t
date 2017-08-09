can sum numbers

  $ addition () { echo $(($1 + $2)) }
  $ foldf addition 0 {1..5}
  15

is not commutative

  $ ignore_acc () { echo $2 }
  $ foldf ignore_acc a b c d
  d

palindrome using mnemonic arguments

  $ fold 'echo $x$acc$x' MIDDLE - O o .
  .oO-MIDDLE-Oo.

palindrome using numbered arguments

  $ fold 'echo $2$1$2' MIDDLE - O o .
  .oO-MIDDLE-Oo.

can sum numbers

  $ folda '$1+$2' 0 {1..5}
  15

can sum numbers using mnemonic names

  $ folda '$x+$acc' 0 {1..5}
  15


Can define sum easily, but you must use positionally expanding arguments
syntax

  $ sum() { folda '$1+$2' 0 "$@" }
  $ sum {0..10}
  55
#  $ sum
#  0
# This test got disabled when the stdin feature was added, as now programs
# without any arguments will be run as interactive programs instead of
# thinkning no arguments as an empty list.


This is left fold, in haskell notation obeying
foldl f z [x1, x2, ..., xn] == (...((z `f` x1) `f` x2) `f`...) `f` xn

  $ fold 'echo "($acc <--> $x)"' z x1 x2
  ((z <--> x1) <--> x2)

Acc is $1 and x is $2

  $ fold 'echo "($1 <--> $2)"' z x1 x2
  ((z <--> x1) <--> x2)

folda can read from stdin

  $ print "1\n2\n3\n4" | folda '$1+$2' 0
  10

manual folda - this will test some sort escaping occurs

  $ fold 'echo $(( $1 * $2 ))' 1 2 3 4
  24
  $ fold 'echo $(( $1 * $x ))' 1 2 3 4
  24
  $ fold 'echo $(( $acc * $2 ))' 1 2 3 4
  24
  $ fold 'echo $(( $acc * $x ))' 1 2 3 4
  24
  $ fold 'echo $[ $1 * $2 ]' 1 2 3 4
  24
  $ fold 'echo $[ $1 * $x ]' 1 2 3 4
  24
  $ fold 'echo $[ $acc * $2 ]' 1 2 3 4
  24
  $ fold 'echo $[ $acc * $x ]' 1 2 3 4
  24

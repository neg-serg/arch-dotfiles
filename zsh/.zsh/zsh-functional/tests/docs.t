The documentation works for one of the functions at least

  $ map
  usage: map <lambda-function> [<item>...]
  
  example:
  ? map '<--- $1 --->' a b c d (glob)
  <--- a --->
  <--- b --->
  <--- c --->
  <--- d --->
  
  [1]

Actually it prints a '$' and not a '?', but cram thinks that it actually
should run the command if it's a $. sigh...

Now lets see if it still works if we do `setopt shwordsplit`

  $ setopt shwordsplit
  $ map
  usage: map <lambda-function> [<item>...]
  
  example:
  ? map '<--- $1 --->' a b c d (glob)
  <--- a ---> <--- b ---> <--- c ---> <--- d --->
  
  [1]

A TODO is to understand why the hell the result ends up on the same
line. Note that the actual function works, when I run that command the
output is on different lines. I tried to solve that godforsaken bug for
an hour but I gave up. God i hate ZSH >_<

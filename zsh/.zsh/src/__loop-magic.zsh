## Meta-programming file
##
## This file is supposed to be evaluated inside a function

local loopword
local myarray
myarray=()
if (($#>0))
then
  loopword='for x in $myarray'
  for x; myarray+=$x
else
  loopword='while read x'
fi
_zsh-functional_go () {
  eval "$loopword" "; do; $1 \$x; $2 ; done"
  return 0
}

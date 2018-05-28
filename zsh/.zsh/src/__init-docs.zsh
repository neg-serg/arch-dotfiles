if [[ $docsRecursionLevel > 5 ]]
then
  echo "ERROR: docs module might loop indefinetly"
  docsRecursionLevel=0
  return 1
fi

docsRecursionLevel=$[ docsRecursionLevel + 1 ]

function_name=$0
function_params=$@
function_num_params=$#
did_fail=0
docs_var=""

docs () {
  docs_var+="$@\n"
}

usage() {
  params=$@
  required_num_params=0 # TODO: make more sophisticated
  for param in ${=params}
  do
    param_is_singleton $param && required_num_params=$[ $required_num_params + 1 ]
  done
  docs "usage: $function_name $params"
  docs
  if (( $function_num_params < $required_num_params ))
  then
    did_fail=1
  fi
}

example() {
  if [[ $did_fail == 1 ]]
  then
    docs "example:"
    docs "$ $function_name $@"
    result="$(eval "$function_name $@")"
    docs "$result"
  fi
}

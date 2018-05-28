docsRecursionLevel=$[ $docsRecursionLevel - 1 ]

if [[ $did_fail > 0 ]]
then
  print $docs_var
  return 1
fi

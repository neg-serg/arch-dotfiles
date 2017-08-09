#!/bin/zsh

ZSH_FUNCTIONAL_BASEDIR=$0:h/src

fpath+=($ZSH_FUNCTIONAL_BASEDIR)

# Ensure Docs are loaded
. ${ZSH_FUNCTIONAL_BASEDIR}/docs.zsh

# Load metafunction
. ${ZSH_FUNCTIONAL_BASEDIR}/loop-magic.zsh

# Load functions
for funcname in ${ZSH_FUNCTIONAL_BASEDIR}/{each{,f},filter{,f,a},fold{,a,f,right},map{,a},param_is_{constant_if_at_all,singleton}}(:t)
do
  autoload $funcname
done

# This is a very hackish way to get a decently clean syntax for looping through
# either $@ (the arguments) or stdin if $# is 0 (there is none)
#
# Please see the other files for how to use this monster.
initGo=$(<${ZSH_FUNCTIONAL_BASEDIR}/__loop-magic.zsh)
loopNow="$initGo; _zsh-functional_go"
